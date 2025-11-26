package com.mycompany.quanlythuvien.dao;

import com.mycompany.quanlythuvien.model.Borrowing;
import com.mycompany.quanlythuvien.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class BorrowingDAO {


    public int addBorrowing(Borrowing borrowing) {
        String sql = "INSERT INTO borrowings (user_id, borrow_date, due_date, status) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, borrowing.getUserId());
            ps.setDate(2, borrowing.getBorrowDate());
            ps.setDate(3, borrowing.getDueDate());
            ps.setString(4, borrowing.getStatus());
            ps.executeUpdate();
            
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public void addBorrowingDetail(int borrowingId, int bookId) {
        String sql = "INSERT INTO borrowing_details (borrowing_id, book_id) VALUES (?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, borrowingId);
            ps.setInt(2, bookId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    public List<Borrowing> getAllBorrowings() {
        List<Borrowing> list = new ArrayList<>();
        String sql = "SELECT b.*, u.full_name FROM borrowings b JOIN users u ON b.user_id = u.id ORDER BY b.id DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Borrowing b = new Borrowing();
                b.setId(rs.getInt("id"));
                b.setUserId(rs.getInt("user_id"));
                b.setBorrowDate(rs.getDate("borrow_date"));
                b.setDueDate(rs.getDate("due_date"));
                b.setStatus(rs.getString("status"));
                b.setUserFullName(rs.getString("full_name"));
                list.add(b);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateBorrowingStatus(int borrowingId, String status) {
        String sql = "UPDATE borrowings SET status = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, borrowingId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public List<Integer> getBookIdsByBorrowingId(int borrowingId) {
        List<Integer> bookIds = new ArrayList<>();
        String sql = "SELECT book_id FROM borrowing_details WHERE borrowing_id = ?";
        try (Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, borrowingId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                bookIds.add(rs.getInt("book_id"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookIds;
    }

    public List<Borrowing> getBorrowingsByUserId(int userId) {
        List<Borrowing> list = new ArrayList<>();
        String sql = "SELECT * FROM borrowings WHERE user_id = ? ORDER BY id DESC";
        try (Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Borrowing b = new Borrowing();
                b.setId(rs.getInt("id"));
                b.setUserId(rs.getInt("user_id"));
                b.setBorrowDate(rs.getDate("borrow_date"));
                b.setDueDate(rs.getDate("due_date"));
                b.setStatus(rs.getString("status"));
                list.add(b);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }
    public Map<String, Integer> getBorrowingDetails(int borrowingId) {
        Map<String, Integer> bookDetails = new HashMap<>();
        String sql = "SELECT b.title, COUNT(bd.book_id) as quantity " +
                    "FROM borrowing_details bd " +
                    "JOIN books b ON bd.book_id = b.id " +
                    "WHERE bd.borrowing_id = ? " +
                    "GROUP BY b.title";
        try (Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, borrowingId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                bookDetails.put(rs.getString("title"), rs.getInt("quantity"));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return bookDetails;
    }
    public boolean isBorrowingOwner(int borrowingId, int userId) {
        String sql = "SELECT COUNT(*) FROM borrowings WHERE id = ? AND user_id = ?";
        try (Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, borrowingId);
            ps.setInt(2, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}