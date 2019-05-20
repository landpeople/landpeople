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
<link rel="stylesheet" type="text/css" href="./css/sweetalert.css">
<link rel="stylesheet" type="text/css" href="./css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="./css/bootstrap-theme.min.css">
<link rel="stylesheet" type="text/css" href="./css/SignUp.css">
<script type="text/javascript" src="./js/jquery-3.3.1.js"></script>
<script type="text/javascript" src="./js/bootstrap.min.js"></script>
<script type="text/javascript" src="./js/sweetalert.min.js"></script>

<script type="text/javascript">

function regicheck() {
// email 중복 + 유효값
var emailchk = document.getElementById("emailchkVal").value;
var pwchk = document.getElementById("pwchkVal").value;
var nicknamechk = document.getElementById("nicknamechkVal").value;

var pw = document.getElementById("pw").value;
var passOK = document.getElementById("passOK").value;

if(emailchk=="1" && pwchk == "1" && nicknamechk=="1" && pw ==passOK){
	swal("회원가입 완료","이메일 인증 후 로그인 해주세요");
	return true;
}else{
	swal("회원가입 실패", "입력 정보를 확인해주세요");
	$("#passOK").val("");
	$("#pwresult").html("");
	$("#pwchk").html("");
	return false;
}

     
     
}


$(function() {
	//이메일 유효성 검사
	$("#email").keyup(function() {
		var email = $(this).val();
		alert(email);


	var regExp =  /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	
	if(email.indexOf(" ") !=-1){
		$("emailresult").css("color","red");
		$("emailresult").html("공백이 포함된 이메일은 사용이 불가능 합니다");
		$("emailchkVal").val("0");
	}else if(email.match(regExp)==null){
		$("#emailresult").css("color","red");
		$("#emailresult").html("이메일 주소를 형식에 맞게 입력하세요");
		$("emailchkVal").val("0");
	}else if (email.match(regExp) != null){
		$.ajax({
			url : "./emailchk.do",
			async : true,
			type: "post",
			data : "user_email"+email,
			dataType: "String",
			success: function(msg) {
			if(msg.substr(0,10)=="사용가능한 이메일"){
				$("#emailresult").css("color","forestgreen");
				$("#emailresult").html("사용가능한 이메일입니다.");
				$("#emailchkVal").val("1");
			}else{
				$("#emailresult").css("color","red");
				$("#emailresult").html("사용 불가능한 이메일입니다.");
				$("#emailchkVal").val("0");
			}
			} , error : function () {
				alert("실패"); 
				alert(email);
			}
		});
	}
	});//이메일유효성 끝
	
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
			$("#pwchkVal").val("1");
		} else {
			$("#pwchk").css("color", "red");
			$("#pwchk").html("비밀번호가 일치하지 않습니다.");
			$("#pwchkVal").val("0");
		}
	});
	
	
	
});//제일큰








</script>
<body>
<h1>환영합니다 ~~~~ landpeople</h1>

<div>
<input type="hidden" value="0" id="emailchkVal">
<input type="hidden" value="0" id="pwchkVal">
<input type="hidden" value="0" id="nicknamechkVal">
<form action="./signUp.do" method="post" onsubmit="return regicheck()">

<input type="text" name="user_email" id="email" placeholder="이메일" required="required">
<br>&nbsp;&nbsp;<span id="emailresult"></span><br>

<input type="text"  name="user_password" id="pw" placeholder="비밀번호" required="required" maxlength="12">
<br>&nbsp;<span id="pwresult">4~10자리의 영문+숫자</span><br>

<input type="text" id="passOK" placeholder="비밀번호 확인" required="required" maxlength="12">
<br>&nbsp;<span id="pwchk"></span><br>

<input type="text" name="user_nickname" id="nickname" placeholder="닉네임" required="required" maxlength="10"><br><br>

<input type="submit" value="가입!">

<input type="button" value="돌아가기" onclick="javascript:history.back(-1)">
</form>
</div>


</body>
</html>
