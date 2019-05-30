<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이메일 전송</title>
</head>
<body>
<h1>이메일은 전송했습니다</h1>
<p>이메일 인증후 로그인 가능합니다</p>
<form action="./loginPage.do" method="get">
	<input type="submit" value="로그인">
</form>
</body>
</html>
