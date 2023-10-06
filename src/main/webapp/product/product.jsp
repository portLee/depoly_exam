<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page errorPage="exception/exceptionNoProduct.jsp" %> 
<%-- <jsp:useBean id="productDAO" class="dao.ProductRepository" scope="session" />
--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>상품 정보</title>
</head>
<body>
	<%@ include file="../inc/menu.jsp" %>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">
				상품정보
			</h1>
		</div>
	</div>	
	
	<%@ include file="../inc/dbconn.jsp" %>
	<% 
		String productId = request.getParameter("productId");
			
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		String sql = "select * from product where productId = ?";
		preparedStatement = connection.prepareStatement(sql);
		preparedStatement.setString(1, productId);
		resultSet = preparedStatement.executeQuery();
		if (resultSet.next()) {
	%>
	<div class="container">
		<div class="row">
			<div class="col-md-6">
				<img src="/upload/<%= resultSet.getString("fileName") %>" style="width:100%">
				<h3><%= resultSet.getString("productName") %></h3>
				<p><%= resultSet.getString("description") %></p>
				<p><strong>상품코드</strong> : <span class="badge badge-danger">
					<%= resultSet.getString("productId") %>
				</span></p>
				<p><strong>제조사</strong> : <%= resultSet.getString("manufacturer") %></p>
				<p><strong>분류</strong> : <%= resultSet.getString("category") %></p>
				<p><strong>재고 수</strong> : <%= resultSet.getLong("unitsInStock") %></p>
				<h4><%= resultSet.getInt("unitPrice") %>원</h4>
				
				<form name="frmAddCart" action="../order/processAddCart.jsp" method="post">
					<input type="hidden" name="productId" value="<%= resultSet.getString("productId") %>">
				</form>
				
				<p>
					<a href="#" class="btn btn-info">장바구니 담기 >> </a>
					<a href="../order/cart.jsp" class="btn btn-info">장바구니 목록 >> </a>
					<a href="products.jsp" class="btn btn-secondary" role="button">상품 목록 >> </a>
				</p>
				<script type="text/javascript">
					document.addEventListener("DOMContentLoaded", function () {
						const btnCart = document.querySelector(".btn-info");
						const frmAddCart = document.querySelector("form[name=frmAddCart]");
						
						btnCart.addEventListener('click', function () {
							frmAddCart.submit();
						});
					});
					
				</script>
			</div>
		</div>
	</div>
	<%
		}
	%>
	<jsp:include page="../inc/footer.jsp" />
</body>
</html>