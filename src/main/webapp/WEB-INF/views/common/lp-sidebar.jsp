<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Sidebar -->
<ul class="navbar-nav bg-gradient-lp-primary sidebar sidebar-dark accordion" id="accordionSidebar">

   <!-- Sidebar - Brand -->
   <a class="sidebar-brand d-flex align-items-center justify-content-center" href="index.jsp">
      <div class="sidebar-brand-icon rotate-n-15">
         <img class="lp-icon" src="./img/logo.png">
      </div>
      <div class="sidebar-brand-text mx-3">육지사람</div>
   </a>

   <c:if test="${not empty ldto}">
      <div class="lp-nav-btn">
       <a href="#" class="d-none d-sm-inline-block btn btn-sm btn-lp-success shadow-sm lp-write-btn" data-toggle="modal" data-target="#logoutModal">
          <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2"></i>Logout
       </a>
      </div>
   </c:if>
   	
   <c:if test="${empty ldto}">
      <div class="lp-nav-btn">
       <a href="./loginPage.do" class="d-none d-sm-inline-block btn btn-sm btn-lp-success shadow-sm lp-write-btn">
          <i class="fas fa-sign-in-alt fa-sm fa-fw mr-2"></i>Login
       </a>
   </div>
   </c:if>

<!--    <li class="nav-item active"><a class="nav-link" href="./sketchBookTheme.do"> -->
<!--          <i class="fas fa-th-large"></i> <span>All travel schedule</span> -->
<!--       </a></li> -->


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
                  <a class="collapse-item" href="./memberList.do">Members list</a>
                  <a class="collapse-item" href="./memberSketchList.do">Member sketchbook list</a>
                  <a class="collapse-item" href="./myChatroom.do">Admin chatroom</a>
               </div>
            </div></li>
      </c:when>
       <c:when test="${ldto.user_auth eq 'U' or ldto.user_auth eq 'G' or ldto.user_auth eq 'N'}">
         <!-- Nav Item - My page Menu -->
         <li class="nav-item"><a class="nav-link collapsed lp-write-btn" href="#" data-toggle="collapse" data-target="#collapseUtilities" aria-expanded="true" aria-controls="collapseUtilities">
               <i class="fas fa-user"></i> <span>${ldto.user_nickname}</span>
            </a>
            <div id="collapseUtilities" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
               <div class="bg-white py-2 collapse-inner rounded">
                  <h6 class="collapse-header">Components</h6>
                  <a class="collapse-item" href="./mypage.do">My information</a>
                  <a class="collapse-item" href="#" onclick="sketchSelectMine()">My sketchbook</a>
                  <a class="collapse-item" href="#" onclick="goScrapMine()">My scrapbook</a>
                  <input type="hidden" id="user_email" value="${ldto.user_email}">
                  <a class="collapse-item" href="./myChatroom.do">My chatroom</a>
               </div>
            </div></li>
         <!-- Nav Item - Utilities Collapse Menu -->
      </c:when>
   </c:choose>

   <!-- Divider -->
   <hr class="sidebar-divider">

   <c:if test="${not empty ldto }">
      <div class="lp-nav-btn">
      	<c:if test="${ldto.user_auth ne 'M'}">  
         <a href="#" onclick="sketchBookMake('${ldto.user_email}')" class="btn btn-lp-primary btn-icon-split lp-write-btn btn-sl btn-ss">
            <span class="text">Create Travel Sketchbook</span>
         </a>
         </c:if>
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