<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./css/lp-style.css">
<script type="text/javascript" src="./js/jquery-3.3.1.js"></script>
<script type="text/javascript">
/* 

function login() {
	// email 중복 + 유효값
	var emailchk = document.getElementById("emailchkVal").value;


	if(emailchk=="1"){
		return true;
	}else{
		alert("이메일 확인해주세요");
		return false;
	}

	     
	     
	}


$(function() {
	$("#email").keyup(function() {
		var email = $(this).val();
		//alert(email);
		
		var regExp =  /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		
		if(email.indexOf(" ") !=-1){
			$("emailresult").css("color","red");
			$("emailresult").html("공백이 포함되었습니다");
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
				data : "user_email="+email,
				success: function(msg) {
				if(msg=="0"){
					//alert(msg);
					$("#emailresult").css("color","red");
					$("#emailresult").html(" ");
					$("#emailchkVal").val("0");
				}else{
					//alert(msg);
					$("#emailresult").html(" ");
					$("#emailchkVal").val("1");
				}
				} , error : function () {
					alert("실패"); 
					alert(email);
				}
			});
		}
		
		
	});
});

 */
</script>
<title>여긴 로그인 페이지</title>
<% String pwno = (String)request.getAttribute("no"); 
	String eChk = (String)request.getAttribute("eChk");
	
	if(pwno !=null){
		%>
		<script type="text/javascript">
			alert("패스워드가 일치하지않습니다");
			location.href="./loginPage.do";
		</script>
		<%
	}
	
	if(eChk != null){
		%>
		<script type="text/javascript">
			alert("이메일인증후 로그인 가능합니다");
			location.href="./loginPage.do";
		</script>
		<%
	}
	
	
%>

</head>
<body>
   <!--젤로 레이아웃- 전체 영역 감싸는 div-->
   <div class="main-wrapper">
      <h1 style="text-align: center">로그인 해주세요</h1>
      <input type="hidden" value="0" id="emailchkVal">
      <form action="./login.do" method="post" onsubmit="return login()">
         <table>
            <tr>
               <td>
                  <input type="text" name="user_email" id="email" placeholder="이메일" required="required">
               </td>
               <td>
               	<span id="emailresult"></span>
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
      <!-- </div> 여기까지 메인 컨텐츠  -->

      <form action="./regiForm.do" method="get">
         <input type="submit" value="회원가입">
      </form>
      ${url}

      <!-- 네이버 로그인 화면으로 이동 시키는 URL -->
      <!-- 네이버 로그인 화면에서 ID, PW를 올바르게 입력하면 callback 메소드 실행 요청 -->
      <div id="naver_id_login" style="text-align: center">
         <a href="${url}">
            <img width="223" src="https://developers.naver.com/doc/review_201802/CK_bEFnWMeEBjXpQ5o8N_20180202_7aot50.png" />
         </a>
      </div>
      <br>

      <!-- 구글 로그인 화면으로 이동 시키는 URL -->
      <!-- 구글 로그인 화면에서 ID, PW를 올바르게 입력하면 oauth2callback 메소드 실행 요청-->
      ${google_url}
      <div id="google_id_login" style="text-align: center">
         <a href="${google_url}">
            <img width="230" src="${pageContext.request.contextPath}/img/googlelogin.png" />
         </a>
      </div>
      
	<a href="./inputemail.do">비밀번호찾기</a>
   </div>




</body>
</html>
