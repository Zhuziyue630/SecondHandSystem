package com.secondhand.dao;

import com.secondhand.entity.Item;
import com.secondhand.util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ItemDAO {

    public boolean addItem(Item item) {
        String sql = "INSERT INTO items(user_id, title, description, item_type, location, found_lost_date, image_url) VALUES(?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, item.getUserId());
            pstmt.setString(2, item.getTitle());
            pstmt.setString(3, item.getDescription());
            pstmt.setInt(4, item.getItemType());
            pstmt.setString(5, item.getLocation());
            pstmt.setDate(6, new java.sql.Date(item.getFoundLostDate().getTime()));
            pstmt.setString(7, item.getImageUrl());

            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateItem(Item item) {
        String sql = "UPDATE items SET title=?, description=?, item_type=?, location=?, found_lost_date=?, image_url=? WHERE id=? AND user_id=?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, item.getTitle());
            pstmt.setString(2, item.getDescription());
            pstmt.setInt(3, item.getItemType());
            pstmt.setString(4, item.getLocation());
            pstmt.setDate(5, new java.sql.Date(item.getFoundLostDate().getTime()));
            pstmt.setString(6, item.getImageUrl());
            pstmt.setInt(7, item.getId());
            pstmt.setInt(8, item.getUserId());

            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteItem(int itemId, int userId) {
        String sql = "UPDATE items SET status = 0 WHERE id = ? AND user_id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, itemId);
            pstmt.setInt(2, userId);

            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Item getItemById(int id) {
        String sql = "SELECT i.*, u.username FROM items i LEFT JOIN users u ON i.user_id = u.id WHERE i.id = ? AND i.status = 1";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                return extractItem(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Item> getItemsByUser(int userId) {
        List<Item> items = new ArrayList<>();
        String sql = "SELECT i.*, u.username FROM items i LEFT JOIN users u ON i.user_id = u.id WHERE i.user_id = ? AND i.status = 1 ORDER BY i.create_time DESC";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                items.add(extractItem(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return items;
    }

    public List<Item> getAllItems() {
        List<Item> items = new ArrayList<>();
        String sql = "SELECT i.*, u.username FROM items i LEFT JOIN users u ON i.user_id = u.id WHERE i.status = 1 ORDER BY i.create_time DESC";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                items.add(extractItem(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return items;
    }

    public List<Item> searchItems(String keyword, Integer itemType) {
        List<Item> items = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT i.*, u.username FROM items i LEFT JOIN users u ON i.user_id = u.id WHERE i.status = 1");

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (i.title LIKE ? OR i.description LIKE ? OR i.location LIKE ?)");
        }

        if (itemType != null) {
            sql.append(" AND i.item_type = ?");
        }

        sql.append(" ORDER BY i.create_time DESC");

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {

            int paramIndex = 1;
            if (keyword != null && !keyword.trim().isEmpty()) {
                String likeKeyword = "%" + keyword + "%";
                pstmt.setString(paramIndex++, likeKeyword);
                pstmt.setString(paramIndex++, likeKeyword);
                pstmt.setString(paramIndex++, likeKeyword);
            }

            if (itemType != null) {
                pstmt.setInt(paramIndex, itemType);
            }

            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                items.add(extractItem(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return items;
    }

    private Item extractItem(ResultSet rs) throws SQLException {
        Item item = new Item();
        item.setId(rs.getInt("id"));
        item.setUserId(rs.getInt("user_id"));
        item.setTitle(rs.getString("title"));
        item.setDescription(rs.getString("description"));
        item.setItemType(rs.getInt("item_type"));
        item.setLocation(rs.getString("location"));
        item.setFoundLostDate(rs.getDate("found_lost_date"));
        item.setImageUrl(rs.getString("image_url"));
        item.setStatus(rs.getInt("status"));
        item.setCreateTime(rs.getTimestamp("create_time"));
        item.setUpdateTime(rs.getTimestamp("update_time"));
        item.setUsername(rs.getString("username"));
        return item;
    }
}