<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Bootstrap Navbar Menu Template</title>

<!-- CSS -->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Josefin+Sans:300,400|Roboto:300,400,500">
<link rel="stylesheet" href="assets/bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="assets/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" href="assets/font-awesome/css/font-jeju.css">
<link rel="stylesheet" href="assets/css/animate.css">
<link rel="stylesheet" href="assets/css/style.css">
<link rel="stylesheet" href="assets/css/template.css">

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
            <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
            <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->

<!-- Favicon and touch icons -->
<link rel="shortcut icon" href="assets/ico/favicon.png">
<link rel="apple-touch-icon-precomposed" sizes="144x144"
	href="assets/ico/apple-touch-icon-144-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="114x114"
	href="assets/ico/apple-touch-icon-114-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="72x72"
	href="assets/ico/apple-touch-icon-72-precomposed.png">
<link rel="apple-touch-icon-precomposed"
	href="assets/ico/apple-touch-icon-57-precomposed.png">

</head>

<body>

	<!-- Top menu -->
	<nav class="navbar navbar-fixed-top navbar-no-bg" role="navigation">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#top-navbar-1">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="index.html"></a>
			</div>
			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse" id="top-navbar-1">
				<ul class="nav navbar-nav navbar-right">
<!-- 					<li><a href="#">Home</a></li> -->
<!-- 					<li><a href="#">Features</a></li> -->
<!-- 					<li><a href="#">Video</a></li> -->
<!-- 					<li><a href="#">Clients</a></li> -->
<!-- 					<li><a href="#">Plans</a></li> -->
					<li><a href="#">Faq</a></li>
					<li><a class="btn btn-link-3" href="#">로그인</a></li>
				</ul>
			</div>
		</div>
	</nav>

	<!-- Top content -->
	<div class="top-content">
		<div class="container">
			<div class="row">
				<div class="col-sm-12 text wow fadeInLeft">
					<h1>혼저옵서양</h1>
					<div class="description">
						<p class="medium-paragraph">
							한글 폰트가 안 먹는다아아안ㄴ
						</p>
					</div>
				</div>
			</div>
		</div>
	</div>



<!-- 네비게이션 메뉴 -->
			<div class="main-navigation">
				<ul class="navigation">
                <li><a href='#' onclick='history.back(-1);'>뒤로가기 </a></li>
					<c:if test="${empty ldto}">
						<li><a href="./loginPage.do">로그인 </a></li>
					</c:if>	
					<c:if test="${not empty ldto}">
						<li><a href="./logout.do">로그아웃</a></li>
						<li><a href="#" onclick="sketchBookMake('${ldto.user_email}')">여행일정 작성</a></li>
						<li><a href="./mypage.do">마이페이지</a></li>
					</c:if>					
					<li><a href="./jang.do">관리자 페이지</a></li>
				</ul>
			</div>
<!-- .main-navigation 여기까지 네비게이션 메뉴 -->




	<!-- Features -->
	<div class="features-container section-container">
		<div class="container">

			<div class="row">
				<div class="col-sm-12 features section-description wow fadeIn">
					<h2>Bootstrap Navbar Menu</h2>
					<div class="divider-1">
						<div class="line"></div>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-sm-6 features-box wow fadeInLeft">
					<div class="row">
						<div class="col-sm-3 features-box-icon">
							<i class="fa fa-twitter"></i>
						</div>
						<div class="col-sm-9">
							<h3>Ut wisi enim ad minim</h3>
							<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit,
								sed do eiusmod tempor incididunt ut labore et. Ut wisi enim ad
								minim veniam, quis nostrud.</p>
						</div>
					</div>
				</div>
				<div class="col-sm-6 features-box wow fadeInLeft">
					<div class="row">
						<div class="col-sm-3 features-box-icon">
							<i class="fa fa-instagram"></i>
						</div>
						<div class="col-sm-9">
							<h3>Sed do eiusmod tempor</h3>
							<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit,
								sed do eiusmod tempor incididunt ut labore et. Ut wisi enim ad
								minim veniam, quis nostrud.</p>
						</div>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-sm-6 features-box wow fadeInLeft">
					<div class="row">
						<div class="col-sm-3 features-box-icon">
							<i class="fa fa-magic"></i>
						</div>
						<div class="col-sm-9">
							<h3>Quis nostrud exerci tat</h3>
							<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit,
								sed do eiusmod tempor incididunt ut labore et. Ut wisi enim ad
								minim veniam, quis nostrud.</p>
						</div>
					</div>
				</div>
				<div class="col-sm-6 features-box wow fadeInLeft">
					<div class="row">
						<div class="col-sm-3 features-box-icon">
							<i class="fa fa-cloud"></i>
						</div>
						<div class="col-sm-9">
							<h3>Minim veniam quis nostrud</h3>
							<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit,
								sed do eiusmod tempor incididunt ut labore et. Ut wisi enim ad
								minim veniam, quis nostrud.</p>
						</div>
					</div>
				</div>
			</div>

		</div>
	</div>

	<!-- Footer -->
	<footer>
		<div class="container">
			<div class="row">
				<div class="col-sm-12 footer-copyright">
					&copy; Bootstrap Navbar Template by <a href="http://azmind.com">AZMIND</a>
				</div>
			</div>
		</div>
	</footer>


	<!-- Javascript -->
	<script src="assets/js/jquery-1.11.1.min.js"></script>
	<script src="assets/bootstrap/js/bootstrap.min.js"></script>
	<script src="assets/js/jquery.backstretch.min.js"></script>
	<script src="assets/js/wow.min.js"></script>
	<script src="assets/js/retina-1.1.0.min.js"></script>
	<script src="assets/js/waypoints.min.js"></script>
	<script src="assets/js/scripts.js"></script>

	<!--[if lt IE 10]>
            <script src="assets/js/placeholder.js"></script>
        <![endif]-->

</body>

</html>