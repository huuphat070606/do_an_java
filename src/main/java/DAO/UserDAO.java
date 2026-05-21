/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import model_POJO.User;
import utils.DatabaseHelper;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    // Lấy danh sách tất cả user
    public List<User> getAll() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM user";
        
        try (Connection conn = DatabaseHelper.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                User u = new User();
                u.setMaUser(rs.getLong("MaUser"));
                u.setVaiTro(rs.getString("VaiTro"));
                u.setHoTen(rs.getString("HoTen"));
                u.setSoDienThoai(rs.getString("SoDienThoai"));
                u.setEmail(rs.getString("Email"));
                u.setSoCCCD(rs.getString("SoCCCD"));
                u.setAnhCCCD(rs.getString("AnhCCCD"));
                u.setPassword(rs.getString("Password"));
                u.setUsername(rs.getString("Username"));
                list.add(u);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Thêm một user mới
    public boolean insert(User u) {
        String sql = "INSERT INTO user (VaiTro, HoTen, SoDienThoai, Email, SoCCCD, AnhCCCD, Password, Username) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseHelper.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, u.getVaiTro());
            pstmt.setString(2, u.getHoTen());
            pstmt.setString(3, u.getSoDienThoai());
            pstmt.setString(4, u.getEmail());
            pstmt.setString(5, u.getSoCCCD());
            pstmt.setString(6, u.getAnhCCCD());
            pstmt.setString(7, u.getPassword());
            pstmt.setString(8, u.getUsername());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Cập nhật thông tin user
    public boolean update(User u) {
        String sql = "UPDATE user SET VaiTro = ?, HoTen = ?, SoDienThoai = ?, Email = ?, SoCCCD = ?, " +
                     "AnhCCCD = ?, Password = ?, Username = ? WHERE MaUser = ?";
        try (Connection conn = DatabaseHelper.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, u.getVaiTro());
            pstmt.setString(2, u.getHoTen());
            pstmt.setString(3, u.getSoDienThoai());
            pstmt.setString(4, u.getEmail());
            pstmt.setString(5, u.getSoCCCD());
            pstmt.setString(6, u.getAnhCCCD());
            pstmt.setString(7, u.getPassword());
            pstmt.setString(8, u.getUsername());
            pstmt.setLong(9, u.getMaUser());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Xóa một user theo MaUser
    public boolean delete(long maUser) {
        String sql = "DELETE FROM user WHERE MaUser = ?";
        try (Connection conn = DatabaseHelper.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setLong(1, maUser);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
