<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
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
<link href="./css/theme/sb-admin-2.min.css" rel="stylesheet">
<link href="./css/theme/sb-admin-2.css" rel="stylesheet">
<link href="./css/theme/lp-template.css" rel="stylesheet">
<head>
<script type="text/javascript" src="./js/jquery-3.3.1.js"></script>

<style type="text/css">
span {
	font-size: .8rem
}
</style>

</head>

<script type="text/javascript">
    function regicheck() {
	// email 중복 + 유효값
	var emailchk = document.getElementById("emailchkVal").value;
	var pwchk = document.getElementById("pwchkVal").value;
	var passchk = document.getElementById("passchkVal").value;
	var nicknamechk = document.getElementById("nicknamechkVal").value;

	var pw = document.getElementById("pw").value;
	var passOK = document.getElementById("passOK").value;

	if (emailchk == "1" && pwchk == "1" && passchk == "1"
		&& nicknamechk == "1" && pw == passOK) {
	    alert("이메일 인증 후 로그인 해주세요");
	    return true;
	} else {
	    alert("입력 정보를 확인해주세요");
	    $("#pw").val("");
	    $("#passOK").val("");
	    $("#pwresult").html("");
	    $("#pwchk").html("");
	    return false;
	}

    }

    $(function() {
	//이메일 유효성 검사
	$("#email")
		.keyup(
			function() {
			    var email = $(this).val();
			    //	alert(email);

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
			    } else if (email.match(regExp) != null) {
				$.ajax({
				    url : "./emailchk.do",
				    async : true,
				    type : "post",
				    data : "user_email=" + email,
				    success : function(msg) {
					if (msg == "0") {
					    //alert(msg);
					    $("#emailresult").css("color",
						    "forestgreen");
					    $("#emailresult").html(
						    "사용가능한 이메일입니다.");
					    $("#emailchkVal").val("1");
					} else {
					    //alert(msg);
					    $("#emailresult").css("color",
						    "red");
					    $("#emailresult").html(
						    "사용 불가능한 이메일입니다.");
					    $("#emailchkVal").val("0");
					}
				    },
				    error : function() {
					alert("실패");
					alert(email);
				    }
				});
			    }
			});//이메일유효성 끝

	$("#pw").on("propertychange change keyup paste input",function(){		
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
		
		passOKCheck();
	});

	$("#passOK").keyup(passOKCheck);
	
	function passOKCheck(){
		var passOK = $("#passOK").val();
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
	}

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
                        <h1 class="h4 text-gray-900 mb-4">Create an Account!</h1>
                     </div>
                     <input type="hidden" value="0" id="emailchkVal">
                     <input type="hidden" value="0" id="pwchkVal">
                     <input type="hidden" value="0" id="passchkVal">
                     <input type="hidden" value="0" id="nicknamechkVal">
                     <form class="user" action="./signUp.do" method="post" onsubmit="return regicheck()">
                        <div class="form-group">
                           <input type="email" name="user_email" class="form-control form-control-user" id="email" placeholder="Email Address" required="required">
                           &nbsp;<span id="emailresult"></span>
                        </div>
                        <div class="form-group">
                           <input type="password" name="user_password" class="form-control form-control-user" id="pw" placeholder="Password" required="required" maxlength="10">
                           &nbsp;<span id="pwresult" class="form-text">4~10자리의 영문+숫자</span>
                        </div>
                        <div class="form-group">
                           <input type="password" class="form-control form-control-user" id="passOK" placeholder="Repeat Password" maxlength="10" required="required">
                           &nbsp;<span id="pwchk"></span>
                        </div>
                        <div class="form-group">
                           <input type="text" name="user_nickname" class="form-control form-control-user" id="nickname" placeholder="Nick Name" maxlength="10" required="required">
                           &nbsp;<span id="nicknameresult" class=" form-text">2~10자리의 닉네임을 입력</span>
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
