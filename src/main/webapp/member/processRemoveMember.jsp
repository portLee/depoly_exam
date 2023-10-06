<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>
</head>
<body>
	<%@ include file="../inc/dbconn.jsp" %>
	<% 
		request.setCharacterEncoding("UTF-8");
		
		String sessionMemberId = (String) session.getAttribute("sessionMemberId");
		
		PreparedStatement PreparedStatement = null;
		String sql = "delete from member where memberId = ?";
		PreparedStatement = connection.prepareStatement(sql);
		PreparedStatement.setString(1, sessionMemberId);
		PreparedStatement.executeUpdate();
		
		session.invalidate();
		response.sendRedirect("resultMember.jsp");
	%>
</body>
</html>