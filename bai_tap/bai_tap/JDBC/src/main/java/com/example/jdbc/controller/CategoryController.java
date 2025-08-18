package com.example.jdbc.controller;

import com.example.jdbc.entity.Category;
import com.example.jdbc.service.CategoryService;
import com.example.jdbc.service.ICategoryService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "CategoryController", value = "/categories")
public class CategoryController extends HttpServlet {
    private final ICategoryService service = new CategoryService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "create":
                req.setAttribute("mode", "create");
                req.getRequestDispatcher("/views/category/form.jsp").forward(req, resp);
                break;

            case "edit":
                showEdit(req, resp);
                break;

            case "view":
                showView(req, resp);
                break;

            case "delete":
                delete(req, resp);
                break;

            case "search":
                list(req, resp, true);
                break;

            case "list":
            default:
                list(req, resp, false);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "create":
                create(req, resp);
                break;
            case "edit":
                update(req, resp);
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/categories?action=list");
        }
    }

    private void list(HttpServletRequest req, HttpServletResponse resp, boolean isSearch)
            throws ServletException, IOException {
        String q = isSearch ? req.getParameter("q") : null;
        List<Category> categories = (q == null) ? service.getAll() : service.search(q);
        req.setAttribute("categories", categories);
        req.setAttribute("q", q == null ? "" : q);
        req.getRequestDispatcher("/views/category/list.jsp").forward(req, resp);
    }

    private void showEdit(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        int id = parseInt(req.getParameter("id"), -1);
        Category c = service.getById(id);
        if (c == null) {
            resp.sendRedirect(req.getContextPath() + "/categories?action=list");
            return;
        }
        req.setAttribute("mode", "edit");
        req.setAttribute("category", c);
        req.getRequestDispatcher("/views/category/form.jsp").forward(req, resp);
    }

    private void showView(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        int id = parseInt(req.getParameter("id"), -1);
        Category c = service.getById(id);
        if (c == null) {
            resp.sendRedirect(req.getContextPath() + "/categories?action=list");
            return;
        }
        req.setAttribute("category", c);
        req.getRequestDispatcher("/views/category/view.jsp").forward(req, resp);
    }

    private void create(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String name = req.getParameter("name");
        if (name == null || name.trim().isEmpty()) {
            req.setAttribute("mode", "create");
            req.setAttribute("error", "Tên danh mục không được trống.");
            try { req.getRequestDispatcher("/views/category/form.jsp").forward(req, resp); } catch (IllegalStateException ignore) {}
            return;
        }
        service.create(name.trim());
        resp.sendRedirect(req.getContextPath() + "/categories?action=list");
    }

    private void update(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        int id = parseInt(req.getParameter("id"), -1);
        String name = req.getParameter("name");
        if (id <= 0 || name == null || name.trim().isEmpty()) {
            req.setAttribute("mode", "edit");
            req.setAttribute("error", "Dữ liệu không hợp lệ.");
            Category c = service.getById(id);
            if (c != null) req.setAttribute("category", c);
            try { req.getRequestDispatcher("/views/category/form.jsp").forward(req, resp); } catch (IllegalStateException ignore) {}
            return;
        }
        service.update(id, name.trim());
        resp.sendRedirect(req.getContextPath() + "/categories?action=list");
    }

    private void delete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int id = parseInt(req.getParameter("id"), -1);
        service.delete(id);
        resp.sendRedirect(req.getContextPath() + "/categories?action=list");
    }

    private int parseInt(String s, int def) {
        try { return Integer.parseInt(s); } catch (Exception e) { return def; }
    }
}