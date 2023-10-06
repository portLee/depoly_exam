<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="../inc/dbconn.jsp"%>
	<%
	String productId = request.getParameter("productId");

	if (productId == null || productId.trim().equals("")) {
		// null이 반환되거나 빈 문자열이 들어온 경우
		response.sendRedirect("../product/products.jsp");
		return;
	}

	PreparedStatement preparedStatement = null;

	String sql = "delete from cart where (orderId = ?) and (productId = ?)";

	try {
		preparedStatement = connection.prepareStatement(sql);
		preparedStatement.setString(1, orderId);
		preparedStatement.setString(2, productId);
		preparedStatement.executeUpdate();
	} catch (SQLException e) {
		throw new RuntimeException(e);
	} finally {
		if (preparedStatement != null) {
			preparedStatement.close();
		}
		if (connection != null) {
			connection.close();
		}
	}

	response.sendRedirect("cart.jsp");
	%>
</body>
</html>