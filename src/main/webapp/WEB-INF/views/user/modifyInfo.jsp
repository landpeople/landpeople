<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html>
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">




<title>마이 페이지 회원정보 수정 가능</title>

<!-- Custom fonts for this template-->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="./css/sweetalert.css">
<!-- Custom styles for this template-->
<link href="./css/theme/sb-admin-2.min.css" rel="stylesheet">
<script type="text/javascript" src="./js/jquery-3.3.1.js"></script>



<script type="text/javascript">
	function modify() {
		// email 중복 + 유효값
		var pwchk = document.getElementById("pwchkVal").value;
		var passchk = document.getElementById("passchkVal").value;
		var nicknamechk = document.getElementById("nicknamechkVal").value;

		var pw = document.getElementById("pw").value;
		var passOK = document.getElementById("passOK").value;

		if (pwchk == "1" && passchk == "1"
				&& pw == passOK) {
			alert("회원 정보가 수정 되었습니다");
			return true;
		}else if(nicknamechk == "1"){
			alert("회원 정보가 수정 되었습니다");
			return true;
		} 
		
		else {
			alert("회원 정보를 확인해주세요");
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
			var regex = /^[A-Za-z0-9]{4,10}$/;

			if (pw.indexOf(" ") != -1) {
				$("#pwresult").css("color", "red");
				$("#pwresult").html("공백 사용 불가능");
				$("pwchkVal").val("0");
			} else if (pw.match(regex) != null) {
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

			if (passOK == pw) {
				$("#pwchk").css("color", "forestgreen");
				$("#pwchk").html("비밀번호가 일치합니다.");
				$("#passchkVal").val("1");
			} else {
				$("#pwchk").css("color", "red");
				$("#pwchk").html("비밀번호가 일치하지 않습니다.");
				$("#passchkVal").val("0");
			}
		});

		//닉네임 작성시 유효성 검사 (자리수 2~10 , 닉네임 중복여부 , 공백포함여부)
		$("#nickname").keyup(
				function() {
					var inputLen = $(this).val().length;
					//	alert(inputLen);

					var nickname = $(this).val();
					//	alert(nickname);

					// 닉네임 정규표현식
					var regex = /^[\w\Wㄱ-ㅎㅏ-ㅣ가-힣]{2,10}$/;

					// 공백여부 검사
					if (nickname.indexOf(" ") != -1) {
						$("#nicknameresult").css("color", "red");
						$("#nicknameresult").html("공백이 포함된 아이디는 사용 불가능합니다");
						$("#nicknamechkVal").val("0");
					} else if (inputLen > 1 && nickname.match(regex) != null) {
						//2자리 이상 공백 없는 닉네임 입력시 중복 여부 검사
						//alert("아작스실행하자");

						$.ajax({
							url : "./nicknamecheck.do",
							type : "post",
							data : "user_nickname=" + $(this).val(),
							async : true,
							success : function(msg) {
								//alert(msg)
								//					alert(msg.substr(0, 10)); // 사용 가능한 아이디 / 사용 불가능한 아이
								$("#nicknameresult").html(msg);
								if (msg == "0") {
									$("#nicknameresult").css("color",
											"forestgreen");
									$("#nicknameresult").html("사용가능한 닉네임입니다.");
									$("#nicknamechkVal").val("1");
								} else {
									$("#nicknameresult").css("color", "red");
									$("#nicknameresult")
											.html("이미 존재하는 닉네임입니다.");
									$("#nicknamechkVal").val("0");
								}

							},
							error : function() {
								alert("실패");
								alert(nickname);
							}
						});
					} else {
						$("#nicknameresult").css("color", "red");
						$("#nicknameresult").html(
								"닉네임은 2~10 사이 영문, 한글, 숫자만 사용 가능합니다.");
					}

				});

	});//제일큰
</script>


<style type="text/css">

span{
	font-size: .8rem;
}

</style>

</head>
<body>
${ldto.user_email}
	<!--젤로 레이아웃- 전체 영역 감싸는 div-->
	<div class="main-wrapper">
		<%@include file="../common/Sidebar.jsp"%>
		<div class="content-wrapper">

			<!-- 메인 컨텐츠   -->
			<div class="lpcontents">
				<div class="content">







<div class="bg-gradient-primary" >

	<div class="container" >
		<div class="row justify-content-center">
			<div class="col-xl-5 col-md-5 col-lg-5">
				<div class="card o-hidden border-0 shadow-lg my-5"> 
					<div class="card-body p-0">  
						<!-- Nested Row within Card Body -->
						<!--                <div class="col-lg-7"> -->
						 <div class="p-5">
							<div class="text-center">
								<h1 class="h4 text-gray-900 mb-4"><strong>My Page!</strong></h1>
							</div>

							<input type="hidden" value="0" id="emailchkVal"> 
						<input type="hidden" value="0" id="pwchkVal"> 
						<input type="hidden" value="0" id="passchkVal"> 
						<input type="hidden" value="0" id="nicknamechkVal">
							<form class="user" action="./modifyMypage.do" method="post" onsubmit="return modify()">
								<div class="form-group">
									<input type="email" name="user_email"  class="form-control form-control-user" value="${ldto.user_email}" readonly="readonly">
								</div>
								
								<c:if test="${ldto.user_auth eq 'U'}">
								
							<div class="text-center">
								<h1 class="h4 text-gray-900 mb-4">비밀번호 변경</h1>
							</div>
								<div class="form-group">
									<input type="password" name="user_password" id="pw" class="form-control form-control-user" placeholder="Password" maxlength="10">
								&nbsp;<span id="pwresult">4~10자리의 영문+숫자</span>
								</div>
								<div class="form-group">
									<input type="password" id="passOK" class="form-control form-control-user" placeholder="Repeat Password" maxlength="10">
								&nbsp;<span id="pwchk"></span>
								</div>
								</c:if>
								
								<div class="text-center">
								<h1 class="h4 text-gray-900 mb-4">닉네임 변경</h1>
							</div>
								
								<div class="form-group">
									<input type="text" name="user_nickname" id="nickname" class="form-control form-control-user" placeholder="Nick Name" value="${ldto.user_nickname}" maxlength="10">
									&nbsp;<span id="nicknameresult">2~10자리의 닉네임을 입력</span>
								</div>
								<div class="form-group">
									<input type="submit" class="btn btn-primary btn-user btn-block" value="수정">
								</div>
							</form>
							<hr>
							
							<form class="user" action="./delpage.do" method="get">
							<div class="form-group">
								<input type="submit" class="btn btn-primary btn-user btn-block" value="회원탈퇴" style="background-color: #B40404; border-color: #B40404;">
								</div>
							</form>
							
						</div>
					</div> <!--card-body p-0 -->
				
				
				</div> <!--card o-hidden border-0 shadow-lg my-5 -->
			</div>
		</div>
	</div>

	<!-- Bootstrap core JavaScript-->
	<script src="./js/theme/jquery.min.js"></script>
	<script src="./js/theme/bootstrap.bundle.min.js"></script>


	<!-- Custom scripts for all pages-->
	<script src="./js/theme/sb-admin-2.min.js"></script>
</div>







					--메인페이지 : ${ldto}<br> 
					---세션 : ${session} <br>
					-- ldto :${ldto}<br>























				</div>
			</div>
			<!-- </div> 여기까지 메인 컨텐츠  -->
			<div class="footer">landpeople</div>
		</div>
	</div>
</body>