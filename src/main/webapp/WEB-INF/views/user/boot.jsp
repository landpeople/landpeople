<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>SB Admin 2 - Register</title>

<!-- Custom fonts for this template-->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="./css/sweetalert.css">
<!-- Custom styles for this template-->
<link href="./css/theme/sb-admin-2.min.css" rel="stylesheet">
<script type="text/javascript" src="./js/jquery-3.3.1.js"></script>
</head>

<script type="text/javascript">

</script>

<body class="bg-gradient-primary">

	<div class="container">
		<div class="row justify-content-center">
			<div class="col-xl-5 col-md-5 col-lg-5">
				<div class="card o-hidden border-0 shadow-lg my-5">
					<div class="card-body p-0">
						<!-- Nested Row within Card Body -->
						<!--                <div class="col-lg-7"> -->
						<div class="p-5">
							<div class="text-center">
								<h1 class="h4 text-gray-900 mb-4">회원 수정</h1>
							</div>

							<input type="hidden" value="0" id="emailchkVal"> 
							<input type="hidden" value="0" id="pwchkVal"> 
							<input type="hidden" value="0" id="nicknamechkVal">
							<form class="user" action="./signUp.do" method="post" onsubmit="return regicheck()">
								<div class="form-group">
									<input type="email" name="user_email"  class="form-control form-control-user" id="email" placeholder="Email Address" required="required">
									&nbsp;<span id="emailresult"></span>
								</div>
								<div class="form-group">
									<input type="password" name="user_password" class="form-control form-control-user" id="pw" placeholder="Password" required="required" maxlength="12">
								&nbsp;<span id="pwresult">4~10자리의 영문+숫자</span>
								</div>
								<div class="form-group">
									<input type="password" class="form-control form-control-user" id="passOK" placeholder="Repeat Password" maxlength="12" required="required">
								&nbsp;<span id="pwchk"></span>
								</div>
								<div class="form-group">
									<input type="text" name="user_nickname" class="form-control form-control-user" id="nickname" placeholder="Nick Name" maxlength="10" required="required">
									&nbsp;<span id="nicknameresult">2~10자리의 닉네임을 입력</span>
								</div>
								<div class="form-group">
									<input type="submit" class="btn btn-primary btn-user btn-block" value="Register Account">
								</div>
							</form>
							<hr>
							<div class="text-center">
								<a class="small" href="./inputemail.do">Forgot Password?</a>
							</div>
							<div class="text-center">
								<a class="small" href="./loginPage.do">Already have an account? Login!</a>
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
