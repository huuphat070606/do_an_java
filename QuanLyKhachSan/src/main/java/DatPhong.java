package dao;

import java.sql.Timestamp;

public class DatPhong {
    private int maKhachHang;
    private int maPhong;
    private String maLoaiPhong;
    private String nguonDatPhong;
    private Timestamp checkInDuKien;
    private Timestamp checkOutDuKien;

    // Các hàm Getters để BookingDAO gọi dữ liệu
    public int getMaKhachHang() { return maKhachHang; }
    public int getMaPhong() { return maPhong; }
    public String getMaLoaiPhong() { return maLoaiPhong; }
    public String getNguonDatPhong() { return nguonDatPhong; }
    public Timestamp getCheckInDuKien() { return checkInDuKien; }
    public Timestamp getCheckOutDuKien() { return checkOutDuKien; }

    // Các hàm Setters (nếu cần dùng sau này)
    public void setMaKhachHang(int maKhachHang) { this.maKhachHang = maKhachHang; }
    public void setMaPhong(int maPhong) { this.maPhong = maPhong; }
    public void setMaLoaiPhong(String maLoaiPhong) { this.maLoaiPhong = maLoaiPhong; }
    public void setNguonDatPhong(String nguonDatPhong) { this.nguonDatPhong = nguonDatPhong; }
    public void setCheckInDuKien(Timestamp checkInDuKien) { this.checkInDuKien = checkInDuKien; }
    public void setCheckOutDuKien(Timestamp checkOutDuKien) { this.checkOutDuKien = checkOutDuKien; }
}