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

<h1 style="text-align:center">로그인 해주세요</h1>

<div>
<form action="./login.do" method="post" >

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
</div>

${url}


<!-- 네이버 로그인 화면으로 이동 시키는 URL -->
<!-- 네이버 로그인 화면에서 ID, PW를 올바르게 입력하면 callback 메소드 실행 요청 -->
<div id="naver_id_login" style="text-align:center">
<a href="${url}">
<img width="223" src="https://developers.naver.com/doc/review_201802/CK_bEFnWMeEBjXpQ5o8N_20180202_7aot50.png"/>
</a>
</div>
<br>
</body>
</html>
