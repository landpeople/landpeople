<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>index</title>

<script src="./js/jquery-3.3.1.js"></script>
<script src="./js/sketch/sketchbook.js"></script>
<link rel="stylesheet" href="./css/lp-style.css">
<link rel="stylesheet" href="./css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

</head>
<body>
	${ldto.user_email}
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

			<!-- 채팅 -->
			<div class="chatting">
				<!-- 	<iframe src="http://www.daum.net"></iframe> -->
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
				<!-- 	<a href="./test.do">테스트 페이지로 이동</a>
					<br>
					<a href="./kim.do">김태우 페이지로 이동</a>
					<br>
					<a href="./na.do">나원서 페이지로 이동</a>
					<br>
					<a href="./lee.do">이연지 페이지로 이동</a>
					<br>
					<a href="./jang.do">장석영 페이지로 이동</a>
					<br>
					<a href="./jeong.do">정희태 페이지로 이동</a>
					<br>
					<a href="./cho.do">조태규 페이지로 이동</a>
					<br> -->
					<!-- 스케치북 생성 Modal -->
					<div class="modal fade" id="sketchForm" role="dialog">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h4 class="modal-title">스케치북 작성</h4>
								</div>
								<div class="modal-body">
									<form action="#" role="form" method="post" id="makeSketchBook"></form>
								</div>
							</div>
						</div>
					</div>
					<!-- 여기까지 스케치북 생성 Modal -->
					
					<!-- 스케치북 테마별 조회  -->
					<div class="mainSketchTheme">
					
						<div class="halfMainSketchTheme">
							<div class="sketchTheme" style="margin-right: 10px;">
									<div class="sketchTheme_hover" onclick="sketchSelectTheme('나홀로')">
										<div class="hover_inside">
											<h5>나홀로</h5>
										</div>
									</div>
							
							</div>
							<div class="sketchTheme">
								<div class="sketchTheme_hover" onclick="sketchSelectTheme('가족여행')">
										<div class="hover_inside">
											<h5>가족여행</h5>
										</div>
									</div>
											
							</div>
						</div>	
						
						<div class="halfMainSketchTheme">
							<div class="sketchTheme" style="margin-right: 10px;">
									<div class="sketchTheme_hover" onclick="sketchSelectTheme('친구와함께')">
										<div class="hover_inside">
											<h5>친구와 함께</h5>
										</div>
									</div>
							</div>
							<div class="sketchTheme">
									<div class="sketchTheme_hover" onclick="sketchSelectTheme('연인과함께')">
										<div class="hover_inside">
											<h5>연인과 함께</h5>
										</div>
									</div>
							</div>
						 </div>
					
					</div><!-- 여기까지 스케치북 테마별 조회  -->	
					
						
				
				
				</div>
			</div>
			<!--  여기까지 메인 컨텐츠  -->
			
			
			<div class="footer">landpeople</div>
		</div>
	</div>
</body>

<script type="text/javascript">
function sketchSelectTheme(theme){
	alert(theme);
	var themeType= theme;
	
	location.href="./sketchBookTheme.do?type="+themeType;
}
</script>




</html>