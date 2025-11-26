<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang Chủ Thư Viện</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="app-wrapper">
    <jsp:include page="/common/header.jsp" />

    <main class="app-main">
        <div class="app-container">
            <div class="page-header">
                <div>
                    <h1 class="page-title">Danh sách sách trong thư viện</h1>
                    <p class="page-subtitle">Chọn sách bạn muốn mượn (cần đăng nhập để mượn)</p>
                </div>
            </div>

            <div class="book-grid">
                <c:forEach var="book" items="${bookList}">
                    <div class="book-card">
                        <div class="book-title">
                            <c:out value="${book.title}"/>
                        </div>
                        <div class="book-meta">
                            Tác giả: <c:out value="${book.author}"/>
                        </div>

                        <div class="book-meta">
                            Số lượng:
                            <c:choose>
                                <c:when test="${book.quantity > 0}">
                                    <span class="badge-qty badge-qty--ok">
                                        Còn <c:out value="${book.quantity}"/> cuốn
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge-qty badge-qty--out">Hết sách</span>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <c:if test="${book.quantity > 0 && not empty sessionScope.user}">
                            <div class="book-actions">
                                <form action="borrow" method="post">
                                    <input type="hidden" name="action" value="add_to_cart"/>
                                    <input type="hidden" name="bookId" value="${book.id}"/>
                                    <button type="submit" class="btn btn-primary">
                                        Mượn sách
                                    </button>
                                </form>
                            </div>
                        </c:if>
                    </div>
                </c:forEach>
            </div>
        </div>
    </main>

    <jsp:include page="/common/footer.jsp"/>
</div>
</body>
</html>
