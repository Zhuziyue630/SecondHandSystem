package com.secondhand.service;

import com.secondhand.entity.User;
import com.secondhand.dao.UserDAO;

public class UserService {
    private final UserDAO userDAO = new UserDAO();

    public boolean register(User user) {
        if (userDAO.isUsernameExist(user.getUsername())) {
            return false;
        }
        return userDAO.addUser(user);
    }

    public User login(String username, String password) {
        return userDAO.validateUser(username, password);
    }

    public boolean checkUsernameExist(String username) {
        return userDAO.isUsernameExist(username);
    }
}