<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
            <iframe class="panel" id="lot" frameborder="0"></iframe>
         </div>
         <!-- 채팅 -->
      </div>
      <!-- .sidebar-menu 여기까지 사이드 바 -->

      <div class="content-wrapper">

         <!-- 메인 컨텐츠   -->
         <div class="lpcontents">
            <div class="content">
               <a href="#" id="test">체팅으로 가자mem=접속자1&gr=New01</a>
               <br>
               <a href="./socketOpen.do?mem=BBB&gr=New01">체팅으로 가자mem=BBB&gr=New01</a>
               <br>
               <a href="./socketOpen.do?mem=AAA&gr=New02">체팅으로 가자mem=AAA&gr=New02</a>
               <br>
               <a href="./socketOpen.do?mem=DDD&gr=New02">체팅으로 가자mem=DDD&gr=New02</a>
               <br>
            </div>
         </div>
         <!-- </div> 여기까지 메인 컨텐츠  -->


         <div class="footer">landpeople</div>
undefined

         <script type="text/javascript">
         
         	var test = document.getElementById("test");
         	alert(test);
         	test.addEventListener('click',function(){
         	   open("./socketOpen.do?mem=AAA&gr=New01");
         	})
		</script>
      </div>
   </div>
</body>
</html>