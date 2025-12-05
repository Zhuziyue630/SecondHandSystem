package com.secondhand.controller;

import com.secondhand.entity.Item;
import com.secondhand.service.ItemService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet("/item/*")
public class ItemServlet extends HttpServlet {
    private ItemService itemService = new ItemService();
    private SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getPathInfo();

        if (action == null || action.equals("/")) {
            listItems(request, response);
            return;
        }

        switch (action) {
            case "/list":
                listItems(request, response);
                break;
            case "/add":
                showAddForm(request, response);
                break;
            case "/edit":
                showEditForm(request, response);
                break;
            case "/delete":
                deleteItem(request, response);
                break;
            case "/search":
                searchItems(request, response);
                break;
            case "/detail":
                showDetail(request, response);
                break;
            case "/mylist":
                myItems(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getPathInfo();

        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/item/list");
            return;
        }

        switch (action) {
            case "/add":
                addItem(request, response);
                break;
            case "/edit":
                updateItem(request, response);
                break;
            case "/search":
                searchItems(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void listItems(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Item> items = itemService.getAllItems();
        request.setAttribute("items", items);
        request.getRequestDispatcher("/views/item/list.jsp").forward(request, response);
    }

    private void myItems(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/user/login");
            return;
        }

        List<Item> items = itemService.getUserItems(userId);
        request.setAttribute("items", items);
        request.getRequestDispatcher("/views/item/mylist.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/item/add.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Item item = itemService.getItemById(id);

            if (item != null) {
                request.setAttribute("item", item);
                request.getRequestDispatcher("/views/item/edit.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/item/mylist");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/item/mylist");
        }
    }

    private void showDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Item item = itemService.getItemById(id);

            if (item != null) {
                request.setAttribute("item", item);
                request.getRequestDispatcher("/views/item/detail.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/item/list");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/item/list");
        }
    }

    private void addItem(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/user/login");
            return;
        }

        try {
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            int itemType = Integer.parseInt(request.getParameter("itemType"));
            String location = request.getParameter("location");
            Date foundLostDate = dateFormat.parse(request.getParameter("foundLostDate"));
            String imageUrl = request.getParameter("imageUrl");

            if (imageUrl == null || imageUrl.trim().isEmpty()) {
                imageUrl = "default.jpg"; // 默认图片
            }

            Item item = new Item();
            item.setUserId(userId);
            item.setTitle(title);
            item.setDescription(description);
            item.setItemType(itemType);
            item.setLocation(location);
            item.setFoundLostDate(foundLostDate);
            item.setImageUrl(imageUrl);

            if (itemService.publishItem(item)) {
                response.sendRedirect(request.getContextPath() + "/item/mylist");
            } else {
                request.setAttribute("error", "发布失败，请重试");
                request.getRequestDispatcher("/views/item/add.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "数据格式错误：" + e.getMessage());
            request.getRequestDispatcher("/views/item/add.jsp").forward(request, response);
        }
    }

    private void updateItem(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/user/login");
            return;
        }

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            int itemType = Integer.parseInt(request.getParameter("itemType"));
            String location = request.getParameter("location");
            Date foundLostDate = dateFormat.parse(request.getParameter("foundLostDate"));
            String imageUrl = request.getParameter("imageUrl");

            Item item = new Item();
            item.setId(id);
            item.setUserId(userId);
            item.setTitle(title);
            item.setDescription(description);
            item.setItemType(itemType);
            item.setLocation(location);
            item.setFoundLostDate(foundLostDate);
            item.setImageUrl(imageUrl);

            if (itemService.updateItem(item)) {
                response.sendRedirect(request.getContextPath() + "/item/mylist");
            } else {
                request.setAttribute("error", "更新失败，请重试");
                showEditForm(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "数据格式错误：" + e.getMessage());
            showEditForm(request, response);
        }
    }

    private void deleteItem(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/user/login");
            return;
        }

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            itemService.deleteItem(id, userId);
        } catch (NumberFormatException e) {
            // 忽略错误
        }
        response.sendRedirect(request.getContextPath() + "/item/mylist");
    }

    private void searchItems(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        String typeStr = request.getParameter("itemType");

        Integer itemType = null;
        if (typeStr != null && !typeStr.trim().isEmpty()) {
            try {
                itemType = Integer.parseInt(typeStr);
            } catch (NumberFormatException e) {
                // 保持为null
            }
        }

        List<Item> items = itemService.searchItems(keyword, itemType);
        request.setAttribute("items", items);
        request.setAttribute("keyword", keyword);
        request.setAttribute("itemType", itemType);
        request.getRequestDispatcher("/views/item/list.jsp").forward(request, response);
    }
}