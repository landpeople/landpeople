<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String user_email =  (String)request.getAttribute("user_email");%>
<!DOCTYPE html>
<html lang="en">

<head>
<link rel="shortcut icon" href="./img/favicon.ico" type="image/x-icon">
<link rel="icon" href="./css/theme/sb-admin-2.css" type="image/x-icon">

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="LandPeople">

<title>제주도 여행 일정 공유 커뮤니티 | 육지사람</title>

<!-- Custom fonts for this template-->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

<link rel="stylesheet" type="text/css" href="./css/sweetalert.css">

<!-- Custom styles for this template-->
<link href="./css/theme/sb-admin-2.css" rel="stylesheet">
<link href="./css/theme/lp-template.css" rel="stylesheet">
<link href="./css/sketch/sketch.css" rel="stylesheet">
<link href="./css/sketch/modal.css" rel="stylesheet">
<link href="./css/theme/checkradio.min.css" rel="stylesheet">

</head>

<script type="text/javascript" src="./js/jquery-3.3.1.js"></script>

<script type="text/javascript">
function pwcheck() {
   // email 중복 + 유효값
   var pwchk = document.getElementById("pwchkVal").value;
   var passchk = document.getElementById("passchkVal").value;

   var pw = document.getElementById("pw").value;
   var passOK = document.getElementById("passOK").value;

   if(pwchk == "1" && passchk == "1" && pw ==passOK){
      alert("로그인 후 이용해주세요");
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

//아작스
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

<style type="text/css">

span{
   font-size: .8rem;
}

</style>


<body>

	<div class="container">
		<div class="row justify-content-center">
			<div class="col-xl-5 col-md-5 col-lg-5">
				<div class="card o-hidden border-0 shadow-lg my-5">
					<div class="card-body p-0">
						<!-- Nested Row within Card Body -->
						<!--                <div class="col-lg-7"> -->
						<div class="p-5">
							<div class="text-center">
								<h1 class="h4 text-gray-900 mb-4">비밀번호 수정</h1>
							</div>

						<input type="hidden" value="0" id="pwchkVal">

						<input type="hidden" value="0" id="passchkVal">
							<form class="user" action="./modifyPwSuc.do" method="post" onsubmit="return pwcheck()">
							<input type="hidden" name="user_email" value="<%=user_email%>">
								<div class="form-group">
									<input type="password"  name="user_password" class="form-control form-control-user" id="pw" placeholder="Password" required="required" maxlength="10">
								&nbsp;<span id="pwresult">4~10자리의 영문+숫자</span>
								</div>
								<div class="form-group">
									<input type="password" class="form-control form-control-user" id="passOK" placeholder="Repeat Password" maxlength="10" required="required">
								&nbsp;<span id="pwchk"></span>
								</div>
								<div class="form-group">
									<input type="submit" class="btn btn-primary btn-user btn-block" value="변경!">
								</div>
							</form>
							<hr>
							<div class="text-center">
								<a class="small" href="./loginPage.do">Login!</a>
							</div>
						</div>
					</div>
					<!--          </div> -->
				</div>
			</div>
		</div>
	</div>

	<!-- Bootstrap core JavaScript-->
	<script src="./js/theme/jquery.min.js"></script>
	<script src="./js/theme/bootstrap.bundle.min.js"></script>


	<!-- Custom scripts for all pages-->
	<script src="./js/theme/sb-admin-2.min.js"></script>
	
</body>
</html>
