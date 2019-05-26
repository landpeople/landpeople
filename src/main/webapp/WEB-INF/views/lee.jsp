<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>

<script src="./js/jquery-3.3.1.js"></script>

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
					<div class='receiveTxt'>
						<div class = 'receiver_img' style="background-image: url('./chatThumbnail/S_bba59949-2016-4385-9126-f0aeaa340ebb.png'); height:50px;")>[file]/chatThumbnail/S_bba59949-2016-4385-9126-f0aeaa340ebb.png</div></div><br><br>
				</div>
			</div>
			<!-- </div> 여기까지 메인 컨텐츠  -->
			<div class="footer">landpeople</div>
		</div>
	</div>
</body>
</html>