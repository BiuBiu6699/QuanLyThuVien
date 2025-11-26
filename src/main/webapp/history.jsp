<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lịch Sử Mượn Sách</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="app-wrapper">
    <jsp:include page="/common/header.jsp" />

    <main class="app-main">
        <div class="app-container">
            <div class="page-header">
                <div>
                    <h1 class="page-title">Lịch sử mượn sách</h1>
                    <p class="page-subtitle">Các phiếu mượn đã tạo của bạn</p>
                </div>
            </div>

            <div class="table-wrapper">
                <table class="table">
                    <thead>
                    <tr>
                        <th>Mã phiếu</th>
                        <th>Ngày mượn</th>
                        <th>Hạn trả</th>
                        <th>Trạng thái</th>
                        <th>Chi tiết</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="h" items="${historyList}">
                        <tr>
                            <td>${h.id}</td>
                            <td>${h.borrowDate}</td>
                            <td>${h.dueDate}</td>
                            <td>${h.status}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/borrow-details?id=${h.id}">
                                    Xem chi tiết
                                </a>
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
