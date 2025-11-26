package com.mycompany.quanlythuvien.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.mycompany.quanlythuvien.dao.BorrowingDAO;
import com.mycompany.quanlythuvien.model.Borrowing;
import com.mycompany.quanlythuvien.model.User;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "HistoryServlet", urlPatterns = {"/history"})
public class HistoryServlet extends HttpServlet {
    private BorrowingDAO borrowingDAO = new BorrowingDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        List<Borrowing> history = borrowingDAO.getBorrowingsByUserId(user.getId());
        request.setAttribute("historyList", history);
        request.getRequestDispatcher("history.jsp").forward(request, response);
    }
}