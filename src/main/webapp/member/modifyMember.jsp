<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>회원 정보 수정</title>
</head>
<body>
	<%@ include file="../inc/menu.jsp" %>
	<%@ include file="../inc/dbconn.jsp" %>
	<%
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		
		String sql = "select * from member where memberId = ?";
		preparedStatement = connection.prepareStatement(sql);
		preparedStatement.setString(1, sessionMemberId);
		resultSet = preparedStatement.executeQuery();
		
		if (resultSet.next()) {
			String passwd = resultSet.getString("passwd"); 
			String memberName = resultSet.getString("memberName"); 
			String gender = resultSet.getString("gender"); 
			
			// 생일 데이터 
			String birthday = resultSet.getString("birthday");
			String[] birthdayArr = birthday.split("-");
			String birthyy = birthdayArr[0]; 
			String birthmm = birthdayArr[1]; 
			String birthdd = birthdayArr[2];
			
			// 이메일 데이터
			String email = resultSet.getString("email");
			String[] emailArr = email.split("@");
			String mail1 = emailArr[0]; 
			String mail2 = emailArr[1]; 
			
			String phone = resultSet.getString("phone"); 
			String zipCode = resultSet.getString("zipCode"); 
			String address01 = resultSet.getString("address01");
			String address02 = resultSet.getString("address02");
	%>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">
				회원 정보 수정
			</h1>
			
		</div>
	</div>	
	
	<div class="container">
		<form name="frmMember" action="processModifyMember.jsp" method="post">
			<div class="form-group row">
				<label class="col-sm-2">아이디</label>
				<div class="col-sm-10">
					<input type="text" name="memberId" value="<%= sessionMemberId %>" readonly>
					<span class="memberIdCheck"></span>
					<div style="padding-top: 10px;">
						<input type="button" name="btnIsDuplication" value="팝업 아이디 중복 확인">
						<input type="button" name="btnIsDuplication2nd" value="ajax 아이디 중복 확인">
					</div>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">비밀번호</label>
				<div class="col-sm-3">
					<input type="password" name="passwd" class="form-control" value="<%= passwd %>">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">비밀번호 확인</label>
				<div class="col-sm-3">
					<input type="password" name="passwdCheck" class="form-control" value="<%= passwd %>">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">이름</label>
				<div class="col-sm-3">
					<input type="text" name="memberName" class="form-control" value="<%= memberName %>">
				</div>
			</div>
			<div class="form-group  row">
				<label class="col-sm-2">성별</label>
				<div class="col-sm-10">
					<input name="gender" type="radio" value="남" <%= gender.equals("남") ? "checked" : "" %>> 남
					<input name="gender" type="radio" value="여" <%= gender.equals("여") ? "checked" : "" %>> 여
				</div>
			</div>
			<div class="form-group row">
			<label class="col-sm-2">생일</label>
				<div class="col-sm-4  ">
					<input type="text" name="birthyy" maxlength="4" placeholder="년(4자)" size="6" value="<%= birthyy %>">
					<select name="birthmm">
						<option value="">월</option>
						<%
							for (int i = 1; i <= 12; i++) {
								String month = String.format("%02d", i);
								out.print("<option value=\"" + month + "\"");
								if (birthmm.equals(month)) {
									out.println(" selected");
								}
								out.print(">" + i + "</option>");
							}
						%>
					</select> 
					<input type="text" name="birthdd" maxlength="2" placeholder="일" size="4" value="<%= birthdd %>">
				</div>
			</div>
			<div class="form-group  row ">
				<label class="col-sm-2">이메일</label>
				<div class="col-sm-10">
					<input type="text" name="mail1" maxlength="50" value="<%= mail1 %>">@
					<select name="mail2">
						<%
							String[] mail2Arr = {"naver.com", "daum.net", "gmail.com", "nate.com"};
							for (String str : mail2Arr) {
								out.print("<option");
								if (mail2Arr[1].equals(str)) {
									out.println(" selected");
								}
								out.print(">" + str + "</option>");
							}
						%>
					</select>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">연락처</label>
				<div class="col-sm-3">
					<input type="text" name="phone" class="form-control" value="<%= phone %>">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">우편번호</label>
				<div class="col-sm-10">
					<input type="text" name="zipCode" value="<%= zipCode %>">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">주소 1</label>
				<div class="col-sm-10">
					<input type="text" name="address01" value="<%= address01 %>">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">주소 2</label>
				<div class="col-sm-10">
					<input type="text" name="address02" value="<%= address02 %>">
				</div>
			</div>
			<div class="form-group row">
				<div class="col-sm-10">
					<input type="submit" class="btn btn-primary" value="수정">
					<a href="processRemoveMember.jsp" class="btn btn-primary">회원탈퇴</a>
				</div>
			</div>
		</form>
	</div>
	<%
		}
	%>
	<jsp:include page="../inc/footer.jsp" />