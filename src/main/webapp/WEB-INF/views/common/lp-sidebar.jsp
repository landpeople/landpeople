<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Sidebar -->
<ul class="navbar-nav bg-gradient-lp-primary sidebar sidebar-dark accordion" id="accordionSidebar">

   <!-- Sidebar - Brand -->
   <a class="sidebar-brand d-flex align-items-center justify-content-center" href="index.html">
      <div class="sidebar-brand-icon rotate-n-15">
         <img class="lp-icon" src="./img/logo.png">
      </div>
      <div class="sidebar-brand-text mx-3">육지사람</div>
   </a>

   <!-- Divider -->
   <hr class="sidebar-divider my-0">


   <li class="nav-item active"><a class="nav-link" href="index.html">
         <i class="fas fa-th-large"></i> <span>All travel schedule</span>
      </a></li>

   <c:if test="${not empty ldto }">
      <!-- Divider -->
      <hr class="sidebar-divider">

      <div class="lp-nav-btn">
         <a href="#" onclick="sketchBookMake('${ldto.user_email}')" class="btn btn-lp-primary btn-icon-split lp-write-btn btn-sl btn-ss">
            <span class="text">Create Travel Sketchbook</span>
         </a>
      </div>
   </c:if>
   <!-- Divider -->
   <hr class="sidebar-divider my-0">

   <!-- Heading -->
   <!--          <div class="sidebar-heading">Menu:</div> -->

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
      <c:when test="${ldto.user_auth eq 'U'}">
         <!-- Nav Item - My page Menu -->
         <li class="nav-item"><a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseUtilities" aria-expanded="true" aria-controls="collapseUtilities">
               <i class="fas fa-user"></i> <span>My page</span>
            </a>
            <div id="collapseUtilities" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
               <div class="bg-white py-2 collapse-inner rounded">
                  <h6 class="collapse-header">Components</h6>
                  <a class="collapse-item" href="./mypage.do">My information</a>
                  <a class="collapse-item" href="utilities-animation.html">My sketchbook</a>
                  <a class="collapse-item" href="utilities-animation.html">My chatroom</a>
               </div>
            </div></li>
         <!-- Nav Item - Utilities Collapse Menu -->
      </c:when>
   </c:choose>

   <!-- Divider -->
   <hr class="sidebar-divider">

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
      <nav class="navbar navbar-expand navbar-light bg-header topbar mb-4 static-top shadow">

         <!-- 			Sidebar Toggle (Topbar) -->
         <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
            <i class="fa fa-bars"></i>
         </button>

         <form class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
            <div class="input-group">
               <div class="bg-light border-0 text-lg text-blue" id="lp-header-title"></div>
            </div>
         </form>


         <!-- Topbar Navbar -->
         <ul class="navbar-nav ml-auto">
            <c:if test="${not empty ldto}">
               <!-- Nav Item - Search Dropdown (Visible Only XS) -->
               <li class="nav-item dropdown no-arrow d-sm-none"><a class="nav-link dropdown-toggle" href="#" id="searchDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                     <i class="fas fa-search fa-fw"></i>
                  </a> <!-- Dropdown - Messages -->
                  <div class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in" aria-labelledby="searchDropdown">
                     <form class="form-inline mr-auto w-100 navbar-search">
                        <div class="input-group">
                           <input type="text" class="form-control bg-light border-0 small" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2">
                           <div class="input-group-append">
                              <button class="btn btn-primary" type="button">
                                 <i class="fas fa-search fa-sm"></i>
                              </button>
                           </div>
                        </div>
                     </form>
                  </div></li>

               <!-- Nav Item - Alerts -->
               <li class="nav-item dropdown no-arrow mx-1"><a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                     <i class="fas fa-bell fa-fw"></i>
                     <!-- Counter - Alerts -->
                     <span class="badge badge-danger badge-counter">3+</span>
                  </a> <!-- Dropdown - Alerts -->
                  <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="alertsDropdown">
                     <h6 class="dropdown-header">Alerts Center</h6>
                     <a class="dropdown-item d-flex align-items-center" href="#">
                        <div class="mr-3">
                           <div class="icon-circle bg-primary">
                              <i class="fas fa-file-alt text-white"></i>
                           </div>
                        </div>
                        <div>
                           <div class="small text-gray-500">December 12, 2019</div>
                           <span class="font-weight-bold">A new monthly report is ready to download!</span>
                        </div>
                     </a>
                     <a class="dropdown-item d-flex align-items-center" href="#">
                        <div class="mr-3">
                           <div class="icon-circle bg-success">
                              <i class="fas fa-donate text-white"></i>
                           </div>
                        </div>
                        <div>
                           <div class="small text-gray-500">December 7, 2019</div>
                           $290.29 has been deposited into your account!
                        </div>
                     </a>
                     <a class="dropdown-item d-flex align-items-center" href="#">
                        <div class="mr-3">
                           <div class="icon-circle bg-warning">
                              <i class="fas fa-exclamation-triangle text-white"></i>
                           </div>
                        </div>
                        <div>
                           <div class="small text-gray-500">December 2, 2019</div>
                           Spending Alert: We've noticed unusually high spending for your account.
                        </div>
                     </a>
                     <a class="dropdown-item text-center small text-gray-500" href="#">Show All Alerts</a>
                  </div></li>
               <div class="topbar-divider d-none d-sm-block"></div>

               <li class="nav-item"><a class="nav-link">
                     <!-- Nav Item - User Information -->
                     <!--                   <li class="nav-item dropdown no-arrow"><a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> -->
                     <span class="mr-2 d-none d-lg-inline text-gray-600 small">${ldto.user_nickname}</span>
                  </a></li>

               <!-- Dropdown - User Information -->
               <!--                      <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown"> -->
               <!--                         <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal"><i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>Logout -->
               <!--                         </a> -->
               <!--                      </div></li> -->
            </c:if>
         </ul>

         <c:if test="${empty ldto}">
            <a href="./loginPage.do" class="d-none d-sm-inline-block btn btn-sm btn-lp-success shadow-sm">
               <i class="fas fa-sign-in-alt fa-sm fa-fw mr-2"></i>Login
            </a>
         </c:if>
         <c:if test="${not empty ldto}">
            <a href="#" class="d-none d-sm-inline-block btn btn-sm btn-lp-success shadow-sm" data-toggle="modal" data-target="#logoutModal">
               <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2"></i>Logout
            </a>
         </c:if>
      </nav>
      <!-- End of Topbar -->