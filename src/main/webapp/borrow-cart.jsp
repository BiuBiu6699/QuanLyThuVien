<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Giỏ Mượn Sách</title>
    <!-- CSS chung -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="app-wrapper">
    <jsp:include page="/common/header.jsp" />

    <main class="app-main">
        <div class="app-container">
            <div class="page-header">
                <div>
                    <h1 class="page-title">Giỏ mượn</h1>
                    <p class="page-subtitle">Danh sách sách bạn đang chọn để mượn</p>
                </div>
            </div>

            <c:if test="${not empty sessionScope.cartError}">
                <div class="alert alert-error" style="margin-bottom: 12px;">
                    ${sessionScope.cartError}
                </div>
                <c:remove var="cartError" scope="session" />
            </c:if>

            <c:choose>
                <c:when test="${not empty borrowCart && not empty borrowCart.values()}">
                    <div class="table-wrapper">
                        <table class="table">
                            <thead>
                            <tr>
                                <th>Sách</th>
                                <th style="width: 20%;">Số lượng</th>
                                <th style="width: 18%;">Hành động</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="item" items="${borrowCart.values()}">
                                <tr>
                                    <td>
                                        <strong><c:out value="${item.book.title}" /></strong><br>
                                        <span class="book-meta">
                                            Tác giả: <c:out value="${item.book.author}" />
                                        </span>
                                    </td>
                                    <td>
                                        <form action="borrow" method="post" style="display: flex; align-items: center; gap: 8px;">
                                            <input type="hidden" name="action" value="update_quantity">
                                            <input type="hidden" name="bookId" value="${item.book.id}">
                                            <input type="number" name="quantity"
                                                   class="form-control"
                                                   value="${item.quantity}" min="1"
                                                   style="max-width: 90px;">
                                            <button type="submit" class="btn btn-ghost btn-sm">
                                                Cập nhật
                                            </button>
                                        </form>
                                    </td>
                                    <td>
                                        <form action="borrow" method="post" onsubmit="return confirm('Bạn có chắc muốn xóa sách này khỏi giỏ?');">
                                            <input type="hidden" name="action" value="remove_item">
                                            <input type="hidden" name="bookId" value="${item.book.id}">
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

                    <div style="margin-top: 16px; text-align: right;">
                        <form action="borrow" method="post">
                            <input type="hidden" name="action" value="confirm_borrow"/>
                            <button type="submit" class="btn btn-primary">
                                Xác nhận mượn tất cả
                            </button>
                        </form>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="card" style="text-align: center;">
                        <p>Giỏ mượn của bạn đang trống.</p>
                        <div style="margin-top: 8px;">
                            <a href="home" class="btn btn-primary btn-sm">Quay lại trang chủ</a>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>

    <jsp:include page="/common/footer.jsp" />
</div>
</body>
</html>
