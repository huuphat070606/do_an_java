DELIMITER //
CREATE TRIGGER trg_calculate_service_order_price
BEFORE INSERT ON lichsudichvu
FOR EACH ROW
BEGIN
    DECLARE v_price DECIMAL(10,2);
    
    -- Lấy đơn giá của dịch vụ từ bảng dichvu
    SELECT DonGia INTO v_price FROM dichvu WHERE MaDichVu = NEW.MaDichVu;
    
    -- Tự động tính tổng tiền
    SET NEW.TongTien = NEW.SoLuong * v_price;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER trg_calculate_damage_compensation
BEFORE INSERT ON denbu
FOR EACH ROW
BEGIN
    DECLARE v_comp_value DECIMAL(10,2);
    
    -- Lấy giá trị đền bù định mức từ bảng loaithietbi liên kết qua bảng thietbi
    SELECT lt.GiaTriDenBu INTO v_comp_value 
    FROM thietbi t
    JOIN loaithietbi lt ON t.MaLoaiThietBi = lt.MaLoaiThietBi
    WHERE t.MaThietBi = NEW.MaThietBi;
    
    -- Tự động tính hoặc gán số tiền đền bù thực tế nếu chưa được nhập hoặc bằng 0
    IF NEW.SoTienDenBuThucTe IS NULL OR NEW.SoTienDenBuThucTe = 0 THEN
        SET NEW.SoTienDenBuThucTe = v_comp_value;
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER trg_sync_room_status
AFTER UPDATE ON datphong
FOR EACH ROW
BEGIN
    -- Nếu trạng thái đặt phòng chuyển sang 'Checked_In' -> cập nhật phòng sang 'Đã được thuê'
    IF NEW.TrangThai = 'Checked_In' AND OLD.TrangThai != 'Checked_In' THEN
        UPDATE phong SET TrangThai = 'Đã được thuê' WHERE MaPhong = NEW.MaPhong;
    -- Nếu trạng thái đặt phòng chuyển sang 'Checked_Out' -> cập nhật phòng sang 'Cần dọn dẹp'
    ELSEIF NEW.TrangThai = 'Checked_Out' AND OLD.TrangThai != 'Checked_Out' THEN
        UPDATE phong SET TrangThai = 'Cần dọn dẹp' WHERE MaPhong = NEW.MaPhong;
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_ProcessCheckIn(
    IN p_datphong_id BIGINT,
    IN p_phong_id BIGINT
)
BEGIN
    -- Bắt đầu Transaction
    START TRANSACTION;
    
    -- 1. Cập nhật thông tin đặt phòng thực tế sang Checked_In
    UPDATE datphong 
    SET MaPhong = p_phong_id, 
        CheckIn_ThucTe = NOW(), 
        TrangThai = 'Checked_In'
    WHERE MaDatPhong = p_datphong_id AND TrangThai = 'Xac nhan';
    
    -- (Trạng thái bảng 'phong' sẽ tự động chuyển sang 'Đã được thuê' nhờ trigger trg_sync_room_status ở trên)
    
    COMMIT;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_ProcessCheckOut(
    IN p_datphong_id BIGINT,
    IN p_tien_phong DECIMAL(10,2), -- Tiền phòng thường do ứng dụng Java tính dựa trên số ngày lưu trú thực tế
    IN p_phuong_thuc_thanh_toan VARCHAR(50)
)
BEGIN
    DECLARE v_service_charge DECIMAL(10,2) DEFAULT 0;
    DECLARE v_damage_charge DECIMAL(10,2) DEFAULT 0;
    DECLARE v_deposit_amount DECIMAL(10,2) DEFAULT 0;
    DECLARE v_grand_total DECIMAL(10,2) DEFAULT 0;

    START TRANSACTION;

    -- 1. Tính tổng tiền dịch vụ khách sử dụng từ lichsudichvu
    SELECT COALESCE(SUM(TongTien), 0) INTO v_service_charge 
    FROM lichsudichvu WHERE MaDatPhong = p_datphong_id;

    -- 2. Tính tổng tiền phạt đền bù hư hỏng thiết bị từ denbu
    SELECT COALESCE(SUM(SoTienDenBuThucTe), 0) INTO v_damage_charge 
    FROM denbu WHERE MaDatPhong = p_datphong_id;

    -- 3. Lấy tổng số tiền khách đã đặt cọc trước đó từ giaodichcoctien
    SELECT COALESCE(SUM(SoTienCoc), 0) INTO v_deposit_amount 
    FROM giaodichcoctien WHERE MaDatPhong = p_datphong_id;

    -- 4. Tính tổng tiền dịch vụ (bao gồm cả đền bù) và tổng tiền cuối cùng phải trả
    SET v_service_charge = v_service_charge + v_damage_charge;
    SET v_grand_total = p_tien_phong + v_service_charge - v_deposit_amount;

    -- 5. Tạo Hóa đơn (hoadon) mới với trạng thái 'Đã thanh toán'
    INSERT INTO hoadon (
        MaDatPhong, 
        TienPhong, 
        TienDichVu, 
        TienKhachCoc, 
        TongTienPhaiTra, 
        TrangThai, 
        PhuongThucThanhToan, 
        created_at
    )
    VALUES (
        p_datphong_id, 
        p_tien_phong, 
        v_service_charge, 
        v_deposit_amount, 
        v_grand_total, 
        'Đã thanh toán', 
        p_phuong_thuc_thanh_toan, 
        NOW()
    );

    -- 6. Cập nhật thông tin CheckOut thực tế và chuyển trạng thái đặt phòng sang 'Checked_Out'
    UPDATE datphong 
    SET CheckOut_ThucTe = NOW(), 
        TrangThai = 'Checked_Out' 
    WHERE MaDatPhong = p_datphong_id;
    
    -- (Trạng thái phòng trong bảng 'phong' sẽ tự động chuyển sang 'Cần dọn dẹp' nhờ trigger trg_sync_room_status ở trên)
    
    COMMIT;
END //
DELIMITER ;