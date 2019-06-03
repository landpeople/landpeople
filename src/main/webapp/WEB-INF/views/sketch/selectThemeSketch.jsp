<%@page import="java.util.Map"%>
<%@page import="happy.land.people.dto.LPSketchbookDto"%>
<%@page import="java.util.List"%>
<%@page import="happy.land.people.dto.SketchPagingDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<html>
<head>
<meta charset="UTF-8">
<title>테마별 스케치북 조회 페이지</title>
</head>

<script src="./js/jquery-3.3.1.js"></script>
<link rel="stylesheet" href="./css/lp-style.css">
<link rel="stylesheet" href="./css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>







	<body>
<%-- 	${pagingDto}
	${sketchBook}
	${pagingLikeDto}
	${maxLikeSketchBook} --%>
<!--젤로 레이아웃- 전체 영역 감싸는 div-->
	<div class="main-wrapper">
		<%@include file="../common/Sidebar.jsp"%>
		<div class="content-wrapper">
			
			<!-- 메인 컨텐츠   -->
			<div class="lpcontents">
				<div class="content" style="overflow-x: hidden;">
				<!-- 	<div class="sketchBookContent"> -->
					
					<!-- 좋아요 카운트 top 3 스케치북  -->
					
					<% 
						if(maxLikeSketchBook.size() == 0){
					%>
						<!--스케치북 3개 담는 div  -->
						<div class="sketchBookContainer">
							<div class="maxLikeSketchBook" style="width:280px; height: 230px; margin:auto; border: 1px solid red;  background-image: url('')">좋아요한 스케치북이 없습니다</div>
						</div>
						
					<%
						}
					%>	
					
					
					
					
					<% 
						for(int i =0; i < maxLikeSketchBook.size()/3; i++){
					%>
						<!--스케치북 3개 담는 div  -->
						<div class="sketchBookContainer">
						<%
							for(int j = 0; j < 3; j++){
							String sketch_id = maxLikeSketchBook.get(i*3+j).getSketch_id();
						%>
							<%-- <div class="selectTheme" style="background-image: url('<%=maxLikeSketchBook.get(i*3+j).getSketch_spath()%>')">
									<div class="sketchTheme_hover" onclick="location.href='./kim.do?sketch_id=<%=maxLikeSketchBook.get(i*3+j).getSketch_id()%>'">
										<div class="hover_inside">
											<span><%=maxLikeSketchBook.get(i*3+j).getSketch_title()%></span>
											<h5><img alt="likeIcon" src="./img/sketch/likeIcon.png"> 
											<%=maxLike.get(sketch_id)%> <%=type%> <%=likeSketchNickname.get(sketch_id)%></h5>
										</div>
									</div>
									
							</div> --%>
							
							
							<!--스케치북 1개 담는 div  -->
								<div style="width: 280px; height: 230px; border: 1px solid gray; display: inline-block; margin: 0 0 0 10px; position: relative;">
									<div class="selectTheme" style="background-image: url('<%=maxLikeSketchBook.get(i*3+j).getSketch_spath()%>');">
										<div class="sketchTheme_hover" style=" cursor: pointer;" onclick="location.href='./kim.do?sketch_id=<%=maxLikeSketchBook.get(i*3+j).getSketch_id()%>'">
											<div class="hover_inside">
												<h5><img alt="likeIcon" src="./img/sketch/likeIcon.png">
												<%=maxLike.get(sketch_id) %> <%=type%> </h5>
											</div>
										</div>
									</div>
									<div style="width: 100%; height: 60px; border: 1px solid black; position: absolute; bottom: 0px;">
										<%-- <input type="checkbox" name="chkVal" value="<%=maxLikeSketchBook.get(i*3+j).getSketch_id()%>"> --%>
										<label><%=maxLikeSketchBook.get(i*3+j).getSketch_title()%></label><label style="float: right;"><%=likeSketchNickname.get(sketch_id)%></label><br>
									<%-- 	<label><a href="#" onclick="return sketchBookModify('<%=maxLikeSketchBook.get(i*3+j).getSketch_id()%>')"><img alt="modi" src="img/sketch/modifyIcon.png">스케치북 수정</a></label> --%>
									</div>		 
								</div><!--스케치북 1개 담는 div  -->
							
							
							
							
							
						<%
							}
						%>
						</div>
						
					<%
						}
					%>	
					
											
					
					<%
						if(maxLikeSketchBook.size()%3 !=0){
					%>
						<!--스케치북 3개 담는 div  -->
						<div class="sketchBookContainer">
					
						<%
							for(int i = 0 ; i < maxLikeSketchBook.size()%3 ; i++){
							String sketch_id = maxLikeSketchBook.get((maxLikeSketchBook.size()/3)*3+i).getSketch_id();	
						%>
								<%-- <div class="selectTheme" style="background-image: url('<%=maxLikeSketchBook.get((maxLikeSketchBook.size()/3)*3+i).getSketch_spath()%>')">
									<div class="sketchTheme_hover" onclick="location.href='./kim.do?sketch_id=<%=maxLikeSketchBook.get((maxLikeSketchBook.size()/3)*3+i).getSketch_id()%>'">
										<div class="hover_inside">
											<span><%=maxLikeSketchBook.get((maxLikeSketchBook.size()/3)*3+i).getSketch_title()%></span>
											<h5><img alt="likeIcon" src="./img/sketch/likeIcon.png"> 
											<%=maxLike.get(sketch_id)%> <%=type%> <%=likeSketchNickname.get(sketch_id)%></h5>
										</div>
									</div>
									
								</div> --%>
						
						
								<!--스케치북 1개 담는 div  -->
								<div style="width: 280px; height: 230px; border: 1px solid gray; display: inline-block; margin: 0 0 0 10px; position: relative;">
									<div class="selectTheme" style="background-image: url('<%=maxLikeSketchBook.get((maxLikeSketchBook.size()/3)*3+i).getSketch_spath()%>');">
										<div class="sketchTheme_hover" style=" cursor: pointer;" onclick="location.href='./kim.do?sketch_id=<%=maxLikeSketchBook.get((maxLikeSketchBook.size()/3)*3+i).getSketch_id()%>'">
											<div class="hover_inside">
												<h5><img alt="likeIcon" src="./img/sketch/likeIcon.png">
												<%=maxLike.get(sketch_id) %> <%=type%> </h5>
											</div>
										</div>
									</div>
									<div style="width: 100%; height: 60px; border: 1px solid black; position: absolute; bottom: 0px;">
									<%-- 	<input type="checkbox" name="chkVal" value="<%=maxLikeSketchBook.get((maxLikeSketchBook.size()/3)*3+i).getSketch_id()%>"> --%>
										<label><%=maxLikeSketchBook.get((maxLikeSketchBook.size()/3)*3+i).getSketch_title()%></label><label style="float: right;"><%=likeSketchNickname.get(sketch_id)%></label><br>
										<%-- <label><a href="#" onclick="return sketchBookModify('<%=maxLikeSketchBook.get((maxLikeSketchBook.size()/3)*3+i).getSketch_id()%>')"><img alt="modi" src="img/sketch/modifyIcon.png">스케치북 수정</a></label> --%>
									</div>		 
								</div><!--스케치북 1개 담는 div  -->
						
						
						
						
						
						<%
							}
						%>
						</div><!--스케치북 3개 담는 div  -->
						
					<%
						}
					%>	
					
					
					
					
					
					
					
					
						
						
					<!-- 일반 테마별 스케치북 조회 3*2 -->
					<% 
						for(int i =0; i < sketchList.size()/3 ; i++ ) { 
					%>
						<div class="sketchBookContainer">
					
						<% 
							for(int j = 0 ; j <  3 ; j++){ 
							String sketch_id = sketchList.get(i*3+j).getSketch_id();
						%>
								<%-- <div class="selectTheme" style="background-image: url('<%=sketchList.get(i*3+j).getSketch_spath()%>')">
									<div class="sketchTheme_hover" onclick="location.href='./kim.do?sketch_id=<%=sketchList.get(i*3+j).getSketch_id()%>'"><!-- onclick="sketchSelectTheme('나홀로')" -->
										<div class="hover_inside">
											<span><%=sketchList.get(i*3+j).getSketch_title()%></span>
											<h5><img alt="likeIcon" src="./img/sketch/likeIcon.png"> 
											<%=sketchLike.get(sketch_id)%> <%=type%> <%=sketchNickname.get(sketch_id)%></h5>
										</div>
									</div>
									
								</div> --%>
							
							
								<!--스케치북 1개 담는 div  -->
								<div style="width: 280px; height: 230px; border: 1px solid gray; display: inline-block; margin: 0 0 0 10px; position: relative;">
									<div class="selectTheme" style="background-image: url('<%=sketchList.get(i*3+j).getSketch_spath()%>');">
										<div class="sketchTheme_hover" style=" cursor: pointer;" onclick="location.href='./kim.do?sketch_id=<%=sketchList.get(i*3+j).getSketch_id()%>'">
											<div class="hover_inside">
												<h5><img alt="likeIcon" src="./img/sketch/likeIcon.png">
												<%=sketchLike.get(sketch_id) %> <%=type%> </h5>
											</div>
										</div>
									</div>
									<div style="width: 100%; height: 60px; border: 1px solid black; position: absolute; bottom: 0px;">
									<%-- 	<input type="checkbox" name="chkVal" value="<%=maxLikeSketchBook.get((maxLikeSketchBook.size()/3)*3+i).getSketch_id()%>"> --%>
										<label><%=sketchList.get(i*3+j).getSketch_title()%></label><label style="float: right;"><%=sketchNickname.get(sketch_id)%></label><br>
										<%-- <label><a href="#" onclick="return sketchBookModify('<%=maxLikeSketchBook.get((maxLikeSketchBook.size()/3)*3+i).getSketch_id()%>')"><img alt="modi" src="img/sketch/modifyIcon.png">스케치북 수정</a></label> --%>
									</div>		 
								</div><!--스케치북 1개 담는 div  -->
							
							
							
							
							
							
								
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
								<%-- <div class="selectTheme" style="background-image: url('<%=sketchList.get((sketchList.size()/3)*3+i).getSketch_spath()%>')">
									<div class="sketchTheme_hover" onclick="location.href='./kim.do?sketch_id=<%=sketchList.get((sketchList.size()/3)*3+i).getSketch_id()%>'">
										<div class="hover_inside">
											<span><%=sketchList.get((sketchList.size()/3)*3+i).getSketch_title()%></span>
											<h5><img alt="likeIcon" src="./img/sketch/likeIcon.png"> 
											<%=sketchLike.get(sketch_id)%> <%=type%> <%=sketchNickname.get(sketch_id)%> </h5>
										</div>
									</div>
									
								</div> --%>
							
							
								<!--스케치북 1개 담는 div  -->
								<div style="width: 280px; height: 230px; border: 1px solid gray; display: inline-block; margin: 0 0 0 10px; position: relative;">
									<div class="selectTheme" style="background-image: url('<%=sketchList.get((sketchList.size()/3)*3+i).getSketch_spath()%>');">
										<div class="sketchTheme_hover" style=" cursor: pointer;" onclick="location.href='./kim.do?sketch_id=<%=sketchList.get((sketchList.size()/3)*3+i).getSketch_id()%>'">
											<div class="hover_inside">
												<h5><img alt="likeIcon" src="./img/sketch/likeIcon.png">
												<%=sketchLike.get(sketch_id) %> <%=type%> </h5>
											</div>
										</div>
									</div>
									<div style="width: 100%; height: 60px; border: 1px solid black; position: absolute; bottom: 0px;">
									<%-- 	<input type="checkbox" name="chkVal" value="<%=maxLikeSketchBook.get((maxLikeSketchBook.size()/3)*3+i).getSketch_id()%>"> --%>
										<label><%=sketchList.get((sketchList.size()/3)*3+i).getSketch_title()%></label><label style="float: right;"><%=sketchNickname.get(sketch_id)%></label><br>
										<%-- <label><a href="#" onclick="return sketchBookModify('<%=maxLikeSketchBook.get((maxLikeSketchBook.size()/3)*3+i).getSketch_id()%>')"><img alt="modi" src="img/sketch/modifyIcon.png">스케치북 수정</a></label> --%>
									</div>		 
								</div><!--스케치북 1개 담는 div  -->
							
							
							
								
						<%
							}
						%>
						</div>
					
					<%
						}
					%>
					
					
					
					
				<!-- 	</div>	 -->
				<%
					if(sketchList.size()%6 == 0){ 
				%>
					<button id="infinityScroll" style="width: 100%;">더보기</button>
				<%
					}
				%>	
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
						
						 var sketch_id=	msg.addSketchBook[i*3+j].sketch_id;
						 //alert(sketch_id);
							
						sketchBookContainer.innerHTML +=/*  "<div class='selectTheme' style='background-image: url("+msg.addSketchBook[i*3+j].sketch_spath+")'>"+
														"<div class='sketchTheme_hover' onclick='goCanvas("+msg.addSketchBook[i*3+j].sketch_id+")'>"+
														"<div class='hover_inside'>"+"<span>"+msg.addSketchBook[i*3+j].sketch_title+"</span>"+"<h5>"+"<img alt='likeIcon' src='./img/sketch/likeIcon.png'>"+
														sketchLikes[(sketch_id)]+"</h5>"+
														"<h5>"+type+"</h5>"+"<h5>"+sketchNicknames[(sketch_id)]+"<h5>"+
														"</div></div></div>";  */
						
														
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
																/* "<input type='checkbox' name='chkVal' value='"+msg.addSketchBook[i*3+j].sketch_id+"'>"+ */
																"<label>"+msg.addSketchBook[i*3+j].sketch_title+"</label>"+"<label style='float: right;'>"+sketchNicknames[(sketch_id)]+"</label><br>"+
																/* "<label><a href='#' onclick='return sketchBookModify("+msg.addSketchBook[i*3+j].sketch_id+")'><img alt='modi' src='img/sketch/modifyIcon.png'>스케치북 수정</a></label>"+ */
													 		"</div>"+
														"</div>";
														
						
						
						
						}
						//$(".sketchBookContent").append(sketchBookContainer);
						content.appendChild(sketchBookContainer);
						//sketchBookContent.appendChild(sketchBookContainer);
						//		sketchBookContainer.innerHTML = "</div>";
				
					} 
					
					if(msg.addSketchBook.length%3 !=0){ 
						var sketchBookContainer = document.createElement('div');
						sketchBookContainer.className = 'sketchBookContainer';	
						
						for(var i = 0; i < msg.addSketchBook.length%3; i++){							
							
							var sketch_id= msg.addSketchBook[parseInt(parseInt(msg.addSketchBook.length/3)*3+i)].sketch_id;
							
							
							 //style='background: url('"+msg.addSketchBook[i].sketch_spath+"');"
							sketchBookContainer.innerHTML += /* "<div class='selectTheme'  style='background-image: url(\""+msg.addSketchBook[parseInt(parseInt(msg.addSketchBook.length/3)*3+i)].sketch_spath+"\")'>"+
															"<div class='sketchTheme_hover' onclick='goCanvas("+msg.addSketchBook[parseInt(parseInt(msg.addSketchBook.length/3)*3+i)].sketch_id+")'>"+
															"<div class='hover_inside'>"+"<span>"+msg.addSketchBook[parseInt(parseInt(msg.addSketchBook.length/3)*3+i)].sketch_title+"</span>"+"<h5>"+"<img alt='likeIcon' src='./img/sketch/likeIcon.png'>"+
															sketchLikes[(sketch_id)]+"</h5>"+
															"<h5>"+type+"</h5>"+"<h5>"+sketchNicknames[(sketch_id)]+"<h5>"+
															"</div></div></div>"; */												
						
						
														"<div style='width: 280px; height: 230px; border: 1px solid gray; display: inline-block; margin: 0 0 0 10px; position: relative;'>"+
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
						content.appendChild(sketchBookContainer);
						//$(".sketchBookContent").append(sketchBookContainer);
						//sketchBookContent.appendChild(sketchBookContainer);	
					}
						
					
					
			}, error : function() {
					alert("실패");
			}
		});
	
	
	}
	
	
	// 테마별, 작성, 스크랩 스케치북 조회 무한스크롤 후 캔버스 조회 페이지로 이동
	function goCanvas(sketch_id) {
		//alert(sketch_id);
		location.href="./kim.do?sketch_id="+sketch_id;
	}
	
	
	
	
	
	</script>
	
	</body>

</html>