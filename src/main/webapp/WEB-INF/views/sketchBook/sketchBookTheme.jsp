<%@page import="happy.land.people.dto.LPSketchbookDto"%>
<%@page import="java.util.List"%>
<%@page import="happy.land.people.dto.SketchPagingDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	SketchPagingDto pagingDto = (SketchPagingDto)request.getAttribute("pagingDto");
	List<LPSketchbookDto> sketchList = (List<LPSketchbookDto>)request.getAttribute("sketchBook");
%>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>테마별 스케치북 조회 페이지</title>
</head>

<script src="./js/jquery-3.3.1.js"></script>
<script src="./js/sketchbook/sketchbook.js"></script>
<link rel="stylesheet" href="./css/lp-style.css">
<link rel="stylesheet" href="./css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>







	<body>
	${pagingDto}
	${sketchBook}
<!--젤로 레이아웃- 전체 영역 감싸는 div-->
	<div class="main-wrapper">
		<%@include file="../common/Sidebar.jsp"%>
		<div class="content-wrapper">
			
			<!-- 메인 컨텐츠   -->
			<div class="lpcontents">
				<div class="content">
					<% for(int i = 0 ; i <  sketchList.size() ; i++){ %>
					
						<div><a href="./kim.do?sketch_id=<%=sketchList.get(i).getSketch_id()%>"><%=sketchList.get(i).getSketch_id()%> &nbsp <%=sketchList.get(i).getSketch_title()%> &nbsp <%=sketchList.get(i).getSketch_spath()%></a></div>
					<%}%>
					
				</div>
			</div>
			<!-- </div> 여기까지 메인 컨텐츠  -->
			<div class="footer">landpeople</div>
		</div>
	</div>
	<script type="text/javascript">
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
		
			$.ajax({
				url: "sketchBookPaging.do",
				type: "get",
				data: {"pageNo": pageNo , "type" : "나홀로"}, 
				dataTypes: "json",
				success: function(msg){
					alert(msg.addSketchBook);		
					var content =  document.getElementsByClassName("content")[0];
					for(var i = 0 ; i < msg.addSketchBook.length; i++){
						
						var div = document.createElement('div');
						div.innerHTML = "<a href='./kim.do?sketch_id="+msg.addSketchBook[i].sketch_id+"'>"+
										msg.addSketchBook[i].sketch_id+
										msg.addSketchBook[i].sketch_title+
										msg.addSketchBook[i].sketch_spath+"</a>";
									
						content.appendChild(div);
					}
				}, error : function() {
					alert("실패");
				}
			});
		
	}
	
	
	
	</script>
	
	</body>

</html>