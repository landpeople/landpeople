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
<link href="./css/theme/sb-admin-booklet.css" rel="stylesheet">
<link href="./css/theme/lp-template.css" rel="stylesheet">
<link href="./css/sketch/modal.css" rel="stylesheet">

</head>

<!-- 토스트 에디터 파일 가져오기 -->
<link rel="stylesheet" href="https://uicdn.toast.com/tui-editor/latest/tui-editor.css"></link>
<link rel="stylesheet" href="https://uicdn.toast.com/tui-editor/latest/tui-editor-contents.css"></link>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.33.0/codemirror.css"></link>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.12.0/styles/github.min.css"></link>
<script src="https://uicdn.toast.com/tui-editor/latest/tui-editor-Editor-full.js"></script>
<!-- CSS -->
<link rel="stylesheet" href="./css/freeCanvasLayout.css">
<link rel="stylesheet" href="./css/lp-freeCanvas-style.css">
<!-- jQuery -->
<script type="text/javascript" src="./js/jquery-3.3.1.js"></script>
<!-- Booklet  -->
<script src="./js/jquery-ui.js"></script>
<script src="./js/jquery.easing.1.3.js"></script>
<script src="./js/jquery.booklet.latest.min.js"></script>
<link href="./css/jquery.booklet.latest.css" type="text/css" rel="stylesheet" media="screen, projection, tv" />
<script src="./js/min/plugins.min.js"></script>
<!-- bootstrap -->
<script src="./js/min/main.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<!-- summernote css/js -->
<!-- <link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote.css" rel="stylesheet"> -->
<!-- <script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote.js"></script> -->
<!-- js -->
<script src="./js/freeCanvas/freeCanvas.js" defer="defer"></script>
<!-- font awesome -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">



<body id="page-top" class="scroll">

   <!-- Page Wrapper -->
   <div id="wrapper">
      <%@include file="./common/lp-sidebar.jsp"%>

      <!-- Content Wrapper -->
      <div id="content-wrapper" class="d-flex flex-column">
         <!-- flex 레이아웃 content와 푸터 정렬 -->

         <!-- Main Content -->
         <div id="content" style="display: flex; flex-direction: column;">

            <!-- LandPeople Content Area -->
            <div class="lp-container">
               <div class="lp-content shadow-lg">
               
                  <div class="head-title">
         <div class="back" onclick="javascript:history.back(-1)"><i class="fas fa-reply fa-3x"></i></div>
         <div class="title">[스케치북 제목이 들어갑니다.]</div>
         <div class="imageDown"><i class="far fa-file-image fa-4x"></i></div>
         <div class="excelDown"><i class="far fa-file-excel fa-4x"></i></div>
      </div>
      
      <div class="article-canvasContent">
      <form method="post" enctype="multipart/form-data" name="frm" id="frm">
         <div id="mybook">
         <!-- 왼쪽 -->
         <div id="Left-Side">
            <div id="IMG1">
               <label for="C_IMG1"><img src="./img/folder.png"></label> 
               <input id="C_IMG1" class="file" name="file" type="file" multiple="multiple" style="display: none;">
            </div>
               <input type="hidden" name="list[0].img_spath" class="img_spath0">          
               <input type="hidden" name="list[0].text_no" value="0"> 
               <div id="TXT1">
                  <textarea style="width: 100%; height: 100%; resize: none;" class="text"></textarea>
               </div>
                  <input type="hidden" name="list[1].text_content" class="text_content0">
                  <input type="hidden" name="list[1].text_no" value="1"> 
         </div>
   
         <!-- 오른쪽  -->
         <div id="Right-Side">
            <div id="RS_Container_1">
               <div id="TXT2">
                  <textarea id="textarea" style="width: 100%; height: 100%; resize: none;"></textarea>
               </div>
                  <input type="hidden" name="list[2].text_content" class="text_content1">
                  <input type="hidden" name="list[2].text_no" value="2"> 
               <div id="TXT3">
                  <textarea style="width: 100%; height: 100%; resize: none;"></textarea>
               </div> 
                  <input type="hidden" name="list[3].text_content" class="text_content2">
                  <input type="hidden" name="list[3].text_no" value="3"> 
               <div id="TXT4">
                  <textarea style="width: 100%; height: 100%; resize: none;"></textarea>
               </div>
                  <input type="hidden" name="list[4].text_content" class="text_content3">
                  <input type="hidden" name="list[4].text_no" value="4"> 
            </div>
            <div id="RS_Container_2">
               <div>
                  <div id="IMG2">
                     <label for="C_IMG2"><img src="./img/folder.png"></label> 
                     <input id="C_IMG2" class="file" name="file" type="file" multiple="multiple" style="display: none;">
                  </div>
                     <input type="hidden" name="list[5].img_spath" class="img_spath1">
                     <input type="hidden" name="list[5].text_no" value="5"> 
                  <div id="IMG3">
                     <label for="C_IMG3"><img src="./img/folder.png"></label> 
                     <input id="C_IMG3" class="file" name="file" type="file" multiple="multiple" style="display: none;">
                  </div>
                     <input type="hidden" name="list[6].img_spath" class="img_spath2">
                     <input type="hidden" name="list[6].text_no" value="6"> 
               </div>
            </div>
         </div>
      </div>
   </form>
   </div>
   
   <div class="footer-icon">
      <div class="insertIcon" onclick="insert()">
         <img id="insert" src="./img/check.png">
      </div>
   </div>
   
               
               
               
               
               
               </div>
            </div>
            <!--End of Page LandPeople Content Area -->
            <%@include file="./common/lp-footer.jsp"%>
            <!-- End of Page Wrapper -->
         </div>
      </div>
   </div>
</body>
</html>



