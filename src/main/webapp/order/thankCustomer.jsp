<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>주문 완료</title>
</head>
<body>
	<%
		String encoding = "UTF-8";
		request.setCharacterEncoding(encoding);
		
		String orderId = (String) session.getAttribute("orderId");
	%>


	<jsp:include page="../inc/menu.jsp"/>
		<div class="jumbotron">
			<div class="container">
				<h1 class="display-3">주문완료</h1>
			</div>
		</div>
		<div class="container">
			<h2 class="alert alert-danger">주문해주셔서 감사합니다.</h2>
			<p>주문번호 : <%= orderId %></p>
		</div>
		<div class="container">
			<p><a href="../product/products.jsp" class="btn btn-secondary">상품 목록 >> </a></p>
		</div>
		<%
			/* 실제 작업은 페이지 상단이나, 이전 페이지에서 데이터베이스에 저장이 되어야 함.
			   데이터베이스 저장에 성공한 후 완료 페이지가 출력이 되어야 함.
			   작업이 마무리 되었으니 1) 세션의 장바구니 삭제 및 2) 쿠키의 주문 정보를 삭제 해야 함.
			*/
			// 1) 세션의 장바구니 삭제
			session.removeAttribute("carts");
			
			// 2) 세션의 주문정보 삭제
			session.removeAttribute("orderId");
			session.removeAttribute("orderName");
			session.removeAttribute("tel");
			session.removeAttribute("zipCode");
			session.removeAttribute("address01");
			session.removeAttribute("address02");
		%>
	<jsp:include page="../inc/footer.jsp"/>
</body>
</html>