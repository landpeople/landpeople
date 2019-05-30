<%@page import="java.util.Map"%>
<%@page import="happy.land.people.dto.LPSketchbookDto"%>
<%@page import="java.util.List"%>
<%@page import="happy.land.people.dto.SketchPagingDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	SketchPagingDto pagingDto = (SketchPagingDto)request.getAttribute("pagingDto");
	List<LPSketchbookDto> sketchList = (List<LPSketchbookDto>)request.getAttribute("sketchBook");
	Map<String,Integer> sketchLike = ( Map<String,Integer> )request.getAttribute("sketchLike");
	Map<String,Integer> sketchLikes = ( Map<String,Integer> )request.getAttribute("sketchLike");
	Map<String, String> sketchNickname = (Map<String, String>)request.getAttribute("sketchNickname");
	String type = (String)request.getAttribute("type");
%>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>테마별 스케치북 조회 페이지</title>
</head>

<script src="./js/jquery-3.3.1.js"></script>
<script src="./js/sketch/sketchbook.js"></script>
<link rel="stylesheet" href="./css/lp-style.css">
<link rel="stylesheet" href="./css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>







	<body>
	${pagingDto}
	${sketchBook}
	${pagingLikeDto}
<!--젤로 레이아웃- 전체 영역 감싸는 div-->
	<div class="main-wrapper">
		<%@include file="../common/Sidebar.jsp"%>
		<div class="content-wrapper">
			
			<!-- 메인 컨텐츠   -->
			<div class="lpcontents">
				<div class="content">
					<div class="sketchBookContent">
					
					<% 
						for(int i =0; i < sketchList.size()/3 ; i++ ) { 
					%>
						<div class="sketchBookContainer">
					
					<% 
						for(int j = 0 ; j <  3 ; j++){ 
						String sketch_id = sketchList.get(i*3+j).getSketch_id();
					%>
							<div class="selectTheme" style="background-image: url('<%=sketchList.get(i*3+j).getSketch_spath()%>')">
								<div class="sketchTheme_hover" onclick="location.href='./kim.do?sketch_id=<%=sketchList.get(i*3+j).getSketch_id()%>'"><!-- onclick="sketchSelectTheme('나홀로')" -->
									<div class="hover_inside">
										<span><%=sketchList.get(i*3+j).getSketch_title()%></span>
										<h5><img alt="likeIcon" src="./img/sketch/likeIcon.png"> 
										<%=sketchLike.get(sketch_id)%> <%=type%> <%=sketchNickname.get(sketch_id)%></h5>
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
						if(sketchList.size()%3 !=0){ 
					%>
						<div class="sketchBookContainer">
					
					<%  for(int i = 0 ; i < sketchList.size()%3 ; i++){
						String sketch_id = sketchList.get((sketchList.size()/3)*3+i).getSketch_id();
					%>
							<div class="selectTheme" style="background-image: url('<%=sketchList.get((sketchList.size()/3)*3+i).getSketch_spath()%>')">
								<div class="sketchTheme_hover" onclick="location.href='./kim.do?sketch_id=<%=sketchList.get((sketchList.size()/3)*3+i).getSketch_id()%>'">
									<div class="hover_inside">
										<span><%=sketchList.get((sketchList.size()/3)*3+i).getSketch_title()%></span>
										<h5><img alt="likeIcon" src="./img/sketch/likeIcon.png"> 
										<%=sketchLike.get(sketch_id)%> <%=type%> <%=sketchNickname.get(sketch_id)%> </h5>
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
					
					
					
					
					</div>	
					
				</div>
			</div>
			<!-- </div> 여기까지 메인 컨텐츠  -->
			<div class="footer">landpeople</div>
		</div>
	</div>
	<script type="text/javascript">
	// 무한 스크롤 적용된 스케치북 조회
	var pageCnt = <%=pagingDto.getNowPageNo()%>
	
	$(window).scroll(function(){
		if($(window).scrollTop() >= $(document).height()-$(window).height()){
			if(pageCnt >= <%=pagingDto.getEndPageNo()%>){
				alert("마지막페이지 입니다.");
			}
			else{
				pageCnt++;			
				getSketchBook(pageCnt);		
			}
		}
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
					

					alert(sketchNicknames);
					//alert(sketchLikes);
					//var content =  document.getElementsByClassName("content")[0];
					var sketchBookContent= document.getElementsByClassName("sketchBookContent")[0];
					
					 
					for(var i = 0 ; i < parseInt(msg.addSketchBook.length/3) ; i++){
						
						var sketchBookContainer = document.createElement('div');
						sketchBookContainer.className = 'sketchBookContainer';	 //style='background: url('"+msg.addSketchBook[i].sketch_spath+"');"
						
						for(var j = 0; j < 3; j++){
						
						 var sketch_id=	msg.addSketchBook[i*3+j].sketch_id;
						 //alert(sketch_id);
							
						sketchBookContainer.innerHTML += "<div class='selectTheme' style='background-image: url("+msg.addSketchBook[i*3+j].sketch_spath+")'>"+
														"<div class='sketchTheme_hover' onclick='goCanvas("+msg.addSketchBook[i*3+j].sketch_id+")'>"+
														"<div class='hover_inside'>"+"<span>"+msg.addSketchBook[i*3+j].sketch_title+"</span>"+"<h5>"+"<img alt='likeIcon' src='./img/sketch/likeIcon.png'>"+
														sketchLikes[(sketch_id)]+"</h5>"+
														"<h5>"+type+"</h5>"+"<h5>"+sketchNicknames[(sketch_id)]+"<h5>"+
														"</div></div></div>"; 
						}
						$(".sketchBookContent").append(sketchBookContainer);
						//sketchBookContent.appendChild(sketchBookContainer);
						//		sketchBookContainer.innerHTML = "</div>";
				
					} 
					
					if(msg.addSketchBook.length%3 !=0){ 
						var sketchBookContainer = document.createElement('div');
						sketchBookContainer.className = 'sketchBookContainer';	
						
						for(var i = 0; i < msg.addSketchBook.length%3; i++){							
							
							var sketch_id= msg.addSketchBook[parseInt(parseInt(msg.addSketchBook.length/3)*3+i)].sketch_id;
							
							
							 //style='background: url('"+msg.addSketchBook[i].sketch_spath+"');"
							sketchBookContainer.innerHTML += "<div class='selectTheme'  style='background-image: url(\""+msg.addSketchBook[parseInt(parseInt(msg.addSketchBook.length/3)*3+i)].sketch_spath+"\")'>"+
															"<div class='sketchTheme_hover' onclick='goCanvas("+msg.addSketchBook[parseInt(parseInt(msg.addSketchBook.length/3)*3+i)].sketch_id+")'>"+
															"<div class='hover_inside'>"+"<span>"+msg.addSketchBook[parseInt(parseInt(msg.addSketchBook.length/3)*3+i)].sketch_title+"</span>"+"<h5>"+"<img alt='likeIcon' src='./img/sketch/likeIcon.png'>"+
															sketchLikes[(sketch_id)]+"</h5>"+
															"<h5>"+type+"</h5>"+"<h5>"+sketchNicknames[(sketch_id)]+"<h5>"+
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