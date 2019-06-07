<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<link href="./css/sketch/modal.css" rel="stylesheet">

</head>

<script src="./js/jquery-3.3.1.js"></script>

<script type="text/javascript">
    function modify() {
	// email 중복 + 유효값
	var pwchk = document.getElementById("pwchkVal").value;
	var passchk = document.getElementById("passchkVal").value;
	var nicknamechk = document.getElementById("nicknamechkVal").value;

	var pw = document.getElementById("pw").value;
	var passOK = document.getElementById("passOK").value;

	if (pwchk == "1" && passchk == "1" && pw == passOK) {
	    alert("회원 정보가 수정 되었습니다");
	    return true;
	} else if (nicknamechk == "1") {
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

	$("#pw").on("propertychange change keyup paste input", function() {
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

	function passOKCheck() {
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

    });
</script>
<style type="text/css">
span {
	font-size: 85%;
}

#haha2 {
	width: 50%;
	margin: auto;
}
</style>

<body id="page-top" class="scroll">

   <!-- Page Wrapper -->
   <div id="wrapper">
      <%@include file="../common/lp-sidebar.jsp"%>

      <!-- Content Wrapper -->
      <div id="content-wrapper" class="d-flex flex-column">
         <!-- flex 레이아웃 content와 푸터 정렬 -->

         <!-- Main Content -->
         <div id="content" style="display: flex; flex-direction: column;">

            <!-- LandPeople Content Area -->
            <div class="lp-container" >
               <div class="lp-other-content shadow-lg">
                  <div id="haha2" class="card border-light  mb-3" style="border: 1px #6CC3D5 solid !important">
                     <div class="card-body">
                        <div>
                           <input type="hidden" value="0" id="emailchkVal">
                           <input type="hidden" value="0" id="pwchkVal">
                           <input type="hidden" value="0" id="passchkVal">
                           <input type="hidden" value="0" id="nicknamechkVal">
                           <form action="./modifyMypage.do" method="post" onsubmit="return modify()">
                              <fieldset>
                                 <legend>회원정보 수정</legend>
                                 <div class="form-group">
                                    <label for="exampleInputEmail1">Email address</label>
                                    <input type="email" class="form-control" id="exampleInputEmail1" v name="user_email" aria-describedby="emailHelp" value="${ldto.user_email}" readonly="readonly">
                                    <small id="emailHelp" class="form-text">이메일은 수정하실수 없습니다. 헤헤</small>
                                 </div>
                                 <c:if test="${ldto.user_auth eq 'U'}">
                                    <div class="form-group">
                                       <label for="exampleInputPassword1">Password</label>
                                       <input type="password" class="form-control" name="user_password" id="pw" placeholder="Password" maxlength="10">
                                       <span id="pwresult" class="form-text">4~10자리의 영문+숫자</span>
                                    </div>
                                    <div class="form-group">
                                       <label for="exampleInputPassword1">Password</label>
                                       <input type="password" class="form-control" id="passOK" placeholder="Repeat Password" maxlength="10">
                                       &nbsp;<span id="pwchk"></span>
                                    </div>
                                 </c:if>
                                 <div class="form-group">
                                    <label for="exampleInputPassword1">NickName</label>
                                    <input type="text" class="form-control" name="user_nickname" id="nickname" placeholder="Nick Name" value="${ldto.user_nickname}" maxlength="10">
                                    &nbsp;<span id="nicknameresult">2~10자리의 닉네임을 입력</span>
                                 </div>
                                 <input type="submit" class="btn btn-primary" style="width: 100%" value="수정">
                              </fieldset>
                           </form>
                           <hr>
                           <div>
                              <form action="./delpage.do" method="get">
                                 <div class="form-group">
                                    <input style="width: 100%" type="submit" class="btn btn-danger" value="회원탈퇴">
                                 </div>
                              </form>
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
            <!--End of Page LandPeople Content Area -->
            <%@include file="../common/lp-footer.jsp"%>
            <!-- End of Page Wrapper -->
         </div>
      </div>
   </div>
</body>
</html>



