<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thư viện</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="auth-page">
    <div class="card form-card">
        <div class="auth-card-inner">
            <h1 class="auth-title">Đăng nhập thư viện</h1>
            <p class="auth-subtitle">Sử dụng tài khoản để quản lý mượn sách</p>
        </div>

        <%-- Đặt ngay phía trên form đăng nhập: thông báo đăng ký thành công --%>
        <c:if test="${not empty sessionScope.successMessage}">
            <p style="color: green; margin-bottom: 8px;">
                ${sessionScope.successMessage}
            </p>
            <%-- Xóa message sau khi hiển thị --%>
            <c:remove var="successMessage" scope="session" />
        </c:if>

        <%-- Hiển thị lỗi đăng nhập nếu có --%>
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-error">
                ${errorMessage}
            </div>
        </c:if>

        <form action="login" method="post">
            <div class="form-group">
                <label for="username" class="form-label">Tên đăng nhập</label>
                <input type="text" id="username" name="username"
                       class="form-control" required>
            </div>

            <div class="form-group">
                <label for="password" class="form-label">Mật khẩu</label>
                <input type="password" id="password" name="password"
                       class="form-control" required>
            </div>

            <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 6px;">
                Đăng nhập
            </button>
        </form>

        <%-- Đặt ngay phía dưới nút "Đăng nhập": link tới trang đăng ký --%>
        <div style="text-align: center; margin-top: 15px;">
            <p>Chưa có tài khoản? <a href="register">Đăng ký tại đây</a></p>
        </div>
    </div>
</div>
</body>
</html>
