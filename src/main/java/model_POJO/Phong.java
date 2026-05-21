/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package model_POJO;

public class Phong {
    private long maPhong;
    private String soPhong;
    private long maLoaiPhong;
    private String trangThai;

    public Phong() {}

    public Phong(long maPhong, String soPhong, long maLoaiPhong, String trangThai) {
        this.maPhong = maPhong;
        this.soPhong = soPhong;
        this.maLoaiPhong = maLoaiPhong;
        this.trangThai = trangThai;
    }

    // Getters and Setters
    public long getMaPhong() { return maPhong; }
    public void setMaPhong(long maPhong) { this.maPhong = maPhong; }

    public String getSoPhong() { return soPhong; }
    public void setSoPhong(String soPhong) { this.soPhong = soPhong; }

    public long getMaLoaiPhong() { return maLoaiPhong; }
    public void setMaLoaiPhong(long maLoaiPhong) { this.maLoaiPhong = maLoaiPhong; }

    public String getTrangThai() { return trangThai; }
    public void setTrangThai(String trangThai) { this.trangThai = trangThai; }
}
