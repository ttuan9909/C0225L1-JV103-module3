package com.example.jdbc.controller;

import com.example.jdbc.dto.ProductDto;
import com.example.jdbc.entity.Product;
import com.example.jdbc.service.IProductService;
import com.example.jdbc.service.ProductService;

// ↓ Nếu bạn đã có CategoryService/ICategoryService thì giữ lại import tương ứng
import com.example.jdbc.entity.Category;
import com.example.jdbc.service.ICategoryService;
import com.example.jdbc.service.CategoryService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProductController", value = "/products")
public class ProductController extends HttpServlet {
    private final IProductService service = new ProductService();

    // ✅ Service để lấy danh sách category hiển thị ra select
    private final ICategoryService categoryService = new CategoryService();

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
                preloadCategories(req); // nạp danh sách category cho form
                req.getRequestDispatcher("/views/form.jsp").forward(req, resp);
                break;

            case "edit":
                showEditForm(req, resp);
                break;

            case "view":
                showDetail(req, resp);
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
                resp.sendRedirect(req.getContextPath() + "/products?action=list");
        }
    }

    private void list(HttpServletRequest req, HttpServletResponse resp, boolean isSearch)
            throws ServletException, IOException {
        String q = isSearch ? req.getParameter("q") : null;
        List<ProductDto> products = (q == null) ? service.findAll() : service.search(q);
        req.setAttribute("products", products);
        req.setAttribute("q", q == null ? "" : q);
        req.getRequestDispatcher("/views/list.jsp").forward(req, resp);
    }

    private void showEditForm(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        int id = parseInt(req.getParameter("id"), -1);
        ProductDto p = service.getById(id);
        if (p == null) {
            resp.sendRedirect(req.getContextPath() + "/products?action=list");
            return;
        }
        req.setAttribute("mode", "edit");
        req.setAttribute("product", p);
        preloadCategories(req); // nạp danh sách category cho select
        req.getRequestDispatcher("/views/form.jsp").forward(req, resp);
    }

    private void showDetail(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        int id = parseInt(req.getParameter("id"), -1);
        ProductDto p = service.getById(id);
        if (p == null) {
            resp.sendRedirect(req.getContextPath() + "/products?action=list");
            return;
        }
        req.setAttribute("product", p);
        req.getRequestDispatcher("/views/view.jsp").forward(req, resp);
    }

    private void create(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String name = req.getParameter("name");
        int price = parseInt(req.getParameter("price"), 0);
        int quantity = parseInt(req.getParameter("quantity"), 0);
        int categoryId = parseInt(req.getParameter("categoryId"), -1); // lấy từ <select name="categoryId">

        // ✅ Bắt buộc có categoryId hợp lệ
        if (categoryId <= 0) {
            // quay lại form với thông báo lỗi + dữ liệu người dùng đã nhập
            req.setAttribute("mode", "create");
            req.setAttribute("error", "Vui lòng chọn danh mục (category).");
            req.setAttribute("oldName", name);
            req.setAttribute("oldPrice", price);
            req.setAttribute("oldQuantity", quantity);
            preloadCategories(req);
            try {
                req.getRequestDispatcher("/views/form.jsp").forward(req, resp);
            } catch (IllegalStateException ignore) {}
            return;
        }

        service.create(name, price, quantity, categoryId);
        resp.sendRedirect(req.getContextPath() + "/products?action=list");
    }

    private void update(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        int id = parseInt(req.getParameter("id"), -1);
        String name = req.getParameter("name");
        int price = parseInt(req.getParameter("price"), 0);
        int quantity = parseInt(req.getParameter("quantity"), 0);
        int categoryId = parseInt(req.getParameter("categoryId"), -1);

        if (id <= 0) {
            resp.sendRedirect(req.getContextPath() + "/products?action=list");
            return;
        }
        if (categoryId <= 0) {
            req.setAttribute("mode", "edit");
            req.setAttribute("error", "Vui lòng chọn danh mục (category).");
            ProductDto p = service.getById(id);
            if (p != null) req.setAttribute("product", p);
            preloadCategories(req);
            try {
                req.getRequestDispatcher("/views/form.jsp").forward(req, resp);
            } catch (IllegalStateException ignore) {}
            return;
        }

        service.update(id, name, price, quantity, categoryId);
        resp.sendRedirect(req.getContextPath() + "/products?action=list");
    }

    private void delete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int id = parseInt(req.getParameter("id"), -1);
        service.delete(id);
        resp.sendRedirect(req.getContextPath() + "/products?action=list");
    }

    private int parseInt(String s, int def) {
        try { return Integer.parseInt(s); } catch (Exception e) { return def; }
    }

    // ✅ Nạp categories để render <select>
    private void preloadCategories(HttpServletRequest req) {
        try {
            List<Category> categories = categoryService.getAll();
            req.setAttribute("categories", categories);
        } catch (Exception e) {
            req.setAttribute("categories", java.util.Collections.emptyList());
        }
    }
}
