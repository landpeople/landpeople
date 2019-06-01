<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<link rel="stylesheet"
	href="assets/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" href="assets/font-awesome/css/font-jeju.css">
<link rel="stylesheet" href="assets/css/animate.css">
<link rel="stylesheet" href="assets/css/style.css">
<link rel="stylesheet" href="assets/css/template.css">

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
					<li><a class="btn btn-link-3" href="#">로그인</a></li>
				</ul>
			</div>
		</div>
	</nav>

	<!-- Top content -->
	<div class="top-content">
		<div class="container">
			<div class="row"></div>
		</div>
	</div>

	<style>
#yyyyjjj::-webkit-scrollbar-track {
	-webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
	border-radius: 10px;
	background-color: #F5F5F5;
}

#yyyyjjj::-webkit-scrollbar {
	width: 12px;
	background-color: #F5F5F5;
}

#yyyyjjj::-webkit-scrollbar-thumb {
	border-radius: 10px;
	-webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, .3);
	background-color: #D62929;
}
</style>
	<div class="container">
		<div class="row" style="height: 100%">
			<div class="col-sm-2 col-md-2 col-lg-2"
				style="background: yellow; height: 930px; box-sizing: border-box;">
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
				</div>
			</div>

			<div id="yyyyjjj" class="col-sm-9 col-md-9 col-lg-9 "
				style="background: pink; overflow-y: auto; height: 930px; width: 1000px">
				aaaaaaaaaa<br> aaaaaaaaaa<br> aaaaaaaaaa<br>
				aaaaaaaaaa<br> aaaaaaaaaa<br>
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
	<button id="xxxxx">xxxxxxx</button>

	<script>
		$("document").ready(
			function() {
				$("#xxxxx").click(
					function() {
						$("#yyyyjjj").append("<div style='height:50px;'>asdasdsadsadasdasdsadad</div>");
						});

							$("#xxxxx").scroll(function() {
								console.log('ss');
							});

							$("#yyyyjjj").scroll(
									function(event) {

										var hh = $("#yyyyjjj").height();
										var ee = $("#yyyyjjj").scrollTop();

										var scHeight = $('#yyyyjjj').prop(
												'scrollHeight');

										if (scHeight - hh - ee < 1) {
											$("#xxxxx").trigger("click");
										}
										console.log(hh + "----" + ee + "----"
												+ scHeight);

									});

						});
	</script>

	<!--[if lt IE 10]>
            <script src="assets/js/placeholder.js"></script>
        <![endif]-->

</body>

</html>