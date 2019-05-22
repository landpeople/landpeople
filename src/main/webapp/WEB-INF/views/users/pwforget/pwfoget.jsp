<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이메일로 비밀번호 찾기 </title>
</head>
<body>
<h1>여기는 이메일로 비밀번호찾기 페이지로 오는곳임</h1>
어케만들어야하지?????흠,,,,,,,


<h2>변경할 비밀번호를 입력해주세요
</h2>




<form action="./pwforget.do" method="post">
	<input type="text" id="pw" name="user_password" placeholder="비밀번호" required="required" max="12">
	<br>&nbsp;<span id="pwresult">4~10자리의 영문+숫자</span><br>
	<input type="text" id="passOK" placeholder="비밀번호확인" required="required" max="12">
	<br>&nbsp;<span id="pwchk"></span><br>
	
	<input type="submit" value="변경!!">
</form>




</body>
</html>
