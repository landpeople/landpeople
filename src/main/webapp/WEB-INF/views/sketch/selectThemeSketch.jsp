<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="happy.land.people.dto.LPSketchbookDto"%>
<%@page import="happy.land.people.dto.SketchPagingDto"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%
   List<LPSketchbookDto> maxLikeSketchBook = (List<LPSketchbookDto>)request.getAttribute("maxLikeSketchBook");
   Map<String,Integer> maxLike = (Map<String,Integer>)request.getAttribute("maxLike");
   Map<String, String> likeSketchNickname = (Map<String, String>)request.getAttribute("likeSketchNickname");
   SketchPagingDto pagingDto = (SketchPagingDto)request.getAttribute("pagingDto");
   List<LPSketchbookDto> sketchList = (List<LPSketchbookDto>)request.getAttribute("sketchBook");
   Map<String,Integer> sketchLike = ( Map<String,Integer> )request.getAttribute("sketchLike");
   Map<String, String> sketchNickname = (Map<String, String>)request.getAttribute("sketchNickname");
   String type = (String)request.getAttribute("type");
   Map<String,Integer> sketchLikes = ( Map<String,Integer> )request.getAttribute("sketchLike");
%>
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
<link rel="stylesheet" href="./css/sketch/sketch.css">
<link href="./css/sketch/modal.css" rel="stylesheet">

<script src="./js/theme/jquery.min.js"></script>

<script type="text/javascript">

console.log('${sketchBook}');

</script>


</head>
<body id="page-top" class="scroll">


   <!-- Page Wrapper -->
   <div id="wrapper">
      <%@include file="../common/lp-sidebar.jsp"%>

      <!-- Content Wrapper -->
      <div id="content-wrapper" class="d-flex flex-column"><!-- flex 레이아웃 content와 푸터 정렬 -->
         
         <!-- Main Content -->
         <div id="content" style="display: flex; flex-direction: column;">

            <!-- LandPeople Content Area -->
            <div class="lp-container">
               <div class="lp-content shadow-lg">
                  <div class="lp-content-sketch"><!-- lp-content-sketch 영역 시작 -->
                     <div class="lp-content-header">
                        <h1 class="h2 mb-4 text-gray-800 lp-content-title">${themeTitle}</h1>
                     </div>
                     <div class="allThemeContent scroll">
                     	<c:choose>
                           	<c:when test="${fn:length(maxLikeSketchBook) eq 0}">
                               	<div class="bestThemeContent-none"><!-- 좋아요 카운트 top 3 스케치북  -->
                                      <h2>좋아요한 스케치북이 없습니다.</h2>
                                </div>
                            </c:when>
                            <c:otherwise>
                       		<div class="bestThemeContent"><!-- 좋아요 카운트 top 3 스케치북  -->
                                <c:forEach var="item" items="${maxLikeSketchBook}">
		                           <div class="single-sketchbook">
		                              <div class="hovereffect2">
		                                           <img class="img-responsive" src="${item.sketch_spath }" alt="">
		                                            <div class="overlay2">
		                                               <h2>Hover effect 4</h2>
		                                               <a class="info" href="#">link here</a>
		                                            </div>
		                                        </div>
		                                      </div>
                                 		</c:forEach>                                   
                        		</div>
                              </c:otherwise>
                           </c:choose>
                        <div class="themeContent">
                           <c:forEach var="item" items="${sketchBook}">
                             <div class="single-sketchbook">
                                  <div class="hovereffect2">
                                      <img class="img-responsive" src="${item.sketch_spath }" alt="">
                                         <div class="overlay2">
                                            <h2>${item.sketch_title} | <i class="fas fa-heart"></i><span> ${sketchLike[item.sketch_id]}명</span></h2>
                                               <a class="info" href="#" onclick="goCanvas('${item.sketch_id}')">link here</a>
                                         </div>
                                  </div>
                             </div>
                          </c:forEach> 
                        </div>
                    </div>   
      			 	 <c:if test="${fn:length(sketchBook) eq '6'}">
      				 	<div class="view-more">
      						<button id="infinityScroll" class="btn">View more</button>
      					</div>
      				</c:if>
      				<!-- 여기까지 스케치북 수정 Modal -->
            
            <!-- End of lp-content -->
               
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
<script type="text/javascript">
   // 무한 스크롤 적용된 스케치북 조회
   var pageCnt = <%=pagingDto.getNowPageNo()%>
   
   $("document").ready(
         function() {
            $("#infinityScroll").click(
               function() {
                  $("#infinityScroll").hide();                 
            if(pageCnt >= <%=pagingDto.getEndPageNo()%>){
               alert("마지막페이지 입니다.");
            }else{      
               pageCnt++;        
               getSketchBook(pageCnt);
            }
         });
            
      $(".sketckBookScroll").scroll(
            function(event){
         
               var hh = $(this).height();
               var ee = $(this).scrollTop();
               
               var scHeight = $(".themeContent").prop('scrollHeight');
               
               if (scHeight - hh - ee < 1) {
                  $("#infinityScroll").trigger("click");
               }
         
      });
   });
   

   
   function getSketchBook(pageNo){     
      var type = "${type}"
         $.ajax({
            url: "sketchBookPaging.do",
            type: "get",
            data: {"pageNo": pageNo , "type" : type }, 
            dataTypes: "json",
            success: function(msg){
               alert(msg.addSketchBook.length);
               var sketchLikes = msg.likeTheme;
               var sketchNicknames = msg.sketchNicknames;
               

               //alert(sketchNicknames);
               
               var sketchBookContent= document.getElementsByClassName("sketchBookContent")[0];
               var content= document.getElementsByClassName("content")[0];
               /* var sketchBookContent = document.createElement('div');
               sketchBookContent.className = 'sketchBookContent'; */
               
                
               for(var i = 0 ; i < parseInt(msg.addSketchBook.length/3) ; i++){
                  
                  
                  var sketchBookContainer = document.createElement('div');
                  sketchBookContainer.className = 'sketchBookContainer';    
                  
                  for(var j = 0; j < 3; j++){
                  
                   var sketch_id=   msg.addSketchBook[i*3+j].sketch_id;
                   //alert(sketch_id);
                     
                  sketchBookContainer.innerHTML +=
                                          "<div style='width: 280px; height: 230px; border: 1px solid gray; display: inline-block; margin: 0 0 0 10px; position: relative;'>"+
                                             "<div class='selectTheme' style='background-image: url("+msg.addSketchBook[i*3+j].sketch_spath+")'>"+
                                                "<div class='sketchTheme_hover' style=' cursor: pointer;' onclick='goCanvas("+msg.addSketchBook[i*3+j].sketch_id+")'>"+
                                                   "<div class='hover_inside'>"+
                                                      "<h5><img alt='likeIcon' src='./img/sketch/likeIcon.png'>"+
                                                      sketchLikes[(sketch_id)]+""+type+"</h5>"+ 
                                                   "</div>"+
                                                "</div>"+
                                             "</div>"+
                                             "<div style='width: 100%; height: 60px; border: 1px solid black; position: absolute; bottom: 0px;'>"+
                                                "<label>"+msg.addSketchBook[i*3+j].sketch_title+"</label>"+"<label style='float: right;'>"+sketchNicknames[(sketch_id)]+"</label><br>"+
                                             "</div>"+
                                          "</div>";
                                          
                  
                  
                  
                  }
                  $(".sketchBookContent").append(sketchBookContainer);
               } 
               
               if(msg.addSketchBook.length%3 !=0){ 
                  var sketchBookContainer = document.createElement('div');
                  sketchBookContainer.className = 'sketchBookContainer';   
                  
                  for(var i = 0; i < msg.addSketchBook.length%3; i++){                    
                     
                     var sketch_id= msg.addSketchBook[parseInt(parseInt(msg.addSketchBook.length/3)*3+i)].sketch_id;
                     sketchBookContainer.innerHTML +=  "<div style='width: 280px; height: 230px; border: 1px solid gray; display: inline-block; margin: 0 0 0 10px; position: relative;'>"+
                                             "<div class='selectTheme' style='background-image: url("+msg.addSketchBook[parseInt(parseInt(msg.addSketchBook.length/3)*3+i)].sketch_spath+")'>"+
                                                "<div class='sketchTheme_hover' style=' cursor: pointer;' onclick='goCanvas("+msg.addSketchBook[parseInt(parseInt(msg.addSketchBook.length/3)*3+i)].sketch_id+")'>"+
                                                   "<div class='hover_inside'>"+
                                                      "<h5><img alt='likeIcon' src='./img/sketch/likeIcon.png'>"+
                                                      sketchLikes[(sketch_id)]+""+type+"</h5>"+ 
                                                   "</div>"+
                                                "</div>"+
                                             "</div>"+
                                             "<div style='width: 100%; height: 60px; border: 1px solid black; position: absolute; bottom: 0px;'>"+
                                                /* "<input type='checkbox' name='chkVal' value='"+msg.addSketchBook[parseInt(parseInt(msg.addSketchBook.length/3)*3+i)].sketch_id+"'>"+ */
                                                "<label>"+msg.addSketchBook[parseInt(parseInt(msg.addSketchBook.length/3)*3+i)].sketch_title+"</label>"+"<label style='float: right;'>"+sketchNicknames[(sketch_id)]+"</label><br>"+
                                                /* "<label><a href='#' onclick='return sketchBookModify("+msg.addSketchBook[parseInt(parseInt(msg.addSketchBook.length/3)*3+i)].sketch_id+")'><img alt='modi' src='img/sketch/modifyIcon.png'>스케치북 수정</a></label>"+ */
                                             "</div>"+
                                          "</div>";
                  
                  
                  
                  }
                  $(".sketchBookContent").append(sketchBookContainer);
               }
                  
               
               
         }, error : function() {
               alert("실패");
         }
      });
   
   
   }
   
   // 테마별, 작성, 스크랩 스케치북 조회 무한스크롤 후 캔버스 조회 페이지로 이동
   function goCanvas(sketch_id) {
      location.href="./detailCanvas.do?sketch_id="+sketch_id;
   }
   </script>
</html>



