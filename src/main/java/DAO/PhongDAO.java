/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import model_POJO.Phong;
import utils.DatabaseHelper;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PhongDAO {
    
    // Lấy danh sách tất cả các phòng
    public List<Phong> getAll() {
        List<Phong> list = new ArrayList<>();
        String sql = "SELECT * FROM phong";
        
        try (Connection conn = DatabaseHelper.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                Phong p = new Phong();
                p.setMaPhong(rs.getLong("MaPhong"));
                p.setSoPhong(rs.getString("SoPhong"));
                p.setMaLoaiPhong(rs.getLong("MaLoaiPhong"));
                p.setTrangThai(rs.getString("TrangThai"));
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Thêm một phòng mới
    public boolean insert(Phong p) {
        String sql = "INSERT INTO phong (SoPhong, MaLoaiPhong, TrangThai) VALUES (?, ?, ?)";
        try (Connection conn = DatabaseHelper.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, p.getSoPhong());
            pstmt.setLong(2, p.getMaLoaiPhong());
            pstmt.setString(3, p.getTrangThai());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Cập nhật thông tin phòng
    public boolean update(Phong p) {
        String sql = "UPDATE phong SET SoPhong = ?, MaLoaiPhong = ?, TrangThai = ? WHERE MaPhong = ?";
        try (Connection conn = DatabaseHelper.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, p.getSoPhong());
            pstmt.setLong(2, p.getMaLoaiPhong());
            pstmt.setString(3, p.getTrangThai());
            pstmt.setLong(4, p.getMaPhong());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Xóa một phòng theo MaPhong
    public boolean delete(long maPhong) {
        String sql = "DELETE FROM phong WHERE MaPhong = ?";
        try (Connection conn = DatabaseHelper.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setLong(1, maPhong);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
