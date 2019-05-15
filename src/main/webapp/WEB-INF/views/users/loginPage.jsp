<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>여긴 로그인 페이지</title>
</head>
<body>
<h1>로그인 해주세요</h1>


<form action="./login.do" method="post">
	<table>
		<tr>
			<td>
				<input type="text" name="user_email" placeholder="이메일" required="required">
			</td>
		</tr>
		<tr>
			<td>
				<input type="text" name="user_password" placeholder="비밀번호" required="required">
			</td>
		</tr>
		<tr>
			<td>
				<input type="submit" value="이메일 로그인">
			</td>
		</tr>
	</table>
</form>


</body>
</html>
