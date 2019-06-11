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
<link rel="stylesheet" href="./css/canvas/freeCanvas-Layout.css">
<link rel="stylesheet" href="./css/canvas/freeCanvas-style.css">

</head>

<!-- jQuery -->
<script type="text/javascript" src="./js/jquery-3.3.1.js"></script>
<!-- Booklet  -->
<script src="./js/jquery-ui.js"></script>
<script src="./js/jquery.easing.1.3.js"></script>
<script src="./js/jquery.booklet.latest.min.js"></script>
<link href="./css/canvas/jquery.booklet.latest.css" type="text/css" rel="stylesheet" media="screen, projection, tv" />
<script src="./js/min/plugins.min.js"></script>
<!-- bootstrap -->
<script src="./js/min/main.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<!-- js -->
<script src="./js/freeCanvas/freeCanvas.js" defer="defer"></script>
<body id="page-top" class="scroll">

   <!-- Page Wrapper -->
   <div id="wrapper">
      <%@include file="../common/lp-sidebar.jsp"%>

      <!-- Content Wrapper -->
      <div id="content-wrapper" class="d-flex flex-column">
         <!-- flex 레이아웃 content와 푸터 정렬 -->

         <!-- Main Content -->
         <div id="content" style="display: flex; flex-direction: column;">

            <!-- LandPeople Content Area -->
            <div class="lp-container">
               <div class="lp-other-content shadow-lg" style="overflow:hidden">

                  <div class="head-title">
                         <div class="back" onclick="javascript:history.back(-1)">
                         	<img alt="뒤로가기" src="./img/canvas/back.png"
								onmouseover="this.src='./img/canvas/back-over.png';"
								onmouseout="this.src='./img/canvas/back.png';">
                         </div>
                         <div class="title">${sketch_title}</div>
                     </div>

                  <div class="article-canvasContent">
                     <form method="post" enctype="multipart/form-data" name="frm" id="frm">
                        <!-- 왼쪽 -->
                        <div id="mybook">
                           <div id="Left-Side5">
                              <div id="LS_IContainer5">
                                 <div id="IMG51">
                                    <label for="C_IMG51"><img src="./img/canvas/insertImg.png" class="insertImg"></label>
                                    <input id="C_IMG51" class="file" name="file" type="file" multiple="multiple" style="display: none;">
                                 </div>
                                 <input type="hidden" name="list[0].img_spath" class="img_spath0">
                                 <input type="hidden" name="list[0].text_no" value="0">
                              </div>
                              <div id="LS_TContainer5">
                                 <div id="TXT51" style="overflow: auto;">	
                                 	<a onclick="editor('txt51')" class="inner"><img alt="글 작성" src="./img/canvas/editor.png"></a>
									<div id="txt51"></div>
                                 </div>
                                 <input type="hidden" name="list[1].text_content" class="text_content0">
                                 <input type="hidden" name="list[1].text_no" value="1">
                              </div>
                           </div>

                           <!-- 오른쪽 -->
                           <div id="Right-Side5">
                              <div id="RS_ITContainer51">
                                 <div id="IMG52">
                                    <label for="C_IMG52"><img src="./img/canvas/insertImg.png" class="insertImg"></label>
                                    <input id="C_IMG52" class="file" name="file" type="file" multiple="multiple" style="display: none;">
                                 </div>
                                 <input type="hidden" name="list[2].img_spath" class="img_spath1">
                                 <input type="hidden" name="list[2].text_no" value="2">
                                 <div id="TXT52" style="overflow: auto;">
                                 	<a onclick="editor('txt52')" class="inner"><img alt="글 작성" src="./img/canvas/editor.png"></a>
									<div id="txt52"></div>
                                 </div>
                                 <input type="hidden" name="list[3].text_content" class="text_content1">
                                 <input type="hidden" name="list[3].text_no" value="3">
                                 <div id="IMG53">
                                    <label for="C_IMG53"><img src="./img/canvas/insertImg.png" class="insertImg"></label>
                                    <input id="C_IMG53" class="file" name="file" type="file" multiple="multiple" style="display: none;">
                                 </div>
                                 <input type="hidden" name="list[4].img_spath" class="img_spath2">
                                 <input type="hidden" name="list[4].text_no" value="4">
                              </div>
                              <div id="RS_ITContainer52">
                                 <div id="TXT53" style="overflow: auto;">
                                 	<a onclick="editor('txt53')" class="inner"><img alt="글 작성" src="./img/canvas/editor.png"></a>
									<div id="txt53"></div>
                                 </div>
                                 <input type="hidden" name="list[5].text_content" class="text_content2">
                                 <input type="hidden" name="list[5].text_no" value="5">
                                 <div id="IMG54">
                                    <label for="C_IMG54"><img src="./img/canvas/insertImg.png" class="insertImg"></label>
                                    <input id="C_IMG54" class="file" name="file" type="file" multiple="multiple" style="display: none;">
                                 </div>
                                 <input type="hidden" name="list[6].img_spath" class="img_spath3">
                                 <input type="hidden" name="list[6].text_no" value="6">
                                 <div id="TXT54" style="overflow: auto;">
                                 	<a onclick="editor('txt54')" class="inner"><img alt="글 작성" src="./img/canvas/editor.png"></a>
									<div id="txt54"></div>
                                 </div>
                                 <input type="hidden" name="list[7].text_content" class="text_content3">
                                 <input type="hidden" name="list[7].text_no" value="7">
                              </div>
                           </div>
                        </div>
                     </form>
                  </div>

                   <div class="footer-icon">
				      <div class="insertIcon" onclick="insert()">
				         <img id="insert" alt="등록하기" src="./img/canvas/check.png"
				         	onmouseover="this.src='./img/canvas/check-over.png';"
				         	onmouseout="this.src='./img/canvas/check.png';">
				      </div>
    			  </div>

               </div>
            </div>
            <!--End of Page LandPeople Content Area -->
            <%@include file="../common/lp-footer.jsp"%>
            <!-- End of Page Wrapper -->
         </div>
      </div>
   </div>
</body>
</html>