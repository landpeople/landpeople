<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<script type="text/javascript" charset="utf-8" src="./js/chat/timeoutchk.js"></script>
<script src="./js/sketchbook/sketchbook.js"></script>
<script src="./js/chat/chat.js"></script>

<link rel="stylesheet" href="./css/bootstrap.min.css">
<link rel="stylesheet" href="./css/lp-style.css">

<span id="timer"></span>
<a href="javascript:refreshTimer();">
   <img src="/images_std/kor/btn/btn_time_extension.gif" align="top">
</a>

<div class="header">

</div>
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
			<li><a href="#">마이페이지</a></li>
			</c:if>		
			<li><a href="./jang.do">관리자 페이지</a></li>
		</ul>
	</div>
	<!-- .main-navigation 여기까지 네비게이션 메뉴 -->

	<!-- 채팅 -->
	<div class="chatting">
		<iframe class="panel" id="lot" frameborder="0"></iframe>
	</div>
	<!-- 채팅 -->

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





</div>
<!-- .sidebar-menu 여기까지 사이드 바 -->




