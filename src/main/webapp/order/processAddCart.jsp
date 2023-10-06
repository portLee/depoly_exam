<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="../inc/dbconn.jsp" %>
	<%
		String productId = request.getParameter("productId");
		if (productId == null || productId.trim().equals("")) {
			// null이나 빈 문자열을 반환한 경우
			response.sendRedirect("../products.jsp");
			return;
		}
		
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		
		// 동일한 주문번호에 같은 상품번호가 있으면 업데이트
		String sql = "select num from cart where (orderId = ?) and (productId = ?)";
		preparedStatement = connection.prepareStatement(sql);
 		preparedStatement.setString(1, orderId);
 		preparedStatement.setString(2, productId);
 		resultSet = preparedStatement.executeQuery();
		
 		if (resultSet.next()) {
 			sql = "update cart set cnt = cnt + 1 where num = ?";
 			preparedStatement = connection.prepareStatement(sql);
 	 		preparedStatement.setString(1, resultSet.getString("num"));
 	 		preparedStatement.executeUpdate();
 		}
 		else {
 			String memberId = (String) session.getAttribute("sessionMemberId");
 			memberId = (memberId == null) ? "Guest" : memberId;
 			
 			int cnt = 1;
 			
 			sql = "insert into cart (orderId, memberId, productId, cnt, addDate)" +
 				"values (?, ?, ?, ?, now())";
 			
 			try {
 				preparedStatement = connection.prepareStatement(sql);
 	 	 		preparedStatement.setString(1, orderId);
 	 	 		preparedStatement.setString(2, memberId);
 	 	 		preparedStatement.setString(3, productId);
 	 	 		preparedStatement.setInt(4, cnt);
 	 	 		preparedStatement.executeUpdate();	
 			} catch (SQLException e) {
 				throw new RuntimeException(e);
 			}
 			
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
 		
		response.sendRedirect("../product/product.jsp?productId=" + productId);
	%>
</body>
</html>