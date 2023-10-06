<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<%
	Connection connection = null;
	
	try {
		String url = "jdbc:mariadb://localhost:3308/servlet_sample_market";
		String user = "root";
		String password = "2245";
	
		Class.forName("org.mariadb.jdbc.Driver");
		connection = DriverManager.getConnection(url, user, password);
	} catch (SQLException e) {
		out.println("데이터베이스 연결이 실패했습니다.<br>");
		out.println("SQLException : " + e.getMessage());
	}

	// 주문번호 생성 및 사용
	String orderId = (String) session.getAttribute("orderId");
	if (orderId == null) {
		// 세션 ID 가져오기
		String sessionId = session.getId();
	
		// 현재 날짜와 시간 가져오기
		java.text.SimpleDateFormat simpleDateFormat = new java.text.SimpleDateFormat("yyyyMMddHHmmss");
		String currentDateTime = simpleDateFormat.format(new java.util.Date());
	
		orderId = currentDateTime + "-" + sessionId;
		session.setAttribute("orderId", orderId);
	}
%>