<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<header class="topbar">
    <div class="topbar-inner">
        <div class="topbar-left">
            <div class="brand">Thư viện T</div>
            <nav class="nav-links">
                <a class="nav-link" href="${pageContext.request.contextPath}/home">Trang chủ</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/history">Lịch sử mượn</a>

                <c:if test="${sessionScope.user.role == 'ADMIN'}">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/manage-books">
                        Quản lý sách
                    </a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/manage-borrows">
                        Quản lý mượn trả
                    </a>
                </c:if>
            </nav>
        </div>

        <div class="topbar-right">
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <span class="user-chip">
                        <span class="user-name">
                            <c:out value="Xin chào, ${sessionScope.user.fullName}"/>
                        </span>
                    </span>

                    <c:set var="totalItems" value="${0}" />
                    <c:forEach var="item" items="${borrowCart.values()}">
                        <c:set var="totalItems" value="${totalItems + item.quantity}" />
                    </c:forEach>

                    <a href="${pageContext.request.contextPath}/borrow?action=cart" class="cart-pill">
                        Giỏ mượn
                        <span class="cart-count">
                            ${empty borrowCart ? 0 : borrowCart.size()}
                        </span>
                    </a>

                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-ghost btn-sm">
                        Đăng xuất
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login" class="btn btn-primary btn-sm">
                        Đăng nhập
                    </a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</header>
