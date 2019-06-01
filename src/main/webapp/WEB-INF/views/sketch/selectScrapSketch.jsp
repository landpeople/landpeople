<%@page import="java.util.Map"%>
<%@page import="happy.land.people.dto.LPSketchbookDto"%>
<%@page import="java.util.List"%>
<%@page import="happy.land.people.dto.SketchPagingDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	SketchPagingDto pagingDto = (SketchPagingDto)request.getAttribute("pagingDto");
	List<LPSketchbookDto> myScrapeList = (List<LPSketchbookDto>)request.getAttribute("myScrapeList");
	Map<String,Integer> sketchLike = ( Map<String,Integer> )request.getAttribute("sketchLike");
	Map<String, String> scrapeSketchNickname = (Map<String, String>)request.getAttribute("scrapeSketchNickname");
	
%>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스크랩 스케치북 조회 페이지</title>
</head>

<script src="./js/jquery-3.3.1.js"></script>
<script src="./js/sketch/sketchbook.js"></script>
<link rel="stylesheet" href="./css/lp-style.css">
<link rel="stylesheet" href="./css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>







	<body>
	<%-- ${pagingDto}
	${myScrapeList}
	${sketchLike}
	${scrapeSketchNickname} --%>
<!--젤로 레이아웃- 전체 영역 감싸는 div-->
	<div class="main-wrapper">
		<%@include file="../common/Sidebar.jsp"%>
		<div class="content-wrapper">
			
			<!-- 메인 컨텐츠   -->
			<div class="lpcontents">
				<div class="content" style="overflow-x: hidden;">
					<!-- <div class="sketchBookContent"> -->
					
					<% 
						for(int i =0; i < myScrapeList.size()/3 ; i++ ) { 
					%>
						<div class="sketchBookContainer">
					
					<% 
						for(int j = 0 ; j <  3 ; j++){ 
						String sketch_id = myScrapeList.get(i*3+j).getSketch_id();
					%>
							<div class="selectTheme" style="background-image: url('<%=myScrapeList.get(i*3+j).getSketch_spath()%>')">
								<div class="sketchTheme_hover" onclick="location.href='./kim.do?sketch_id=<%=myScrapeList.get(i*3+j).getSketch_id()%>'"><!-- onclick="sketchSelectTheme('나홀로')" -->
									<div class="hover_inside">
										<span><%=myScrapeList.get(i*3+j).getSketch_title()%></span>
										<h5><img alt="likeIcon" src="./img/sketch/likeIcon.png"> 
										<%=sketchLike.get(sketch_id)%> <%=myScrapeList.get(i*3+j).getSketch_theme()%> <%=scrapeSketchNickname.get(sketch_id)%></h5>
									</div>
								</div>
								
							</div>
							
					<%
						}
					%>
						</div>
					
					<%
						}
					%>
					
					
					<% 
						if(myScrapeList.size()%3 !=0){ 
					%>
						<div class="sketchBookContainer">
					
					<%  for(int i = 0 ; i < myScrapeList.size()%3 ; i++){
						String sketch_id = myScrapeList.get((myScrapeList.size()/3)*3+i).getSketch_id();
					%>
							<div class="selectTheme" style="background-image: url('<%=myScrapeList.get((myScrapeList.size()/3)*3+i).getSketch_spath()%>')">
								<div class="sketchTheme_hover" onclick="location.href='./kim.do?sketch_id=<%=myScrapeList.get((myScrapeList.size()/3)*3+i).getSketch_id()%>'">
									<div class="hover_inside">
										<span><%=myScrapeList.get((myScrapeList.size()/3)*3+i).getSketch_title()%></span>
										<h5><img alt="likeIcon" src="./img/sketch/likeIcon.png"> 
										<%=sketchLike.get(sketch_id)%> <%=myScrapeList.get((myScrapeList.size()/3)*3+i).getSketch_theme()%> <%=scrapeSketchNickname.get(sketch_id)%> </h5>
									</div>
								</div>
								
							</div>
							
					<%
						}
					%>
						</div>
					
					<%
						}
					%>
					
					
					
					
					<!-- </div>	 -->
				<button id="infinityScroll" style="width: 100%;">더보기</button>	
				</div>
			</div>
			<!-- </div> 여기까지 메인 컨텐츠  -->
			<div class="footer">landpeople</div>
		</div>
	</div>
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
					

					//alert(sketchNickname);
					//alert(sketchLikes);
					//var content =  document.getElementsByClassName("content")[0];
					var sketchBookContent= document.getElementsByClassName("sketchBookContent")[0];
					var sketchBookContent = document.createElement('div');
						sketchBookContent.className = 'sketchBookContent'; 
					
						
						
					for(var i = 0 ; i < parseInt(msg.addScrapeSketchBook.length/3) ; i++){
						
						var sketchBookContainer = document.createElement('div');
						sketchBookContainer.className = 'sketchBookContainer';	 //style='background: url('"+msg.addSketchBook[i].sketch_spath+"');"
						
						for(var j = 0; j < 3; j++){
						
						 var sketch_id=	msg.addScrapeSketchBook[i*3+j].sketch_id;
						 //alert(sketch_id);
							
						sketchBookContainer.innerHTML += "<div class='selectTheme' style='background-image: url("+msg.addScrapeSketchBook[i*3+j].sketch_spath+")'>"+
														"<div class='sketchTheme_hover' onclick='goCanvas("+msg.addScrapeSketchBook[i*3+j].sketch_id+")'>"+
														"<div class='hover_inside'>"+"<span>"+msg.addScrapeSketchBook[i*3+j].sketch_title+"</span>"+"<h5>"+"<img alt='likeIcon' src='./img/sketch/likeIcon.png'>"+
														sketchLike[(sketch_id)]+"</h5>"+
														"<h5>"+msg.addScrapeSketchBook[i*3+j].sketch_theme+""+sketchNickname[(sketch_id)]+"<h5>"+ 
														"</div></div></div>"; 
						}
						$(".sketchBookContent").append(sketchBookContainer);
						//sketchBookContent.appendChild(sketchBookContainer);
						//		sketchBookContainer.innerHTML = "</div>";
				
					} 
					
					if(msg.addScrapeSketchBook.length%3 !=0){ 
						var sketchBookContainer = document.createElement('div');
						sketchBookContainer.className = 'sketchBookContainer';	
						
						for(var i = 0; i < msg.addScrapeSketchBook.length%3; i++){							
							
							var sketch_id= msg.addScrapeSketchBook[parseInt(parseInt(msg.addScrapeSketchBook.length/3)*3+i)].sketch_id;
							
							
							 //style='background: url('"+msg.addSketchBook[i].sketch_spath+"');"
							sketchBookContainer.innerHTML += "<div class='selectTheme'  style='background-image: url(\""+msg.addScrapeSketchBook[parseInt(parseInt(msg.addScrapeSketchBook.length/3)*3+i)].sketch_spath+"\")'>"+
															"<div class='sketchTheme_hover' onclick='goCanvas("+msg.addScrapeSketchBook[parseInt(parseInt(msg.addScrapeSketchBook.length/3)*3+i)].sketch_id+")'>"+
															"<div class='hover_inside'>"+"<span>"+msg.addScrapeSketchBook[parseInt(parseInt(msg.addScrapeSketchBook.length/3)*3+i)].sketch_title+"</span>"+"<h5>"+"<img alt='likeIcon' src='./img/sketch/likeIcon.png'>"+
															sketchLike[(sketch_id)]+"</h5>"+
															"<h5>"+msg.addScrapeSketchBook[parseInt(parseInt(msg.addScrapeSketchBook.length/3)*3+i)].sketch_theme+""+sketchNickname[(sketch_id)]+"<h5>"+ 
															"</div></div></div>";												
						}
						
						$(".sketchBookContent").append(sketchBookContainer);
						//sketchBookContent.appendChild(sketchBookContainer);	
					}
						
					
					
			}, error : function() {
					alert("실패");
			}
		});
	
	
	}
	
	
	
	</script>
	
	</body>

</html>