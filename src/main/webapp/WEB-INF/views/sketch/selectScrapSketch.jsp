<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="happy.land.people.dto.LPSketchbookDto"%>
<%@page import="happy.land.people.dto.SketchPagingDto"%>

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
                  <form action="#" method="post" id="scrapeSketch" name="scrapeSketch" onsubmit="ScrapeChk()">
                     <input type="submit" value="스크랩 취소">
                     <div class="sketchBookContent">


                        <%
                        	for (int i = 0; i < myScrapeList.size() / 3; i++) {
                        %>
                        <!--스케치북 3개 담는 div  -->
                        <div class="sketchBookContainer">

                           <%
                           	for (int j = 0; j < 3; j++) {
                           			String sketch_id = myScrapeList.get(i * 3 + j).getSketch_id();
                           %>
                           <!--스케치북 1개 담는 div  -->
                           <%-- <div class="selectTheme" style="background-image: url('<%=myScrapeList.get(i*3+j).getSketch_spath()%>')">
                           <div class="sketchTheme_hover" onclick="location.href='./kim.do?sketch_id=<%=myScrapeList.get(i*3+j).getSketch_id()%>'"><!-- onclick="sketchSelectTheme('나홀로')" -->
                              <div class="hover_inside">
                                 <span><%=myScrapeList.get(i*3+j).getSketch_title()%></span>
                                 <h5><img alt="likeIcon" src="./img/sketch/likeIcon.png"> 
                                 <%=sketchLike.get(sketch_id)%> <%=myScrapeList.get(i*3+j).getSketch_theme()%> <%=scrapeSketchNickname.get(sketch_id)%></h5>
                              </div>
                           </div>
                           
                        </div> --%>
                           <!--스케치북 1개 담는 div  -->

                           <!--스케치북 1개 담는 div  -->
                           <div style="width: 280px; height: 230px; border: 1px solid gray; display: inline-block; margin: 0 0 0 10px; position: relative;">
                              <div class="selectTheme" style="background-image: url('<%=myScrapeList.get(i * 3 + j).getSketch_spath()%>');">
                                 <div class="sketchTheme_hover" style="cursor: pointer;" onclick="location.href='./kim.do?sketch_id=<%=myScrapeList.get(i * 3 + j).getSketch_id()%>'">
                                    <div class="hover_inside">
                                       <h5>
                                          <img alt="likeIcon" src="./img/sketch/likeIcon.png">
                                          <%=sketchLike.get(sketch_id)%>
                                          <%=myScrapeList.get(i * 3 + j).getSketch_theme()%>
                                       </h5>
                                    </div>
                                 </div>
                              </div>
                              <div style="width: 100%; height: 60px; border: 1px solid black; position: absolute; bottom: 0px;">
                                 <input type="checkbox" name="chkVal" value="<%=myScrapeList.get(i * 3 + j).getSketch_id()%>">
                                 <label><%=myScrapeList.get(i * 3 + j).getSketch_title()%></label><label style="float: right;"><%=scrapeSketchNickname.get(sketch_id)%></label><br>
                                 <%-- <label><a href="#" onclick="return sketchBookModify('<%=myScrapeList.get(i*3+j).getSketch_id()%>')"><img alt="modi" src="img/sketch/modifyIcon.png">스케치북 수정</a></label> --%>
                              </div>
                           </div>
                           <!--스케치북 1개 담는 div  -->










                           <%
                           	}
                           %>
                        </div>

                        <%
                        	}
                        %>


                        <%
                        	if (myScrapeList.size() % 3 != 0) {
                        %>
                        <div class="sketchBookContainer">

                           <%
                           	for (int i = 0; i < myScrapeList.size() % 3; i++) {
                           			String sketch_id = myScrapeList.get((myScrapeList.size() / 3) * 3 + i).getSketch_id();
                           %>
                           <%-- <div class="selectTheme" style="background-image: url('<%=myScrapeList.get((myScrapeList.size()/3)*3+i).getSketch_spath()%>')">
                           <div class="sketchTheme_hover" onclick="location.href='./kim.do?sketch_id=<%=myScrapeList.get((myScrapeList.size()/3)*3+i).getSketch_id()%>'">
                              <div class="hover_inside">
                                 <span><%=myScrapeList.get((myScrapeList.size()/3)*3+i).getSketch_title()%></span>
                                 <h5><img alt="likeIcon" src="./img/sketch/likeIcon.png"> 
                                 <%=sketchLike.get(sketch_id)%> <%=myScrapeList.get((myScrapeList.size()/3)*3+i).getSketch_theme()%> <%=scrapeSketchNickname.get(sketch_id)%> </h5>
                              </div>
                           </div>
                           
                        </div> --%>

                           <!--스케치북 1개 담는 div  -->
                           <div style="width: 280px; height: 230px; border: 1px solid gray; display: inline-block; margin: 0 0 0 10px; position: relative;">
                              <div class="selectTheme" style="background-image: url('<%=myScrapeList.get((myScrapeList.size() / 3) * 3 + i).getSketch_spath()%>');">
                                 <div class="sketchTheme_hover" style="cursor: pointer;" onclick="location.href='./kim.do?sketch_id=<%=myScrapeList.get((myScrapeList.size() / 3) * 3 + i).getSketch_id()%>'">
                                    <div class="hover_inside">
                                       <h5>
                                          <img alt="likeIcon" src="./img/sketch/likeIcon.png">
                                          <%=sketchLike.get(sketch_id)%>
                                          <%=myScrapeList.get((myScrapeList.size() / 3) * 3 + i).getSketch_theme()%>
                                       </h5>
                                    </div>
                                 </div>
                              </div>
                              <div style="width: 100%; height: 60px; border: 1px solid black; position: absolute; bottom: 0px;">
                                 <input type="checkbox" name="chkVal" value="<%=myScrapeList.get((myScrapeList.size() / 3) * 3 + i).getSketch_id()%>">
                                 <label><%=myScrapeList.get((myScrapeList.size() / 3) * 3 + i).getSketch_title()%></label><label style="float: right;"><%=scrapeSketchNickname.get(sketch_id)%></label><br> <label><a href="#" onclick="return sketchBookModify('<%=myScrapeList.get((myScrapeList.size() / 3) * 3 + i).getSketch_id()%>')">
                                       <img alt="modi" src="img/sketch/modifyIcon.png">스케치북 수정
                                    </a></label>
                              </div>
                           </div>
                           <!--스케치북 1개 담는 div  -->





                           <%
                           	}
                           %>
                        </div>

                        <%
                        	}
                        %>
                     </div>
                  </form>
                  <%
                  	if (myScrapeList.size() % 9 == 0) {
                  %>
                  <button id="infinityScroll" style="width: 100%;">더보기</button>
                  <%
                  	}
                  %>


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
            
            
            $(".content").scroll(
                  function(event){
               
                     var hh = $(".content").height();
                     var ee = $(".content").scrollTop();
                     
                     var scHeight = $(".content").prop('scrollHeight');
                     
                     if (scHeight - hh - ee < 1) {
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
               
               //var content =  document.getElementsByClassName("content")[0];
               var sketchBookContent= document.getElementsByClassName("sketchBookContent")[0];
               var sketchBookContent = document.createElement('div');
                  sketchBookContent.className = 'sketchBookContent'; 
                  
               for(var i = 0 ; i < parseInt(msg.addScrapeSketchBook.length/3) ; i++){
                  
                  var sketchBookContainer = document.createElement('div');
                  sketchBookContainer.className = 'sketchBookContainer';    //style='background: url('"+msg.addSketchBook[i].sketch_spath+"');"
                  
                  for(var j = 0; j < 3; j++){
                  
                   var sketch_id=   msg.addScrapeSketchBook[i*3+j].sketch_id;
                   //alert(sketch_id);
                     
                  sketchBookContainer.innerHTML +=/*  "<div class='selectTheme' style='background-image: url("+msg.addScrapeSketchBook[i*3+j].sketch_spath+")'>"+
                                          "<div class='sketchTheme_hover' onclick='goCanvas("+msg.addScrapeSketchBook[i*3+j].sketch_id+")'>"+
                                          "<div class='hover_inside'>"+"<span>"+msg.addScrapeSketchBook[i*3+j].sketch_title+"</span>"+"<h5>"+"<img alt='likeIcon' src='./img/sketch/likeIcon.png'>"+
                                          sketchLike[(sketch_id)]+"</h5>"+
                                          "<h5>"+msg.addScrapeSketchBook[i*3+j].sketch_theme+""+sketchNickname[(sketch_id)]+"<h5>"+ 
                                          "</div></div></div>"; */
                                          
                                          
                                       "<div style='width: 280px; height: 230px; border: 1px solid gray; display: inline-block; margin: 0 0 0 10px; position: relative;'>"+
                                          "<div class='selectTheme' style='background-image: url("+msg.addScrapeSketchBook[i*3+j].sketch_spath+")'>"+
                                             "<div class='sketchTheme_hover' style=' cursor: pointer;' onclick='goCanvas("+msg.addScrapeSketchBook[i*3+j].sketch_id+")'>"+
                                                "<div class='hover_inside'>"+
                                                   "<h5><img alt='likeIcon' src='./img/sketch/likeIcon.png'>"+
                                                   sketchLike[(sketch_id)]+""+msg.addScrapeSketchBook[i*3+j].sketch_theme+"</h5>"+ 
                                                "</div>"+
                                             "</div>"+
                                          "</div>"+
                                          "<div style='width: 100%; height: 60px; border: 1px solid black; position: absolute; bottom: 0px;'>"+
                                             "<input type='checkbox' name='chkVal' value='"+msg.addScrapeSketchBook[i*3+j].sketch_id+"'>"+
                                             "<label>"+msg.addScrapeSketchBook[i*3+j].sketch_title+"</label>"+"<label style='float: right;'>"+sketchNickname[(sketch_id)]+"</label><br>"+
                                             /* "<label><a href='#' onclick='return sketchBookModify("+msg.addScrapeSketchBook[i*3+j].sketch_id+")'><img alt='modi' src='img/sketch/modifyIcon.png'>스케치북 수정</a></label>"+ */
                                          "</div>"+
                                       "</div>";
                                          
                  }
                  $(".sketchBookContent").append(sketchBookContainer);
                  //sketchBookContent.appendChild(sketchBookContainer);
                  //    sketchBookContainer.innerHTML = "</div>";
            
               } 
               
               if(msg.addScrapeSketchBook.length%3 !=0){ 
                  var sketchBookContainer = document.createElement('div');
                  sketchBookContainer.className = 'sketchBookContainer';   
                  
                  for(var i = 0; i < msg.addScrapeSketchBook.length%3; i++){                    
                     
                     var sketch_id= msg.addScrapeSketchBook[parseInt(parseInt(msg.addScrapeSketchBook.length/3)*3+i)].sketch_id;
                     
                     
                      //style='background: url('"+msg.addSketchBook[i].sketch_spath+"');"
                     sketchBookContainer.innerHTML +=/*  "<div class='selectTheme'  style='background-image: url(\""+msg.addScrapeSketchBook[parseInt(parseInt(msg.addScrapeSketchBook.length/3)*3+i)].sketch_spath+"\")'>"+
                                             "<div class='sketchTheme_hover' onclick='goCanvas("+msg.addScrapeSketchBook[parseInt(parseInt(msg.addScrapeSketchBook.length/3)*3+i)].sketch_id+")'>"+
                                             "<div class='hover_inside'>"+"<span>"+msg.addScrapeSketchBook[parseInt(parseInt(msg.addScrapeSketchBook.length/3)*3+i)].sketch_title+"</span>"+"<h5>"+"<img alt='likeIcon' src='./img/sketch/likeIcon.png'>"+
                                             sketchLike[(sketch_id)]+"</h5>"+
                                             "<h5>"+msg.addScrapeSketchBook[parseInt(parseInt(msg.addScrapeSketchBook.length/3)*3+i)].sketch_theme+""+sketchNickname[(sketch_id)]+"<h5>"+ 
                                             "</div></div></div>"; */
                                             
                                                                     
                                             "<div style='width: 280px; height: 230px; border: 1px solid gray; display: inline-block; margin: 0 0 0 10px; position: relative;'>"+
                                                "<div class='selectTheme' style='background-image: url("+msg.addScrapeSketchBook[parseInt(parseInt(msg.addScrapeSketchBook.length/3)*3+i)].sketch_spath+")'>"+
                                                   "<div class='sketchTheme_hover' style=' cursor: pointer;' onclick='goCanvas("+msg.addScrapeSketchBook[parseInt(parseInt(msg.addScrapeSketchBook.length/3)*3+i)].sketch_id+")'>"+
                                                      "<div class='hover_inside'>"+
                                                         "<h5><img alt='likeIcon' src='./img/sketch/likeIcon.png'>"+
                                                         sketchLike[(sketch_id)]+""+msg.addScrapeSketchBook[parseInt(parseInt(msg.addScrapeSketchBook.length/3)*3+i)].sketch_theme+"</h5>"+ 
                                                      "</div>"+
                                                   "</div>"+
                                                "</div>"+
                                                "<div style='width: 100%; height: 60px; border: 1px solid black; position: absolute; bottom: 0px;'>"+
                                                   "<input type='checkbox' name='chkVal' value='"+msg.addScrapeSketchBook[parseInt(parseInt(msg.addScrapeSketchBook.length/3)*3+i)].sketch_id+"'>"+
                                                   "<label>"+msg.addScrapeSketchBook[parseInt(parseInt(msg.addScrapeSketchBook.length/3)*3+i)].sketch_title+"</label>"+"<label style='float: right;'>"+sketchNickname[(sketch_id)]+"</label><br>"+
                                                   /* "<label><a href='#' onclick='return sketchBookModify("+msg.addScrapeSketchBook[parseInt(parseInt(msg.addScrapeSketchBook.length/3)*3+i)].sketch_id+")'><img alt='modi' src='img/sketch/modifyIcon.png'>스케치북 수정</a></label>"+ */
                                                "</div>"+
                                             "</div>";
                  }
                  
                  $(".sketchBookContent").append(sketchBookContainer);
                  //sketchBookContent.appendChild(sketchBookContainer); 
               }
               
         }, error : function() {
               alert("실패");
         }
      });
   
   
   }
   
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