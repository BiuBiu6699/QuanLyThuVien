<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Mượn Trả Sách</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="app-wrapper">
    <jsp:include page="/common/header.jsp" />

    <main class="app-main">
        <div class="app-container">
            <div class="page-header">
                <div>
                    <h1 class="page-title">Quản lý mượn trả</h1>
                    <p class="page-subtitle">Danh sách các phiếu mượn trong hệ thống</p>
                </div>
            </div>

            <div class="table-wrapper">
                <table class="table">
                    <thead>
                    <tr>
                        <th>ID Phiếu</th>
                        <th>Người mượn</th>
                        <th>Ngày mượn</th>
                        <th>Hạn trả</th>
                        <th>Trạng thái</th>
                        <th>Hành động</th>
                        <th>Chi tiết</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="b" items="${borrowingList}">
                        <tr>
                            <td>${b.id}</td>
                            <td>${b.userFullName}</td>
                            <td>${b.borrowDate}</td>
                            <td>${b.dueDate}</td>
                            <td>${b.status}</td>
                            <td class="table-actions">
                                <c:if test="${b.status == 'PENDING'}">
                                    <form action="manage-borrows" method="post" style="display:inline;">
                                        <input type="hidden" name="borrowingId" value="${b.id}"/>
                                        <input type="hidden" name="status" value="APPROVED"/>
                                        <button type="submit" class="btn btn-primary btn-sm">
                                            Duyệt
                                        </button>
                                    </form>
                                </c:if>

                                <c:if test="${b.status == 'APPROVED'}">
                                    <form action="manage-borrows" method="post" style="display:inline;">
                                        <input type="hidden" name="borrowingId" value="${b.id}"/>
                                        <input type="hidden" name="status" value="RETURNED"/>
                                        <button type="submit" class="btn btn-primary btn-sm">
                                            Xác nhận đã trả
                                        </button>
                                    </form>
                                </c:if>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/borrow-details?id=${b.id}">
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
