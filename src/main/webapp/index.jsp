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
<body id="page-top" class="scroll">

   <!-- Page Wrapper -->
   <div id="wrapper">
      <!-- Sidebar -->
      <ul class="navbar-nav bg-gradient-lp-primary sidebar sidebar-dark accordion" id="accordionSidebar">

         <!-- Sidebar - Brand -->
         <a class="sidebar-brand d-flex align-items-center justify-content-center" href="index.html">
            <div class="sidebar-brand-icon rotate-n-15">
               <img class="lp-icon" src="./img/logo.png">
            </div>
            <div class="sidebar-brand-text mx-3">육지사람</div>
         </a>

         <c:if test="${not empty ldto}">
            <a href="#" class="d-none d-sm-inline-block btn btn-sm btn-lp-success shadow-sm" data-toggle="modal" data-target="#logoutModal">
               <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2"></i>Logout
            </a>
         </c:if>

         <c:if test="${empty ldto}">
            <a href="./loginPage.do" class="d-none d-sm-inline-block btn btn-sm btn-lp-success shadow-sm">
               <i class="fas fa-sign-in-alt fa-sm fa-fw mr-2"></i>Login
            </a>
         </c:if>

         <li class="nav-item active"><a class="nav-link" href="index.html">
               <i class="fas fa-th-large"></i> <span>All travel schedule</span>
            </a></li>

         <!-- Divider -->
         <hr class="sidebar-divider my-0">

         <c:choose>
            <c:when test="${ldto.user_auth eq 'M'}">
               <!-- Nav Item - Admin Page Menu -->
               <li class="nav-item"><a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo">
                     <i class="fas fa-fw fa-cog"></i> <span>Admin Page</span>
                  </a>
                  <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
                     <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">Components</h6>
                        <a class="collapse-item" href="buttons.html">Members list</a>
                        <a class="collapse-item" href="cards.html">Member sketchbook list</a>
                        <a class="collapse-item" href="utilities-animation.html">Admin chatRoom</a>
                     </div>
                  </div></li>
            </c:when>
            <c:when test="${ldto.user_auth eq 'U' or ldto.user_auth eq 'G' or ldto.user_auth eq 'N'}">
               <!-- Nav Item - My page Menu -->
               <li class="nav-item"><a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseUtilities" aria-expanded="true" aria-controls="collapseUtilities">
                     <i class="fas fa-user"></i> <span>${ldto.user_nickname}</span>
                  </a>
                  <div id="collapseUtilities" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
                     <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">Components</h6>
                        <a class="collapse-item" href="./mypage.do">My information</a>
                        <a class="collapse-item" href="#" onclick="sketchSelectMine()">My sketchbook</a>
                        <a class="collapse-item" href="#" onclick="goScrapMine()">My scrapbook</a>
                        <input type="hidden" id="user_email" value="${ldto.user_email}">
                        <a class="collapse-item" href="utilities-animation.html">My chatroom</a>
                     </div>
                  </div></li>
               <!-- Nav Item - Utilities Collapse Menu -->
            </c:when>
         </c:choose>

         <!-- Divider -->
         <hr class="sidebar-divider">

         <c:if test="${not empty ldto }">
            <div class="lp-nav-btn">
               <a href="#" onclick="sketchBookMake('${ldto.user_email}')" class="btn btn-lp-primary btn-icon-split lp-write-btn btn-sl btn-ss">
                  <span class="text">Create Travel Sketchbook</span>
               </a>
            </div>
         </c:if>



         <!-- 채팅방 iframe -->
         <div class="nav-chat rounded bg-white pt-2 pb-2 py-2">
            <div class="chatting">
               <iframe class="panel lp-chatlist" id="lot" frameborder="0"></iframe>
               <!--                      <a class="collapse-item" href="#">Chatroom list</a> -->
            </div>
         </div>

         <!-- Sidebar Toggler (Sidebar) -->
         <div class="text-center d-none d-md-inline">
            <button class="rounded-circle border-0" id="sidebarToggle"></button>
         </div>
      </ul>
      <!-- End of Sidebar -->

      <!-- Content Wrapper -->
      <div id="content-wrapper" class="d-flex flex-column">
         <!-- flex 레이아웃 content와 푸터 정렬 -->

         <!-- Main Content -->
         <div id="content" style="display: flex; flex-direction: column;">

            <!-- Topbar -->
            <nav class="navbar navbar-expand navbar-light topbar static-top shadow"></nav>
            <!-- End of Topbar -->

            <!-- LandPeople Content Area -->
            <div class="lp-container">

               <div class="lp-index-content shadow-lg">
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
         </div>
         <!-- End of Page Wrapper -->
         <!--End of Page LandPeople Content Area -->


         <!-- Footer -->
         <footer class="sticky-footer bg-white">
            <div class="container my-auto">
               <div class="copyright text-center my-auto">
                  <span>Copyright &copy; LandPeople 2019</span>
               </div>
            </div>
         </footer>
         <!-- End of Footer -->

         <!-- Scroll to Top Button-->
         <a class="scroll-to-top rounded" href="#page-top">
            <i class="fas fa-angle-up"></i>
         </a>

         <!-- Logout Modal-->
         <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
               <div class="modal-content">
                  <div class="modal-header">
                     <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
                     <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                     </button>
                  </div>
                  <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
                  <div class="modal-footer">
                     <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                     <a class="btn btn-primary" href="./logout.do">Logout</a>
                  </div>
               </div>
            </div>
         </div>

         <!-- 스케치북 생성 Modal -->
         <div class="modal fade" id="sketchForm" role="dialog">
            <div class="modal-dialog">
               <div class="modal-content">
                  <div class="modal-header">
                     <h5 class="modal-title">스케치북 작성</h5>
                     <button type="button" class="close" data-dismiss="modal">&times;</button>
                  </div>
                  <div class="modal-body">
                     <form action="#" role="form" method="post" id="makeSketchBody"></form>
                  </div>
                  <div class="modal-footer">
                     <form action="#" role="form" method="post" id="makeSketchFooter"></form>
                  </div>
               </div>
            </div>
         </div>
         <!-- 여기까지 스케치북 생성 Modal -->

         <!-- Bootstrap core JavaScript-->
         <script src="./js/theme/jquery.min.js"></script>
         <script src="./js/theme/bootstrap.bundle.min.js"></script>

         <!-- Core plugin JavaScript-->
         <script src="./js/theme/jquery.easing.min.js"></script>

         <!-- Custom scripts for all pages-->
         <script src="./js/theme/sb-admin-2.js"></script>
         <script src="./js/chat/chat.js"></script>
         <script src="./js/sketch/sketch.js"></script>
         <script src="./js/sketch/sketchbook.js"></script>

         <script type="text/javascript">
					var pathname = window.location.pathname;

					// 	alert(window.location.pathname );
					if (pathname == '/LandPeople/lee.do') {
					    var title = 'All themes';
					    $('#lp-header-title').text(title);
					}
				    </script>
</body>
</html>



