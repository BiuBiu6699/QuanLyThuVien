package com.mycompany.quanlythuvien.controller;

import com.mycompany.quanlythuvien.dao.BookDAO;
import com.mycompany.quanlythuvien.dao.BorrowingDAO;
import com.mycompany.quanlythuvien.model.Book;
import com.mycompany.quanlythuvien.model.Borrowing;
import com.mycompany.quanlythuvien.model.User;
import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.mycompany.quanlythuvien.model.CartItem;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "BorrowServlet", urlPatterns = {"/borrow"})
public class BorrowServlet extends HttpServlet {

    private BookDAO bookDAO = new BookDAO();
    private BorrowingDAO borrowingDAO = new BorrowingDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("cart".equals(action)) {
            request.getRequestDispatcher("/borrow-cart.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        Map<Integer, CartItem> borrowCart = (Map<Integer, CartItem>) session.getAttribute("borrowCart");
        if (borrowCart == null) {
            borrowCart = new HashMap<>();
        }

        if ("add_to_cart".equals(action)) {
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            Book book = bookDAO.getBookById(bookId);
            
            if (book != null && book.getQuantity() > 0) {
                if (borrowCart.containsKey(bookId)) {
                    borrowCart.get(bookId).incrementQuantity();
                } else {
                    borrowCart.put(bookId, new CartItem(book, 1));
                }
                bookDAO.updateBookQuantity(bookId, -1);
                session.setAttribute("borrowCart", borrowCart);
            }
            response.sendRedirect(request.getContextPath() + "/home");
        } 
        else if ("remove_item".equals(action)) {
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            
            if (borrowCart.containsKey(bookId)) {
                int quantityToRestore = borrowCart.get(bookId).getQuantity();
                
                bookDAO.updateBookQuantity(bookId, quantityToRestore);
    
                borrowCart.remove(bookId);
                
                session.setAttribute("borrowCart", borrowCart);
            }
            response.sendRedirect(request.getContextPath() + "/borrow?action=cart");
        }
        else if ("update_quantity".equals(action)) {
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            int newQuantity = Integer.parseInt(request.getParameter("quantity"));

            if (borrowCart.containsKey(bookId) && newQuantity > 0) {
                CartItem item = borrowCart.get(bookId);
                int oldQuantity = item.getQuantity();
                
                int difference = newQuantity - oldQuantity;
                
                boolean success = bookDAO.updateBookQuantity(bookId, -difference);
                
                if(success) {
                    item.setQuantity(newQuantity);
                } else {
                    session.setAttribute("cartError", "Không đủ sách trong kho để cập nhật số lượng!");
                }
                session.setAttribute("borrowCart", borrowCart);
            }
            response.sendRedirect(request.getContextPath() + "/borrow?action=cart");
        }
        else if ("confirm_borrow".equals(action)) {
            User user = (User) session.getAttribute("user");
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }
            try {
                Borrowing borrowing = new Borrowing();
                borrowing.setUserId(user.getId());
                borrowing.setBorrowDate(Date.valueOf(LocalDate.now()));
                borrowing.setDueDate(Date.valueOf(LocalDate.now().plusWeeks(2))); 
                borrowing.setStatus("PENDING");
                
                int borrowingId = borrowingDAO.addBorrowing(borrowing);

                if (borrowingId > 0) {
                    for (CartItem item : borrowCart.values()) {
                        for (int i = 0; i < item.getQuantity(); i++) {
                            borrowingDAO.addBorrowingDetail(borrowingId, item.getBook().getId());
                        }
                    }
                }
                
                session.removeAttribute("borrowCart");
                response.sendRedirect(request.getContextPath() + "/history"); 

            } catch (Exception e) {
                e.printStackTrace();
                
                response.getWriter().println("Có lỗi xảy ra, vui lòng thử lại.");
            }
        }
    }
}