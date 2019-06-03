<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<!-- login.jsp 여기로와지냐? -->
<head>
<meta charset="UTF-8">
<title>login.jsp여기임</title>

<meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>SB Admin 2 - Login</title>

  <!-- Custom fonts for this template-->
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <link rel="stylesheet" type="text/css" href="./css/sweetalert.css">

  <!-- Custom styles for this template-->
  <link href="./css/theme/sb-admin-2.min.css" rel="stylesheet">

</head>

<script type="text/javascript" src="./js/jquery-3.3.1.js"></script>
<% String pwno = (String)request.getAttribute("no"); 
	String eChk = (String)request.getAttribute("eChk");
	
	String eno = (String)request.getAttribute("eno");
	
	String delflag = (String)request.getAttribute("delflag");
	
	String apiuser = (String)request.getAttribute("apiuser");
	
	String apiEmailDupN = (String)request.getAttribute("apiEmailDupN");
	
	String apiEmailDupG = (String)request.getAttribute("apiEmailDupG");
	if(apiuser != null){
		%>
		<script type="text/javascript">
			alert("네이버 또는 구글 가입자 입니다");
			location.href="./loginPage.do";
		</script>
		<%
	}
	
	if(eno != null){
		%>
		<script type="text/javascript">
			alert("이메일을 확인해주세요");
			location.href="./loginPage.do";
		</script>
		<%
	}
	
	
	if(delflag != null){
		%>
		<script type="text/javascript">
			alert("회원탈퇴자입니다. 관리자에게 문의하세요.");
			location.href="./loginPage.do";
		</script>
		<%
	}
	
	if(pwno !=null){
		%>
		<script type="text/javascript">
			alert("패스워드가 일치하지 않습니다.");
			location.href="./loginPage.do";
		</script>
		<%
	}
	
	if(eChk != null){
		%>
		<script type="text/javascript">
			alert("이메일 인증 후 로그인이 가능합니다.");
			location.href="./loginPage.do";
		</script>
		<%
	}
	
	
	if(apiEmailDupN != null){
		%>
		<script type="text/javascript">
			alert("같은 이메일이 구글 또는 일반 로그인으로 가입되있습니다");
			location.href="./loginPage.do";
		</script>
		<%
	}
	
	if(apiEmailDupG != null){
		%>
		<script type="text/javascript">
			alert("같은 이메일이 네이버 또는 일반 로그인으로 가입되있습니다");
			location.href="./loginPage.do";
		</script>
		<%
	}
	
%>




<body class="bg-gradient-primary"><!-- 배경색을 결정하는 클래스 -->
  <div class="container">
    <!-- Outer Row -->
    <div class="row justify-content-center">
      <div class="col-xl-5 col-md-5 col-lg-5">
        <div class="card o-hidden border-0 shadow-lg my-5">
          <div class="card-body p-0">
            <!-- Nested Row within Card Body -->
                <div class="p-5"><!-- padding:3rem!important -->
                  <div class="text-center">
                    <h1 class="h4 text-gray-900 mb-4">반갑수다!</h1>
                  </div>
                 
                 
                 
                 
                 
                  <form class="user" action="./login.do" method="post" onsubmit="return login()">
                    <div class="form-group">
                      <input type="email" class="form-control form-control-user" name="user_email" id="email" aria-describedby="emailHelp" placeholder="Enter Email Address..." required="required">
                    </div>
                    <div class="form-group">
                      <input type="password" class="form-control form-control-user" name="user_password" placeholder="Password" required="required">
                    </div>
                    <input type="submit" class="btn btn-primary btn-user btn-block" value="Login">
                  </form>
                
                
                
                
                
                
                    <hr>
                    <!-- google -->
                    <form class="user">
                    <a href="${google_url}" id="google_id_login" class="btn btn-google btn-user btn-block">
                      <i class="fab fa-google fa-fw"></i> Login with Google
                    </a>
                 	</form>
                 	<!-- naver -->
                 	<form class="user">
                    <a href="${url}" id="naver_id_login" class="btn btn-naver btn-user btn-block">
                      <i class="fab fa-neos fa-fw"></i> Login with Naver
                    </a>
                 	</form>
                 
                  <hr>
                  <div class="text-center">
                    <a class="small" href="./inputemail.do">Forgot Password?</a>
                  </div>
                  <div class="text-center">
                    <a class="small" href="./regiForm.do">Create an Account!</a>
                  </div>
            </div>
          </div>
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
