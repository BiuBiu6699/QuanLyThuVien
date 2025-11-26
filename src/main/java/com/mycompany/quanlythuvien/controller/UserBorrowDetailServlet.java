package com.mycompany.quanlythuvien.controller;

import com.mycompany.quanlythuvien.dao.BorrowingDAO;
import com.mycompany.quanlythuvien.model.User;
import java.io.IOException;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "UserBorrowDetailServlet", urlPatterns = {"/borrow-details"})
public class UserBorrowDetailServlet extends HttpServlet {

    private BorrowingDAO borrowingDAO = new BorrowingDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        try {
            int borrowingId = Integer.parseInt(request.getParameter("id"));

            if (borrowingDAO.isBorrowingOwner(borrowingId, user.getId())) {
                Map<String, Integer> details = borrowingDAO.getBorrowingDetails(borrowingId);
                request.setAttribute("details", details);
                request.setAttribute("borrowingId", borrowingId);
                request.getRequestDispatcher("borrow-detail-user.jsp").forward(request, response);
            } else {
                    
                response.sendRedirect("history");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("history");
        }
    }
}