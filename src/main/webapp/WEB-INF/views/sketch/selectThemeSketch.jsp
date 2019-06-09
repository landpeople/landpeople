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
				                      		<h2>${item.sketch_title} | <i class="fas fa-heart"></i><span> ${sketchLike[item.sketch_id]}명</span></h2>
				                           <a class="info" href="#" onclick="goCanvas('${item.sketch_id}')">Show detail</a>
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
                                     	<a class="info" href="#" onclick="goCanvas('${item.sketch_id}')">Show detail</a>
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
               		</div>
            	</div><!-- End of lp-content -->
           	</div><!--End of Page LandPeople Content Area -->
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
         		if(pageCnt >= <%=pagingDto.getLastPageNo()%>){
//             	alert("마지막페이지 입니다.");
	        	}else{      
	           		pageCnt++;        
	            	getSketchBook(pageCnt);
	         	}
      });
         
   $(".allThemeContent").scroll(
		function(event){
			  var scrollT = $(this).scrollTop(); //스크롤바의 상단위치
		      var scrollH = $(this).height(); //스크롤바를 갖는 div의 높이
		      var contentH = $('.themeContent').height(); //문서 전체 내용을 갖는 div의 높이
		    
		      if(scrollT + scrollH + 1.5 >= contentH) { // 스크롤바가 맨 아래에 위치할 때
		      	 $("#infinityScroll").trigger("click");
		      }
		});
	});
   
function getSketchBook(pageNo){     
   var type = "${type}"
      $.ajax({
         url: "sketchBookPaging.do",
         type: "get",
         data: {"pageNo": pageNo , "type" : type}, 
         dataTypes: "json",
         success: function(msg){
				     var sketchLikes = msg.likeTheme;
				     var sketchNicknames = msg.sketchNicknames;
				     var sketch="";
				     
				     for(var i = 0 ; i < parseInt(msg.addSketchBook.length) ; i++){
				         var sketch_id=   msg.addSketchBook[i].sketch_id;
				        sketch += "<div class='single-sketchbook'>" + 
				        				"<div class='hovereffect2'>" +
				       					"<img class='img-responsive' src=" + msg.addSketchBook[i].sketch_spath + " alt=''>" +
				        					"<div class='overlay2'>" +
				        						"<h2>" + msg.addSketchBook[i].sketch_title + " | <i class='fas fa-heart'></i><span>" + sketchLikes[msg.addSketchBook[i].sketch_id] + "명</span></h2>" +
				        						"<a class='info' href='#' onclick='goCanvas(" + msg.addSketchBook[i].sketch_id + ")'>Show detail</a>" +
				        					"</div>" +
				     				"</div>" +
				    		"</div>";
				     }
            $(".themeContent").append(sketch);
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



