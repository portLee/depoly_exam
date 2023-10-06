<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>상품 목록</title>
</head>
<body>
	<%@ include file="../inc/menu.jsp" %>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">
				상품목록
			</h1>
		</div>
	</div>	
	<div class="container">
		<div class="row" align="center">
			<%@ include file="../inc/dbconn.jsp" %>
			<% 
				PreparedStatement preparedStatement = null;
				ResultSet resultSet = null;
				String sql = "select * from product";
				preparedStatement = connection.prepareStatement(sql);
				resultSet = preparedStatement.executeQuery();
				while (resultSet.next()) {
			%>
			<div class="col-md-4">
				<img src="/upload/<%= resultSet.getString("fileName") %>" style="width:100%">
				<h3><%= resultSet.getString("productName") %></h3>
				<p><%= resultSet.getString("description") %></p>
				<p><%= resultSet.getString("unitPrice") %></p>
				<p><a href="./product.jsp?productId=<%= resultSet.getString("productId") %>" class="btn btn-secondary" role="button">
				상세정보 >> </a></p>
			</div>
			<%
				}
				if (resultSet != null) {
					resultSet.close();
				}
				if (preparedStatement != null) {
					preparedStatement.close();
				}
				if (connection != null) {
					connection.close();
				}
			%>
		</div>
		<hr>
	</div>
	<jsp:include page="../inc/footer.jsp" />
</body>
</html>