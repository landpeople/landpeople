<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="happy.land.people.dto.LPSketchbookDto"%>
<%@page import="happy.land.people.dto.SketchPagingDto"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%
	SketchPagingDto pagingDto = (SketchPagingDto) request.getAttribute("pagingDto");
	List<LPSketchbookDto> myScrapeList = (List<LPSketchbookDto>) request.getAttribute("myScrapeList");
	Map<String, Integer> sketchLike = (Map<String, Integer>) request.getAttribute("sketchLike");
	Map<String, String> scrapeSketchNickname = (Map<String, String>) request.getAttribute("scrapeSketchNickname");
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
<link href="./css/sketch/modal.css" rel="stylesheet">
<link href="./css/sketch/sketch.css" rel="stylesheet"> 
<link href="./css/theme/checkradio.css" rel="stylesheet">

<script src="./js/theme/jquery.min.js"></script>

</head>
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
               <div class="lp-content shadow-lg">
                	<div class="lp-content-sketch">
						<form action="#" method="post" id="scrapeSketch" name="scrapeSketch" onsubmit="ScrapeChk()">
	                            <input type="hidden" name="user_email" value="${ldto.user_email}">
							<div class="lp-content-header">
								<h1 class="h2 mb-4 text-gray-800 lp-content-title">My scrapbook</h1>
								<div>
								<input class="btn btn-success mb-4 lp-sketch-del" id="topBtn" type="button" value="Move to top">
								<input class="btn btn-danger mb-4 lp-sketch-del " type="submit" value="Cancle scrap selected">
								</div>
							</div>
							<div class="sketckBookScroll scroll">
								<div class="sketchBookContent">
									<c:forEach var="item" items="${myScrapeList}">
										<div class="single-sketchbook">
											<div class="hovereffect1">
												<img class="img-responsive" src="${item.sketch_spath}" alt="">
												<div class="overlay1">
													<input class="is-checkradio is-info is-circle" id="chk${item.sketch_id}" value="${item.sketch_id}" type="checkbox" name="chkVal">
                                                    <label class="lp-check-box" for="chk${item.sketch_id}"></label>
													<h1>[ ${item.sketch_theme} ]</h1>
													<h2>${item.sketch_title} | <i class="fas fa-heart"></i><span> ${sketchLike[item.sketch_id]}명</span>
													</h2>
													<p class="modify-icon">
														<i class="fas fa-smile"></i> ${scrapeSketchNickname[(item.sketch_id)]}
													</p>
													<p>
														<a href="#" onclick="goCanvas('${item.sketch_id}')">Show detail</a>
													</p>
												</div>
											</div>
										</div>
									</c:forEach>
								</div>
							</div>
						</form>
	
						<c:if test="${fn:length(myScrapeList) eq '9'}">
							<div class="view-more">
								<button id="infinityScroll" class="view-btn">View more</button>
							</div>
						</c:if>
					<!-- 여기까지 스케치북 수정 Modal -->
						</div>
						<!-- 스케치북 정렬을 위한 lp-content-sketch -->
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
				$("#topBtn").hide();
				$("#infinityScroll").click(
					function() {
						$("#infinityScroll").hide();						
						$("#topBtn").show();						
						if(pageCnt >= <%=pagingDto.getLastPageNo()%>){
						}else{		
							pageCnt++;			
							getSketchBook(pageCnt);
						}
					});
				
				$(".sketckBookScroll").scroll(
					function(event){
						  var scrollT = $(this).scrollTop(); //스크롤바의 상단위치
					      var scrollH = $(this).height(); //스크롤바를 갖는 div의 높이
					      var contentH = $('.sketchBookContent').height(); //문서 전체 내용을 갖는 div의 높이
					    
					      if(scrollT + scrollH + 1.5 >= contentH) { // 스크롤바가 맨 아래에 위치할 때
					      	 $("#infinityScroll").trigger("click");
					      }
					});
				});  
   
   function getSketchBook(pageNo){     
   var user_email = "${ldto.user_email}"  
         
         $.ajax({
            url: "scrapeSketchBookPaging.do",
            type: "get",
            data: {"pageNo": pageNo , "user_email" : user_email }, 
            dataTypes: "json",
            success: function(msg){
               alert(msg.addScrapeSketchBook.length);    
               var sketchLike = msg.likeScrape;
               var sketchNickname = msg.scrapeSketchNickname;
               var sketch = "";
               
               for(var i = 0 ; i < parseInt(msg.addScrapeSketchBook.length) ; i++){
                   var sketch_id=   msg.addScrapeSketchBook[i].sketch_id;
                     
                   sketch += "<div class='single-sketchbook'>"+
					"<div class='hovereffect1'>"+
					"<img class='img-responsive' src=" + msg.addScrapeSketchBook[i].sketch_spath + " alt=''>"+
					"<div class='overlay1'>"+
						"<input class='is-checkradio is-info is-circle' id='chk" + msg.addScrapeSketchBook[i].sketch_id + "' value='" + msg.addScrapeSketchBook[i].sketch_id + "' type='checkbox' name='chkVal'>" +
						"<label class='lp-check-box' for='chk" + msg.addScrapeSketchBook[i].sketch_id + "'></label>"+
						"<h1>[ " + msg.addScrapeSketchBook[i].sketch_theme + " ]</h1>"+
						"<h2>" + msg.addScrapeSketchBook[i].sketch_title + " | <i class='fas fa-heart'></i><span>" + sketchLike[sketch_id] + "명</span>"+
						"</h2>" +
						"<p class='modify-icon'>" +
						"<i class='fas fa-smile'></i> " + sketchNickname[sketch_id] +
						"</p>" +
						"<p>"+
							"<a href='#' onclick='goCanvas(" + msg.addScrapeSketchBook[i].sketch_id + ")'>Show detail</a>"+
						"</p>"+
					"</div>"+
				"</div>"+
			"</div>";
                  }
                  $(".sketchBookContent").append(sketch);
	         }, error : function() {
               alert("실패");
         }
      });
   }
   

   var topEle = $('#topBtn');
   var delay = 1000;
   topEle.on('click', function() {
     $('.sketckBookScroll').animate({scrollTop: 0}, delay);
   });
//---------------------- 스케치북 다중 스크랩  취소 -----------------------
   function ScrapeChk(){
//    alert("작동");
      var chks =  document.getElementsByName("chkVal");
      var c = 0;
      for (var i = 0; i < chks.length; i++) {
         if(chks[i].checked){
            c++;
         }
      }
      if(c>0){
//       var doc = document.getElementById("scrapeDiv");
//       var doc = document.forms[0];
         var scrapeChk = confirm("스크랩을 등록을 취소하시겠습니까?");
         if(scrapeChk == true){
         
            var scrapeSketch =document.getElementById("scrapeSketch");
            scrapeSketch.action = "./multiScrapeUpdate.do";
            
            return true;
         }else{
            alert("취소x");
            
            return false;
         }
         
      }else{
         alert("선택된 스케치북이 없습니다.");
         return false;
      }
   }
   
   // 테마별, 작성, 스크랩  스케치북 조회 무한스크롤 후 캔버스 조회 페이지로 이동
   function goCanvas(sketch_id) {
      //alert(sketch_id);
      location.href="./detailCanvas.do?sketch_id="+sketch_id;
   }
   </script>
</html>