<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>

<script src="./js/jquery-3.3.1.js"></script>
<link rel="stylesheet" href="./css/lp-style.css">
 <!--   <link rel="stylesheet" href="./css/bootstrap.min.css"> -->

</head>
<body>
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
					<li><a href="#">로그인/로그아웃</a></li>
					<li><a href="#">여행일정 작성</a></li>
					<li><a href="#">마이페이지/관리자 페이지</a></li>
				</ul>
			</div>
			<!-- .main-navigation 여기까지 네비게이션 메뉴 -->

			<!-- 채팅 -->
			<div class="chatting">
				<iframe src="http://www.daum.net"></iframe>
			</div>
			<!-- 채팅 -->
		</div>
		<!-- .sidebar-menu 여기까지 사이드 바 -->

		<div class="content-wrapper">
			<!-- 헤더 그림 -->
			<div class="banner-bg" id="top">
				<div class="banner-overlay"></div>
				<div class="welcome-text"></div>
			</div>
			<!-- 메인 컨텐츠   -->
			<div class="main-lpcontents">
				<div class="content">
					<!-- <div class="page-section" id="projects"> -->
					<a href="./test.do">테스트 페이지로 이동</a><br> <a href="./kim.do">김태우
						페이지로 이동</a><br> <a href="./na.do">나원서 페이지로 이동</a><br> <a
						href="./lee.do">이연지 페이지로 이동</a><br> <a href="./jang.do">장석영
						페이지로 이동</a><br> <a href="./jung.do">정희태 페이지로 이동</a> 
				</div>
			</div>
			<!-- </div> 여기까지 메인 컨텐츠  -->


			<div class="footer">landpeople</div>
		</div>
	</div>
</body>
</html>