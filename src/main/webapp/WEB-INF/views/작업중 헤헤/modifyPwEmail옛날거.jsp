<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이메일로 비밀번호 찾기 </title>
<link rel="stylesheet" type="text/css" href="./css/sweetalert.css">
<link rel="stylesheet" type="text/css" href="./css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="./css/bootstrap-theme.min.css">
<script type="text/javascript" src="./js/jquery-3.3.1.js"></script>
<script type="text/javascript" src="./js/bootstrap.min.js"></script>
<script type="text/javascript" src="./js/sweetalert.min.js"></script>

<script type="text/javascript">
function pwcheck() {
	// email 중복 + 유효값
	var pwchk = document.getElementById("pwchkVal").value;
	var passchk = document.getElementById("passchkVal").value;

	var pw = document.getElementById("pw").value;
	var passOK = document.getElementById("passOK").value;

	if(pwchk == "1" && passchk == "1" && pw ==passOK){
		alert("로그인하고 이용해주세요");
		return true;
	}else{
		alert("비밀번호를 형식에 맞쳐 일치하게 입력해주세요");
		$("#pw").val("");
		$("#passOK").val("");
		$("#pwresult").html("");
		$("#pwchk").html("");
		return false;
	}
}




$(function() {
	
	
	$("#pw").keyup(function() {
		var pw = $(this).val();
		var regex =/^[A-Za-z0-9]{4,10}$/;
		
		if(pw.indexOf(" ") != -1){
			$("#pwresult").css("color", "red");
			$("#pwresult").html("공백 사용 불가능");
			$("pwchkVal").val("0");
		} else if(pw.match(regex) !=null){
			$("#pwresult").css("color", "forestgreen");
			$("#pwresult").html("사용가능한 비밀번호 입니다.");
			$("#pwchkVal").val("1");
		} else {
			$("#pwresult").css("color", "red");
			$("#pwresult").html("4~10자리의 영문, 숫자를 입력해주세요");
			$("#pwchkVal").val("0");
		}
	});
	
	
	$("#passOK").keyup(function() {
		var passOK = $(this).val();
		var pw = $("#pw").val();
		
		if(passOK==pw){
			$("#pwchk").css("color", "forestgreen");
			$("#pwchk").html("비밀번호가 일치합니다.");
			$("#passchkVal").val("1");
		} else {
			$("#pwchk").css("color", "red");
			$("#pwchk").html("비밀번호가 일치하지 않습니다.");
			$("#passchkVal").val("0");
		}
	});
	
	
	
	
});//제일큰


</script>

<% String user_email =  (String)request.getAttribute("user_email");%>

</head>
<body>
<h1>여기는 이메일로 비밀번호찾기 페이지로 오는곳임</h1><br>
어케만들어야하지?????흠,,,,,,,


<h2>변경할 비밀번호를 입력해주세요
</h2><br>

<%=user_email%>

<input type="hidden" value="0" id="pwchkVal">
<input type="hidden" value="0" id="passchkVal">
<form action="./modifyPwSuc.do" method="post" onsubmit="return pwchkeck()">
<input type="hidden" name="user_email" value="<%=user_email%>">
	<input type="text" id="pw" name="user_password" placeholder="비밀번호" required="required" max="10">
	<br>&nbsp;<span id="pwresult">4~10자리의 영문+숫자</span><br>
	<input type="text" id="passOK" placeholder="비밀번호확인" required="required" max="10">
	<br>&nbsp;<span id="pwchk"></span><br>
	
	<input type="submit" value="변경!!">
</form>




</body>
</html>
