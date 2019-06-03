<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
<link rel="shortcut icon" href="./img/favicon.ico" type="image/x-icon">
<link rel="icon" href="./css/theme/sb-admin-2.css" type="image/x-icon">

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="LandPeople">

<title>제주도 여행 일정 공유 커뮤니티 | 육지사람</title>

<!-- Custom fonts for this template-->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

<link rel="stylesheet" type="text/css" href="./css/sweetalert.css">

<!-- Custom styles for this template-->
<link href="./css/theme/sb-admin-2.css" rel="stylesheet">
<link href="./css/theme/lp-template.css" rel="stylesheet">
<link href="./css/sketch/modal.css" rel="stylesheet">

</head>
<body id="page-top">

   <!-- Page Wrapper -->
   <div id="wrapper">
      <%@include file="./common/lp-sidebar.jsp"%>

      <!-- LandPeople Content Area -->
      <div class="lp-container">

         <div class="lp-content shadow-lg">
            <div class="lp-grid-container">

               <article id="" class="location-listing">
                  <a class="location-title" href="#" onclick="sketchSelectTheme('나홀로')">나홀로 여행</a>
                  <div class="location-image">
                     <img class="lp-theme" src="./img/theme/alone.jpg" alt="With me">
                  </div>
               </article>

               <article id="" class="location-listing">
                  <a class="location-title" href="#" onclick="sketchSelectTheme('가족여행')">가족과 함께</a>
                  <div class="location-image">
                     <img class="lp-theme" src="./img/theme/family.jpg" alt="With family">
                  </div>
               </article>

               <article id="" class="location-listing">
                  <a class="location-title" href="#" onclick="sketchSelectTheme('연인과함께')">연인과 함께</a>
                  <div class="location-image">
                     <img class="lp-theme" src="./img/theme/couple.png" alt="With love">
                  </div>
               </article>

               <article id="" class="location-listing">
                  <a class="location-title" href="#" onclick="sketchSelectTheme('친구와함께')">친구와 함께</a>
                  <div class="location-image">
                     <img class="lp-theme" src="./img/theme/friend.png" alt="With friend">
                  </div>
               </article>
            </div>
         </div>
      </div>
      <!--End of Page LandPeople Content Area -->

      <%@include file="./common/lp-footer.jsp"%>
   </div>
   <!-- End of Page Wrapper -->

</body>
</html>



