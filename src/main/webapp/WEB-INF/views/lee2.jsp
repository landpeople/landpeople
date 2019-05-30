<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>

<script src="./js/jquery-3.3.1.js"></script>
<script src="./js/chat/chat.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="./css/theme/lp-main.css" rel="stylesheet">
<style type="text/css">
</style>
</head>
<body>
	<nav class="navbar navbar-default navbar-fixed-top">
		<div style="width: 1270px; margin: auto">
			<div class="container-fluid">
			
				<a  style="height:100px" class="navbar-brand" href="#"> <img style="height:100%;" alt="Brand" src="./img/logo.png"></a>
				<ul class="nav navbar-nav navbar-right">
					<li><a href="#">로그인</a></li>
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

	<div style="width: 100%;">
		<div class="lpcontainer">
			<!-- material-kit.css -->
			<div style="">
				<div class="row profile">
					<div class="col-md-3">
						<div class="profile-sidebar">
							<!-- SIDEBAR USER TITLE -->
							<div class="profile-usertitle">
								<div class="profile-usertitle-name">User Nickname</div>
								<div class="profile-usertitle-job">User Email</div>
							</div>
							<!-- END SIDEBAR USER TITLE -->
							<!-- SIDEBAR BUTTONS -->
							<div class="profile-userbuttons">
								<button type="button" class="btn btn-success btn-sm">여행
									일정 작성하기</button>
							</div>
							<!-- END SIDEBAR BUTTONS -->
							<!-- SIDEBAR MENU -->
							<div class="profile-usermenu">
								F SS
								<ul class="nav">
									<li class="active"><a href="#"> <i
											class="glyphicon glyphicon-home"></i> Overview
									</a></li>
									<li><a href="#"> <i class="glyphicon glyphicon-user"></i>
											Account Settings
									</a></li>
									<li><a href="#" target="_blank"> <i
											class="glyphicon glyphicon-ok"></i> Tasks
									</a></li>
									<li><a href="#"> <i class="glyphicon glyphicon-flag"></i>
											Help
									</a></li>
								</ul>
							</div>
							<!-- END MENU -->

							<div class="chatting">
								<iframe class="panel" id="lot" frameborder="0"></iframe>
							</div>
						</div>
					</div>
					<div class="main-lpcontent">
						<div class="col-md-3">이거슨?</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>