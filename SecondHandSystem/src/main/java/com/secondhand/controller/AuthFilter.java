package com.secondhand.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/item/*")  // 只过滤物品相关路径
public class AuthFilter implements Filter {
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;

        // 不需要登录的路径
        String path = request.getServletPath();
        if (path.startsWith("/item/list") || path.startsWith("/item/detail") || path.startsWith("/item/search")) {
            chain.doFilter(req, resp);
            return;
        }

        // 检查登录
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/user/login");
            return;
        }

        chain.doFilter(req, resp);
    }
}