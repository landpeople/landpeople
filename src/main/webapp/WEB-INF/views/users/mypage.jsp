<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이 페이지 회원정보 수정 가능</title>
</head>
<body>
세션 : ${session}
<br>

ldto :${ldto}<br>
<div>
<form action="./modifyMypage.do" method="post">
이메일 : <input type="text" name="user_email" value="${ldto.user_email}" readonly="readonly"><br>
비밀번호 : <input type="text" name="user_password"><br>
비밀번호 확인 : <input type="text"><br>


닉네임 : <input type="text" name="user_nickname" value="${ldto.user_nickname}"><br>
<input type="submit" value="수정">
</form>
</div>


</body>
</html>
