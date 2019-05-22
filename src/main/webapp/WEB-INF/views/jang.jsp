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
			
			<!-- 메인 컨텐츠   -->
			<div class="lpcontents">
				<div class="content">
				<a href="./jqgrid.do">회원 목록 조회</a><br>
				<a href="./jqgrid2.do">스케치북 목록 조회</a><br>
				<a href="./push.do">푸쉬 서버</a>
				<a href="./scheduler.do">스케줄러</a>
				</div>
			</div>
			<!-- </div> 여기까지 메인 컨텐츠  -->
			<div class="footer">landpeople</div>
		</div>
	</div>
</body>
</html>