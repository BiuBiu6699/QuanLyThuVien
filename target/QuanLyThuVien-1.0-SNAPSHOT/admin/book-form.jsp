<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Form Sách</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="app-wrapper">
    <jsp:include page="/common/header.jsp" />

    <main class="app-main">
        <div class="app-container">
            <div class="page-header">
                <div>
                    <h1 class="page-title">
                        <c:if test="${book != null}">Chỉnh sửa sách</c:if>
                        <c:if test="${book == null}">Thêm sách mới</c:if>
                    </h1>
                </div>
            </div>

            <div class="card form-card" style="max-width: 500px;">
                <form action="${pageContext.request.contextPath}/admin/manage-books" method="post">
                    <input type="hidden" name="action" value="${book != null ? 'update' : 'add'}" />

                    <c:if test="${book != null}">
                        <input type="hidden" name="id" value="<c:out value='${book.id}' />" />
                    </c:if>

                    <div class="form-group">
                        <label for="title" class="form-label">Tiêu đề</label>
                        <input type="text" id="title" name="title"
                               class="form-control"
                               value="<c:out value='${book.title}' />" required>
                    </div>

                    <div class="form-group">
                        <label for="author" class="form-label">Tác giả</label>
                        <input type="text" id="author" name="author"
                               class="form-control"
                               value="<c:out value='${book.author}' />" required>
                    </div>

                    <div class="form-group">
                        <label for="categoryId" class="form-label">ID Thể loại</label>
                        <input type="number" id="categoryId" name="categoryId"
                               class="form-control"
                               value="<c:out value='${book.categoryId}' />" required>
                    </div>

                    <div class="form-group">
                        <label for="quantity" class="form-label">Số lượng</label>
                        <input type="number" id="quantity" name="quantity"
                               class="form-control"
                               value="<c:out value='${book.quantity}' />" required>
                    </div>

                    <div class="form-group">
                        <label for="imageUrl" class="form-label">URL hình ảnh</label>
                        <input type="text" id="imageUrl" name="imageUrl"
                               class="form-control"
                               value="<c:out value='${book.imageUrl}' />">
                    </div>

                    <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 6px;">
                        Lưu lại
                    </button>
                </form>
            </div>
        </div>
    </main>

    <jsp:include page="/common/footer.jsp" />
</div>
</body>
</html>
