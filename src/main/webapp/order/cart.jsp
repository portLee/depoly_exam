<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<body>
	<jsp:include page="../inc/menu.jsp"/>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">장바구니</h1>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<table width="100%">
				<tr>
					<td align="left">
						<a href="#" class="btn btn-danger btn-removeAll">비우기</a>
						<a href="#" class="btn btn-danger btn-selected">선택삭제</a>
						<a href="./shippingInfo.jsp" class="btn btn-success">주문</a>
					</td>
				</tr>
			</table>
		</div>
		
		<script>
			document.addEventListener("DOMContentLoaded", function() {
				const frmCart = document.querySelector("form[name=frmCart]");
				
				// 비우기
				const btnRemoveAll = document.querySelector(".btn-removeAll");
				btnRemoveAll.addEventListener("click", function () {
					if (confirm("장바구니 목록을 비우시겠습니까?")) {
						location.href = "./processRemoveCart.jsp";
					}
				});
				
				// 삭제
				const btnRemoveByIds = document.querySelectorAll(".btn-removeById");
				btnRemoveByIds.forEach(button => {
					button.addEventListener("click", function (e) {
						if (confirm("정말 삭제하시겠습니까?")) {
							frmCart.productId.value = e.target.role;
							frmCart.action = './processRemoveCartById.jsp';
							frmCart.submit();
						}
					});
				});
				
				// 선택삭제
				const btnRemoveSelected = document.querySelector(".btn-selected");
				btnRemoveSelected.addEventListener("click", function () {
					if (confirm("정말 삭제하시겠습니까?")) {
						frmCart.action = "./processRemoveCartSelected.jsp";
						frmCart.submit();
					}
				});
			});
		</script>
		
		<div style="padding-top: 50px">
			<form action="#" name="frmCart" method="post">
				<input type="hidden" name="productId">
				<table class="table table-hover">
					<tr>
						<td>선택</td>
						<td>사진</td>
						<td>상품</td>
						<td>가격</td>
						<td>수량</td>
						<td>소계</td>
						<td>비고</td>
					</tr>
					<%@ include file="../inc/dbconn.jsp" %>
					<%
					
						PreparedStatement preparedStatement = null;
						ResultSet resultSet = null;
						
						String sql = "select * from product join cart using(productId) where (orderId = ?)";
						preparedStatement = connection.prepareStatement(sql);
						preparedStatement.setString(1, orderId);
						resultSet = preparedStatement.executeQuery();
						
						int sum = 0;
						while (resultSet.next()) {
							Integer price = resultSet.getInt("unitPrice") * resultSet.getInt("cnt");
							sum += price;
					%>
					
					<tr>
						<td><input type="checkbox" name="checkedId" value="<%= resultSet.getString("productId") %>"></td>
						<td><img src="/upload/<%= resultSet.getString("fileName") %>" style="width: 100px"></td>
						<td><a href="../product/product.jsp?productId=<%= resultSet.getString("productId")%>"><%= resultSet.getString("productName") %></a></td>
						<td><%= resultSet.getInt("unitPrice") %></td>
						<td><input type="number" value="<%= resultSet.getInt("cnt") %>"></td>
						<td><%= price %></td>
						<td><a href="#" role="<%= resultSet.getString("productId") %>" class="badge badge-danger btn-removeById">삭제</a></td>
					</tr>
					<%
						}
					%>
					<tr>
						<td colspan="7">합계: <%= sum %>원</td>
					</tr>
				</table>
				<a href="../product/products.jsp" class="btn btn-secondary">&laquo; 쇼핑 계속하기</a>
			</form>
		</div>
	</div>
	
	<jsp:include page="../inc/footer.jsp"/>
</body>
</html>