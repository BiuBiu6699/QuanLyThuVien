package com.mycompany.quanlythuvien.controller;

import com.mycompany.quanlythuvien.dao.BookDAO;
import com.mycompany.quanlythuvien.dao.BorrowingDAO;
import com.mycompany.quanlythuvien.model.Borrowing;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "BorrowManagementServlet", urlPatterns = {"/admin/manage-borrows"})
public class BorrowManagementServlet extends HttpServlet {

    private BorrowingDAO borrowingDAO = new BorrowingDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Borrowing> borrowingList = borrowingDAO.getAllBorrowings();
        request.setAttribute("borrowingList", borrowingList);
        request.getRequestDispatcher("/admin/manage-borrows.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        BookDAO bookDAO = new BookDAO();

        int borrowingId = Integer.parseInt(request.getParameter("borrowingId"));
        String status = request.getParameter("status");

        boolean success = false;

        
        if ("RETURNED".equals(status)) {
            List<Integer> bookIdsToReturn = borrowingDAO.getBookIdsByBorrowingId(borrowingId);

            if (!bookIdsToReturn.isEmpty()) {
                boolean statusUpdated = borrowingDAO.updateBorrowingStatus(borrowingId, status);

                if (statusUpdated) {
                    boolean allBooksUpdated = true;
                    for (int bookId : bookIdsToReturn) {
                        boolean bookUpdated = bookDAO.updateBookQuantity(bookId, 1); 
                        if (!bookUpdated) {
                            allBooksUpdated = false;
                            System.err.println("Lỗi: Không thể cập nhật số lượng cho sách ID " + bookId);
                            break; 
                        }
                    }
                    

                    if (allBooksUpdated) {
                        success = true;
                    } else {
                        System.err.println("Lỗi nghiêm trọng: Phiếu mượn " + borrowingId + " đã trả nhưng một số sách chưa được cập nhật số lượng.");
                    }
                }
            }
        } else {
            success = borrowingDAO.updateBorrowingStatus(borrowingId, status);
        }

        response.sendRedirect(request.getContextPath() + "/admin/manage-borrows");
    }
}