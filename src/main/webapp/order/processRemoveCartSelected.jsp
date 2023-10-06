<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		// 세션에서 장바구니 목록 가져옴.
		ArrayList<Cart> carts = (ArrayList<Cart>) session.getAttribute("carts");
	
		String[] checkedId = request.getParameterValues("checkedId");
		if (checkedId != null) {
			for (String s : checkedId) {
				for (int i = 0; i < carts.size(); i++) {
					Cart cart = carts.get(i);
					if (cart.getProductId().equals(s)) {
						carts.remove(cart);
						break;
					}
				}
			}	
		}
		response.sendRedirect("cart.jsp");
	%>
</body>
</html>