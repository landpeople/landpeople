<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    //여기서 api가입자인지 확인해야함...
    //db에 있는지도

    function emailauth() {
	var emailchk = document.getElementById("emailchkVal").value;

	if (emailchk == "1") {
	    alert("이메일로 전송하였습니다.");
	    return true;
	} else {
	    alert("이메일을 확인해주세요;");
	    return false;
	}

    }// fx email

    $(function() {
	// 이메일 유효성 검사
	$("#email").keyup(
			function() {
			    var email = $(this).val();

			    var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

			    if (email.indexOf(" ") != -1) {
				$("emailresult").css("color", "red");
				$("emailresult").html(
					"공백이 포함된 이메일은 사용이 불가능 합니다");
				$("emailchkVal").val("0");
			    } else if (email.match(regExp) == null) {
				$("#emailresult").css("color", "red");
				$("#emailresult").html("이메일 주소를 형식에 맞게 입력하세요");
				$("emailchkVal").val("0");
			    } else if (email.match(regExp) != null) { // 여기서부터 수정이 필요함
				$.ajax({
				    url : "./findEmailchk.do",
				    async : true,
				    type : "post",
				    data : "user_email=" + email,
				    success : function(msg) {
					if (msg == "U") {
					    //alert(msg);
					    $("#emailresult").css("color",
						    "forestgreen");
					    $("#emailresult").html(
						    "입력을 누르시면 이메일로 전송이 됩니다.");
					    $("#emailchkVal").val("1");
					} else if (msg == "N") {
					    //alert(msg);
					    $("#emailresult").css("color",
						    "red");
					    $("#emailresult").html(
						    "네이버로그인 가입자입니다.");
					    $("#emailchkVal").val("0");
					} else if (msg == "G") {
					    $("#emailresult").css("color",
						    "red");
					    $("#emailresult").html(
						    "구글로그인 가입자입니다.");
					    $("#emailchkVal").val("0");
					} else if (msg == "0") {
					    $("#emailresult").css("color",
						    "red");
					    $("#emailresult").html(
						    "회원가입하지 않은 이메일입니다.");
					    $("#emailchkVal").val("0");
					}
				    }
				});

			    }

			});
    });
</script>
<body class="bg-gray-100">
   <div class="container">
      <!-- Outer Row -->
      <div class="row justify-content-center">

         <div class="col-xl-5 col-lg-5 col-md-5">

            <div class="card o-hidden border-0 shadow-lg my-5">
               <div class="card-body p-0">
                  <div class="p-5">
                     <div class="text-center">
                        <h1 class="h4 text-gray-900 mb-2">Forgot Your Password?</h1>
                        <p class="mb-4">We get it, stuff happens. Just enter your email address below and we'll send you a link to reset your password!</p>
                     </div>
                     <input type="hidden" value="0" id="emailchkVal">
                     <form class="user" action="./findPW.do" method="get" onsubmit="return emailauth()">
                        <div class="form-group">
                           <input type="email" class="form-control form-control-user" id="email" name="user_email" aria-describedby="emailHelp" placeholder="Enter Email Address..." required="required">
                           &nbsp;<span id="emailresult"></span>
                        </div>
                        <input type="submit" class="btn btn-primary btn-user btn-block" value="Reset Password">
                     </form>
                     <hr>
                     <div class="text-center">
                        <a class="small" href="./regiForm.do">Create an Account!</a>
                     </div>
                     <div class="text-center">
                        <a class="small" href="./loginPage.do">Already have an account? Login!</a>
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
