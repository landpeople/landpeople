<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이메일 입력해주셈</title>
</head>
<script type="text/javascript" src="./js/jquery-3.3.1.js"></script>
<script type="text/javascript">
//여기서 api가입자인지 확인해야함...
//db에 있는지도

function emailauth() {
	var emailchk = document.getElementById("emailchkVal").value;


	if(emailchk=="1"){
		alert("이메일로 전송해드렸습니다");
		return true;
	}else{
		alert("이메일을 입력하고 눌러라;");
		return false;
	}
	
}// fx email


$(function() {
	// 이메일 유효성 검사
	$("#email").keyup(function() {
		var email = $(this).val();
		
		var regExp =  /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		
		if(email.indexOf(" ") !=-1){
			$("emailresult").css("color","red");
			$("emailresult").html("공백이 포함된 이메일은 사용이 불가능 합니다");
			$("emailchkVal").val("0");
		}else if(email.match(regExp)==null){
			$("#emailresult").css("color","red");
			$("#emailresult").html("이메일 주소를 형식에 맞게 입력하세요");
			$("emailchkVal").val("0");
		}else if (email.match(regExp) != null){ // 여기서부터 수정이 필요함
			$.ajax({
				url : "./findEmailchk.do",
				async : true,
				type: "post",
				data : "user_email="+email,
				success: function(msg) {
				if(msg=="U"){
					//alert(msg);
					$("#emailresult").css("color","forestgreen");
					$("#emailresult").html("입력을 누루시면 이메일로 전송이 됩니다.");
					$("#emailchkVal").val("1");
				}else if(msg == "N"){
					//alert(msg);
					$("#emailresult").css("color","red");
					$("#emailresult").html("네이버로그인 가입자입니다.");
					$("#emailchkVal").val("0");
				}else if(msg == "G"){
					$("#emailresult").css("color","red");
					$("#emailresult").html("구글로그인 가입자입니다.");
					$("#emailchkVal").val("0");
				}else if(msg =="0"){
					$("#emailresult").css("color","red");
					$("#emailresult").html("회원가입하지 않은 이메일입니다.");
					$("#emailchkVal").val("0");
					
				}
			}, error : function () {
				alert("실패"); 
				
			}
		});
		
		}
		
	});
});



</script>

<body>

<h1>가입하신 이메일을 입력해주세요</h1>
<div>
<input type="hidden" value="0" id="emailchkVal">
<form action="./findPW.do" method="get" onsubmit="return emailauth()">

<input type="text" id="email" name="user_email"><br>

&nbsp;&nbsp;<span id="emailresult"></span><br>

<input type="submit" value="입력">

</form>
</div>

</body>



</html>
