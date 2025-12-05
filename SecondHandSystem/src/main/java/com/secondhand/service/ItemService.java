package com.secondhand.service;

import com.secondhand.entity.Item;
import com.secondhand.dao.ItemDAO;
import java.util.List;

public class ItemService {
    private final ItemDAO itemDAO = new ItemDAO();

    public boolean publishItem(Item item) {
        return itemDAO.addItem(item);
    }

    public boolean updateItem(Item item) {
        return itemDAO.updateItem(item);
    }

    public boolean deleteItem(int itemId, int userId) {
        return itemDAO.deleteItem(itemId, userId);
    }

    public Item getItemById(int id) {
        return itemDAO.getItemById(id);
    }

    public List<Item> getUserItems(int userId) {
        return itemDAO.getItemsByUser(userId);
    }

    public List<Item> getAllItems() {
        return itemDAO.getAllItems();
    }

    public List<Item> searchItems(String keyword, Integer itemType) {
        return itemDAO.searchItems(keyword, itemType);
    }
}