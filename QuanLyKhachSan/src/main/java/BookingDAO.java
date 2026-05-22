package dao;

import java.sql.*;
import utils.DatabaseConnection; 

public class BookingDAO {

    // 1. Hàm tạo mới một đơn đặt phòng
    public boolean taoDatPhong(DatPhong dp) {
        String sql = "INSERT INTO datphong (MaKhachHang, MaPhong, MaLoaiPhong, NguonDatPhong, CheckIn_DuKien, CheckOut_DuKien, TrangThai) VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try {
            Connection conn = DatabaseConnection.getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                
                ps.setInt(1, dp.getMaKhachHang());
                
                if (dp.getMaPhong() == 0) { 
                    ps.setNull(2, java.sql.Types.INTEGER);
                } else {
                    ps.setInt(2, dp.getMaPhong());
                }
                
                ps.setString(3, dp.getMaLoaiPhong());
                ps.setString(4, dp.getNguonDatPhong());
                ps.setTimestamp(5, dp.getCheckInDuKien());
                ps.setTimestamp(6, dp.getCheckOutDuKien());
                ps.setString(7, "ChoCheckIn"); 
                
                return ps.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // 2. Hàm xử lý tự động khi khách CHECK-IN
    public boolean ghiLogCheckIn(int maDatPhong) {
        String sql = "UPDATE datphong SET CheckIn_ThucTe = ?, TrangThai = ? WHERE MaDatPhong = ?";
        
        try {
            Connection conn = DatabaseConnection.getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                
                Timestamp thoiGianHienTai = new Timestamp(System.currentTimeMillis());
                
                ps.setTimestamp(1, thoiGianHienTai);
                ps.setString(2, "DaCheckIn"); 
                ps.setInt(3, maDatPhong);
                
                return ps.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // 3. Hàm xử lý tự động khi khách CHECK-OUT
    public boolean ghiLogCheckOut(int maDatPhong) {
        String sql = "UPDATE datphong SET CheckOut_ThucTe = ?, TrangThai = ? WHERE MaDatPhong = ?";
        
        try {
            Connection conn = DatabaseConnection.getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                
                Timestamp thoiGianHienTai = new Timestamp(System.currentTimeMillis());
                
                ps.setTimestamp(1, thoiGianHienTai);
                ps.setString(2, "DaCheckOut");
                ps.setInt(3, maDatPhong);
                
                return ps.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}