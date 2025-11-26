<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Sách</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="app-wrapper">
    <jsp:include page="/common/header.jsp" />

    <main class="app-main">
        <div class="app-container">
            <div class="page-header">
                <div>
                    <h1 class="page-title">Quản lý sách</h1>
                </div>
                <div>
                    <a href="${pageContext.request.contextPath}/admin/manage-books?action=new"
                       class="btn btn-primary btn-sm">
                        + Thêm sách mới
                    </a>
                </div>
            </div>

            <div class="table-wrapper">
                <table class="table">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tiêu đề</th>
                        <th>Tác giả</th>
                        <th>Số lượng</th>
                        <th>Hành động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="book" items="${bookList}">
                        <tr>
                            <td><c:out value="${book.id}" /></td>
                            <td><c:out value="${book.title}" /></td>
                            <td><c:out value="${book.author}" /></td>
                            <td><c:out value="${book.quantity}" /></td>
                            <td class="table-actions">
                                <a href="${pageContext.request.contextPath}/admin/manage-books?action=edit&id=${book.id}"
                                   class="btn btn-ghost btn-sm">
                                    Sửa
                                </a>
                                <form action="${pageContext.request.contextPath}/admin/manage-books"
                                      method="post" style="display:inline;"
                                      onsubmit="return confirm('Bạn có chắc chắn muốn xóa sách này?');">
                                    <input type="hidden" name="action" value="delete"/>
                                    <input type="hidden" name="id" value="${book.id}"/>
                                    <button type="submit" class="btn btn-danger btn-sm">
                                        Xóa
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </main>

    <jsp:include page="/common/footer.jsp" />
</div>
</body>
</html>
