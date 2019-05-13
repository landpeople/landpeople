<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 하러옴 regiForm페이지</title>
</head>
<script type="text/javascript">
function regicheck() {
	
}


</script>
<body>
<h1>회원가입</h1>

<form action="./signUp.do" method="post" onsubmit="return regicheck()">
<table>
	<tr>
		<td>
			<input type="text" name="email" placeholder="이메일" required="required">
		</td>
	</tr>
	<tr>
		<td>
			<input type="text" id="pw" name="pw" placeholder="비밀번호" required="required" maxlength="12">
			<br>&nbsp;<span id="pwresult">4~10자리의 영문+숫자</span><br>
		</td>
	</tr>
	<tr>
		<td>
			<input type="text" id="pwOK" placeholder="비밀번호 확인" required="required" maxlength="12">
			<br> 
			<br>&nbsp;<span id="pwchk"></span><br>
		</td>
	</tr>
	
	<tr>
		<td>
			<input type="text" name="nickname" placeholder="닉네임" required="required" maxlength="10">
		</td>
	</tr>
	
	<tr>
		<td>
			<input type="submit" value="가입!">
		</td>
	</tr>
</table>


</form>

</body>
</html>
