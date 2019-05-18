<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="./js/jquery-3.3.1.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="./css/lp-style.css">

<script src="./js/vendor/modernizr-2.6.2.min.js"></script>
<script src="./js/min/plugins.min.js"></script>
<script src="./js/min/main.min.js"></script>

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
               <li><a href="./loginPage.do">로그인 </a></li>
               <li><a href="./logout.do">로그아웃</a></li>
               <li><a href="#">여행일정 작성</a></li>
               <li><a href="./mypage.do">마이페이지</a></li>
               <li><a href="#">관리자 페이지</a></li>
            </ul>
         </div>
         
         <form action=""></form>
         <!-- .main-navigation 여기까지 네비게이션 메뉴 -->

         <!-- 채팅 -->
         <div class="chatting">
            <iframe class="panel" id="lot" frameborder="0"></iframe>
         </div>
         <!-- 채팅 -->
      </div>
      <!-- .sidebar-menu 여기까지 사이드 바 -->
      <div class="content-wrapper">
         <!-- 메인 컨텐츠   -->
         <div class="lpcontents">
            <div class="content">
               <a href="./test.do">테스트 페이지로 이동</a>
               <br>
               <a href="./kim.do">김태우 페이지로 이동</a>
               <br>
               <a href="./na.do">나원서 페이지로 이동</a>
               <br>
               <a href="./lee.do">이연지 페이지로 이동</a>
               <br>
               <a href="./jang.do">장석영 페이지로 이동</a>
               <br>
               <a href="./jung.do">정희태 페이지로 이동</a>
               <br>
               <a href="./cho.do">조태규 페이지로 이동</a>
               <br>
            </div>
         </div>
         <!-- </div> 여기까지 메인 컨텐츠  -->
         <div class="footer">landpeople</div>
      </div>
   </div>
</body>
</html>