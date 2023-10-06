<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 취소</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
</head>
<body>
	<jsp:include page="../inc/menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">주문 취소</h1>
		</div>
	</div>
	<div class="container">
		<h2 class="alert alert-danger">주문이 취소되었습니다.</h2>
	</div>
	<div class="container">
		<p>
			<a href="../product/products.jsp" class="btn btn-secondary">상품 목록 >> </a>
		</p>
	</div>

	<%
	// 세션의 주문정보 삭제
	session.removeAttribute("orderId");
	session.removeAttribute("orderName");
	session.removeAttribute("tel");
	session.removeAttribute("zipCode");
	session.removeAttribute("address01");
	session.removeAttribute("address02");
	%>

	<jsp:include page="../inc/footer.jsp" />
</body>
</html>