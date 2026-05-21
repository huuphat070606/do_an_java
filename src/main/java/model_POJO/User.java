/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package model_POJO;

public class User {
    private long maUser;
    private String vaiTro;
    private String hoTen;
    private String soDienThoai;
    private String email;
    private String soCCCD;
    private String anhCCCD;
    private String password;
    private String username;

    public User() {}

    public User(long maUser, String vaiTro, String hoTen, String soDienThoai, String email, 
                String soCCCD, String anhCCCD, String password, String username) {
        this.maUser = maUser;
        this.vaiTro = vaiTro;
        this.hoTen = hoTen;
        this.soDienThoai = soDienThoai;
        this.email = email;
        this.soCCCD = soCCCD;
        this.anhCCCD = anhCCCD;
        this.password = password;
        this.username = username;
    }

    // Getters and Setters
    public long getMaUser() { return maUser; }
    public void setMaUser(long maUser) { this.maUser = maUser; }

    public String getVaiTro() { return vaiTro; }
    public void setVaiTro(String vaiTro) { this.vaiTro = vaiTro; }

    public String getHoTen() { return hoTen; }
    public void setHoTen(String hoTen) { this.hoTen = hoTen; }

    public String getSoDienThoai() { return soDienThoai; }
    public void setSoDienThoai(String soDienThoai) { this.soDienThoai = soDienThoai; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getSoCCCD() { return soCCCD; }
    public void setSoCCCD(String soCCCD) { this.soCCCD = soCCCD; }

    public String getAnhCCCD() { return anhCCCD; }
    public void setAnhCCCD(String anhCCCD) { this.anhCCCD = anhCCCD; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
}
