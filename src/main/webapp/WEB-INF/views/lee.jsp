<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>

<script src="./js/jquery-3.3.1.js"></script>
<script src="./js/chat/chat.js"></script>
<link rel="stylesheet" href="./css/lp-style.css">
<!--   <link rel="stylesheet" href="./css/bootstrap.min.css"> -->

</head>
<body>
	메인페이지 : ${ldto}
	<!--젤로 레이아웃- 전체 영역 감싸는 div-->
	<div class="main-wrapper">
		<%@include file="./common/Sidebar.jsp"%>
		<div class="content-wrapper">
			
			<!-- 메인 컨텐츠   -->
			<div class="lpcontents">
				<div class="content">
					<a href="#" id="test">체팅으로 가자mem=접속자1&gr=New01</a> <br> <a
						href="./socketOpen.do?mem=BBB&gr=New01">체팅으로
						가자mem=BBB&gr=New01</a> <br> <a
						href="./socketOpen.do?mem=AAA&gr=New02">체팅으로
						가자mem=AAA&gr=New02</a> <br> <a
						href="./socketOpen.do?mem=DDD&gr=New02">체팅으로
						가자mem=DDD&gr=New02</a> <br>
				</div>
			</div>
			<!-- </div> 여기까지 메인 컨텐츠  -->
			<div class="footer">landpeople</div>
		</div>
	</div>
</body>
</html>