package com.mycompany.quanlythuvien.controller;

import com.mycompany.quanlythuvien.dao.BorrowingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;


@WebServlet(name = "BorrowDetailServlet", urlPatterns = {"/admin/borrow-details"})
public class BorrowDetailServlet extends HttpServlet {
    private BorrowingDAO borrowingDAO = new BorrowingDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int borrowingId = Integer.parseInt(request.getParameter("id"));
        Map<String, Integer> details = borrowingDAO.getBorrowingDetails(borrowingId);
        
        request.setAttribute("details", details);
        request.setAttribute("borrowingId", borrowingId);
       
        request.getRequestDispatcher("/borrow-detail.jsp").forward(request, response);
    }
}