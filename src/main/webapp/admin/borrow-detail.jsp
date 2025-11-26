<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi Tiết Phiếu Mượn</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="app-wrapper">
    <jsp:include page="/common/header.jsp" />

    <main class="app-main">
        <div class="app-container">
            <div class="page-header">
                <div>
                    <h1 class="page-title">Chi tiết phiếu mượn #${borrowingId}</h1>
                </div>
            </div>

            <div class="table-wrapper">
                <table class="table">
                    <thead>
                    <tr>
                        <th>Tên sách</th>
                        <th>Số lượng</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="entry" items="${details}">
                        <tr>
                            <td><c:out value="${entry.key}" /></td>
                            <td><c:out value="${entry.value}" /></td>
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
