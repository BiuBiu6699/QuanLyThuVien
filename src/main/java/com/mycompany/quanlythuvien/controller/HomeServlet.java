package com.mycompany.quanlythuvien.controller;

import com.mycompany.quanlythuvien.dao.BookDAO;
import com.mycompany.quanlythuvien.model.Book;
import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet(name = "HomeServlet", urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {

    private BookDAO bookDAO = new BookDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Book> bookList = bookDAO.getAllBooks();
        request.setAttribute("bookList", bookList);
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }
}