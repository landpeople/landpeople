<%@page import="happy.land.people.dto.LPTextDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레이아웃 2번 수정 페이지</title>
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
<%
	List<LPTextDto> list = (List<LPTextDto>)request.getAttribute("textList");
%>
</head>
<body>
<div class="main-wrapper">
<%@include file="./common/Sidebar.jsp" %>
<div class="content-wrapper">

	<!-- 메인 컨텐츠   -->
	<div class="lpcontents">
	<div class="content">
		<div class="head-title">
			<div class="back" onclick="javascript:history.back(-1)"><i class="fas fa-reply fa-3x"></i></div>
			<div class="title">[스케치북 제목이 들어갑니다.]</div>
			<div class="imageDown"><i class="far fa-file-image fa-4x"></i></div>
			<div class="excelDown"><i class="far fa-file-excel fa-4x"></i></div>
		</div>
		
		<div class="article-canvasContent">
	<form method="post" enctype="multipart/form-data" name="frm" id="frm">
	<div id="mybook">
		<!-- 왼쪽  -->
		<div id="Left-Side2">
			<div id="LS_TContainer2">
				<div id="TXT21">
					<textarea style="width: 100%; height: 100%; resize: none;"><%=list.get(0).getText_content() %></textarea>
				</div>
				<input type="hidden" name="list[0].text_content" class="text_content0" value="<%=list.get(0).getText_content()%>">
				<input type="hidden" name="list[0].text_no" value="0"> 
			</div>
			<div id="LS_IContainer2">
				<div id="IMG21" style="background-image: url('<%=list.get(1).getImg_spath()%>')">
					<label for="C_IMG21"><img src="./img/folder.png"></label> 
					<input id="C_IMG21" class="file" name="file" type="file" multiple="multiple" style="display: none;">
				</div>
				<input type="hidden" name="list[1].img_spath" class="img_spath0" value="<%=list.get(1).getImg_spath()%>">
				<input type="hidden" name="list[1].text_no" value="1"> 
				<div id="IMG22" style="background-image: url('<%=list.get(2).getImg_spath()%>')">
					<label for="C_IMG22"><img src="./img/folder.png"></label> 
					<input id="C_IMG22" class="file" name="file" type="file" multiple="multiple" style="display: none;">
				</div>
				<input type="hidden" name="list[2].img_spath" class="img_spath1" value="<%=list.get(2).getImg_spath()%>">
				<input type="hidden" name="list[2].text_no" value="2"> 
				<div id="IMG23" style="background-image: url('<%=list.get(3).getImg_spath()%>')">
					<label for="C_IMG23"><img src="./img/folder.png"></label> 
					<input id="C_IMG23" class="file" name="file" type="file" multiple="multiple" style="display: none;">
				</div>
				<input type="hidden" name="list[3].img_spath" class="img_spath2" value="<%=list.get(3).getImg_spath()%>">
				<input type="hidden" name="list[3].text_no" value="3"> 
			</div>
		</div>

		<!-- 오른쪽 -->
		<div id="Right-Side2">
			<div id="IMG24" style="background-image: url('<%=list.get(4).getImg_spath()%>')">
				<label for="C_IMG24"><img src="./img/folder.png"></label> 
				<input id="C_IMG24" class="file" name="file" type="file" multiple="multiple" style="display: none;">
			</div>
			<input type="hidden" name="list[4].img_spath" class="img_spath3" value="<%=list.get(4).getImg_spath()%>">
			<input type="hidden" name="list[4].text_no" value="4"> 
			<div id="TXT22">
				<textarea style="width: 100%; height: 100%; resize: none;"><%=list.get(5).getText_content()%></textarea>
			</div>
			<input type="hidden" name="list[5].text_content" class="text_content1" value="<%=list.get(5).getText_content()%>">
			<input type="hidden" name="list[5].text_no" value="5"> 
		</div>
		</div>
	</form>
	</div>
	
	<div class="footer-icon">
		<div class="insertIcon" onclick="update()">
			<img id="insert" src="./img/check.png">
		</div>
	</div>
	
	</div>
</div>
	<div class="footer">landpeople</div>
</div>
</div>
</body>
</html> 