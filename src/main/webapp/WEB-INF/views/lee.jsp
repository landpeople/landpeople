<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>

<script src="./js/jquery-3.3.1.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

<script type="text/javascript">
    var m = document.querySelector("main");
    var h = document.querySelector("header")
    var hHeight;

    function setTopPadding() {
	hHeight = h.offsetHeight;
	m.style.paddingTop = hHeight + "px";
    }

    function onScroll() {
	window.addEventListener("scroll", callbackFunc);
	function callbackFunc() {
	    var y = window.pageYOffset;
	    if (y > 150) {
		h.classList.add("scroll");
	    } else {
		h.classList.remove("scroll");
	    }
	}
    }
</script>

<style type="text/css">
html, body {
	width: 100%;
	height: 100%;
	margin: 0px;
}

/*가로 가운데 정렬 및 전체 레이아웃을 잡기 위한 div*/
.main-wrapper {
	position: relative;
	top: 0px;
	width: 1276px;
	height: 930px;
}

.sidebar-menu { /*사이드바 레이아웃 div*/
	box-shadow: 12px 12px 11px #aaaaaa;
	position: absolute;
	background-color: #f4f4f4;
	color: black;
	width: 276px;
	height: 930px;
	padding: 20px;
	box-sizing: border-box;
}
/* 사이드바 이미지 영역 div 스타일 */
.top-section {
	margin-top: 100px;
	height: 236px;
	width: 236px;
	padding: 28px;
	box-sizing: border-box;
}
/* 사이드바 이미지 스타일 */
.profile-image {
	height: 180px;
	width: 180px;
	background: url("./img/제주배경임.png");
	background-repeat: no-repeat;
	background-position: center;
	background-size: cover;
	-webkit-border-radius: 125px;
	border-radius: 125px;
	background-position: center;
	background-size: cover;
}

.menu-navigation {
	padding-top: 20px;
	padding-left: 28px;
	padding-right: 28px;
}

.navigation>li {
	margin-bottom: 20px;
	list-style: none;
}

.main-navigation li a {
	color: black;
	text-decoration: none;
}

.chatting {
	margin-top: 70px;
	background-color: white;
	width: 236px;
	height: 131px;
}

/*header*/
.content-wrapper {
	position: relative;
	left: 276px;
	width: 1000px;
}
/*헤더 그림 스타일  */
.banner-bg {
	background: url("./img/돌담.jpg");
	background-repeat: no-repeat;
	background-position: center;
	background-size: cover;
	width: 100%;
	height: 400px;
}

.main-lpcontents {
	background-color: white;
	box-sizing: border-box;
	padding: 20px;
	width: 1000px;
	height: 650px;
}

.lpcontents {
	background-color: white;
	box-sizing: border-box;
	padding: 20px;
	width: 1000px;
	height: 880px;
}
/* 콘텐츠 영역 스타일 */
.content {
	background-color: pink;
	height: 100%;
}
/* iframe 스타일 */
iframe {
	frameborder: 0;
	width: 100%;
	height: 100%;
	marginwidth: 0px;
	marginheight: 0px;
	scrolling: yes;
}
/* 모달 스타일 */
.modal-input {
	/* float: right; */
	
}

.modal-content {
	color: black;
}

#moSketchBookCover {
	width: 300px;
	height: 100px;
}

#modalIMG1 {
	border: 1px solid black;
	width: 200px;
	height: 100px;
	/* float: left; */
	margin: 0px 20px 30px 20px;
	background-size: contain;
	background-repeat: no-repeat;
	background-position: center;
}

/* 라디오버튼 숨기기 */
.themeradio input[type=radio] {
	display: none;
	margin: 10px;
}
/* 라디오버튼 직사각형 버튼 모양 만들기 */
.themeradio input[type=radio]+label {
	display: inline-block;
	margin: -2px;
	padding: 8px 19px;
	background-color: #f5f5f5;
	border: 1px solid #ccc;
	font-size: 13px !important;
	width: 80px;
	text-align: center;
}
/* 선택한 라디오버튼 배경색 변경 */
.themeradio>input[type=radio]:checked+label {
	background-image: none;
	background-color: #3598dc;
	color: #fff;
}

/*푸터 스타일  */
.footer {
	box-sizing: border-box;
	background-color: black;
	width: 1000px;
	height: 50px;
	padding: 10px 20px;
	text-align: center;
	color: white;
}

/* 헤더 스타일 */
.header {
	background-color: black;
	height: 55px;
	width: 100%;
	position: fixed;
	top: 0;
}
</style>
</head>
<body>
   <nav class="navbar navbar-default navbar-fixed-top">
      <div class="container-fluid">
         <div class="navbar-header">
            <a class="navbar-brand" href="#">
               <img alt="Brand" src="...">
            </a>
            <ul class="nav navbar-nav navbar-right">
               <li><a href="#">마이페이지</a></li>
               <li><a href="#">관리자페이지</a></li>
               <li><a href="#">여행일정작성</a></li>
               <li><a href="#">채팅</a></li>
               <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
                     Dropdown <span class="caret"></span>
                  </a>
                  <ul class="dropdown-menu" role="menu">
                     <li><a href="#">Action</a></li>
                     <li><a href="#">Another action</a></li>
                     <li><a href="#">Something else here</a></li>
                     <li class="divider"></li>
                     <li><a href="#">Separated link</a></li>
                  </ul></li>
            </ul>
         </div>
      </div>
   </nav>
   <!-- 헤더 그림 -->
   <div class="banner-bg" id="top">
      <div class="banner-overlay"></div>
      <div class="welcome-text"></div>
   </div>
   <!--젤로 레이아웃- 전체 영역 감싸는 div-->
   <div class="main-wrapper">
      <!-- SIDEBAR -->
      <div class="sidebar-menu">
         <div class="top-section">
            <!-- 프로필 사진 영역 전체 감싸는  div -->
            <div class="profile-image"></div>
         </div>
         <!-- 여기까지 프로필 사진 영역 전체 감싸는 div -->

         <!-- 네비게이션 메뉴 -->
         <div class="main-navigation">
            <ul class="navigation">

               <!--Facebook-->

               <li><a href='#' onclick='history.back(-1);'>뒤로가기 </a></li>
               <li><a href="./loginPage.do">로그인 </a></li>
               <li><a href="./logout.do">로그아웃</a></li>
               <li><a href="#" onclick="sketchBookMake()">여행일정 작성</a></li>
               <li><a href="#">마이페이지</a></li>
               <li><a href="./jang.do">관리자 페이지</a></li>
            </ul>
         </div>
         <!-- .main-navigation 여기까지 네비게이션 메뉴 -->

         <!-- 채팅 -->
         <div class="chatting">
            <iframe class="panel" id="lot" frameborder="0"></iframe>
         </div>
         <!-- 채팅 -->
      </div>
      <!-- .sidebar-menu 여기까지 사이드 바 -->

      <div class="content-wrapper">
         <div class="lpcontents">
            <div class="content">

               <button type="button" class="btn btn-lg btn-so">
                  <i class="fab fa-stack-overflow pr-1"></i> <span>Stack Overflow</span>
               </button>
               <span class="counter counter-lg">22</span> <i class="fa fa-camera-retro"></i> fa-camera-retro

            </div>
         </div>
         <!-- </div> 여기까지 메인 컨텐츠  -->
         <div class="footer">landpeople</div>
      </div>
   </div>
</body>
</html>