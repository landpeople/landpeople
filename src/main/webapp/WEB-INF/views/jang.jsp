<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장석영 화면 테스트</title>

<script src="./js/jquery-3.3.1.js"></script>

</head>
<body>
	<!--젤로 레이아웃- 전체 영역 감싸는 div-->
	<div class="main-wrapper">
		<%@include file="./common/Sidebar.jsp"%>
		<div class="content-wrapper">

	<!-- main에 있는 header 영역임 main 페이지 말고는 사용을 안하지만, 그냥 주석함. 지워도 됨-->
	<div class="banner-bg" id="top">
		<div class="banner-overlay"></div>
			<div class="welcome-text">
				<h2>LandPeople</h2>
	           <h5>This is a mobile friendly layout with Bootstrap v3.3.1 framework. Maecenas eu ante at nunc posuere fringilla sit amet non dolor. Proin condimentum fermentum nunc.</h5>
	       </div>
	      
	   </div>
	    <div class="main-content">
			<div class = "fluid-container">
	 			<a href="./jqgrid.do">회원 목록 조회</a><br>
				<a href="./jqgrid2.do">스케치북 목록 조회</a><br>
				<a href="./push.do">푸쉬 서버</a>
			</div>
			<!-- </div> 여기까지 메인 컨텐츠  -->
			<div class="footer">landpeople</div>
		</div>
	</div>
</body>
</html>