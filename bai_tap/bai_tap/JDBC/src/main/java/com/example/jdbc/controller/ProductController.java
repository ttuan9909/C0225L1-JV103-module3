package com.example.jdbc.controller;

import com.example.jdbc.entity.Product;
import com.example.jdbc.repository.IProductRepository;
import com.example.jdbc.service.IProductService;
import com.example.jdbc.service.ProductService;

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
        List<Product> products = (q == null) ? service.getAll() : service.search(q);
        req.setAttribute("products", products);
        req.setAttribute("q", q == null ? "" : q);
        req.getRequestDispatcher("/views/list.jsp").forward(req, resp);
    }

    private void showEditForm(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        int id = parseInt(req.getParameter("id"), -1);
        Product p = service.getById(id);
        if (p == null) {
            resp.sendRedirect(req.getContextPath() + "/products?action=list");
            return;
        }
        req.setAttribute("mode", "edit");
        req.setAttribute("product", p);
        req.getRequestDispatcher("/views/form.jsp").forward(req, resp);
    }

    private void showDetail(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        int id = parseInt(req.getParameter("id"), -1);
        Product p = service.getById(id);
        if (p == null) {
            resp.sendRedirect(req.getContextPath() + "/products?action=list");
            return;
        }
        req.setAttribute("product", p);
        req.getRequestDispatcher("/views/view.jsp").forward(req, resp);
    }

    private void create(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String name = req.getParameter("name");
        int price = parseInt(req.getParameter("price"), 0);
        int quantity = parseInt(req.getParameter("quantity"), 0);

        service.create(name, price, quantity);
        resp.sendRedirect(req.getContextPath() + "/products?action=list");
    }

    private void update(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int id = parseInt(req.getParameter("id"), -1);
        String name = req.getParameter("name");
        int price = parseInt(req.getParameter("price"), 0);
        int quantity = parseInt(req.getParameter("quantity"), 0);

        service.update(id, name, price, quantity);
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
}
