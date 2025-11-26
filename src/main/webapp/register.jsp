<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng ký tài khoản</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="auth-page">
    <div class="card form-card">
        <div class="auth-card-inner">
            <h1 class="auth-title">Đăng ký tài khoản</h1>
            <p class="auth-subtitle">Tạo tài khoản mới để mượn sách online</p>
        </div>

        <c:if test="${not empty errorMessage}">
            <div class="alert alert-error">
                ${errorMessage}
            </div>
        </c:if>

        <form action="register" method="post">
            <div class="form-group">
                <label for="username" class="form-label">Tên đăng nhập</label>
                <input type="text" id="username" name="username"
                       class="form-control" required>
            </div>

            <div class="form-group">
                <label for="fullname" class="form-label">Tên tài khoản</label>
                <input type="text" id="fullname" name="fullName"
                       class="form-control" required>
            </div>

            <div class="form-group">
                <label for="email" class="form-label">Email</label>
                <input type="email" id="email" name="email"
                       class="form-control" required>
            </div>

            <div class="form-group">
                <label for="password" class="form-label">Mật khẩu</label>
                <input type="password" id="password" name="password"
                       class="form-control" required>
            </div>

            <div class="form-group">
                <label for="confirmPassword" class="form-label">Xác nhận mật khẩu</label>
                <input type="password" id="confirmPassword" name="confirmPassword"
                       class="form-control" required>
            </div>

            <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 6px;">
                Đăng ký
            </button>
        </form>

        <div style="text-align: center; margin-top: 15px;">
            <p>Đã có tài khoản? <a href="login">Đăng nhập tại đây</a></p>
        </div>
    </div>
</div>
</body>
</html>
