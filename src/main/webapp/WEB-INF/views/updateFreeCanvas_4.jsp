<%@page import="happy.land.people.dto.LPTextDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<LPTextDto> list = (List<LPTextDto>)request.getAttribute("textList");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레이아웃 4번 수정 페이지</title>
<!-- tui-editor -->
<link rel="stylesheet" href="https://uicdn.toast.com/tui-editor/latest/tui-editor.css"></link>
<link rel="stylesheet" href="https://uicdn.toast.com/tui-editor/latest/tui-editor-contents.css"></link>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.33.0/codemirror.css"></link>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.12.0/styles/github.min.css"></link>
<script src="https://uicdn.toast.com/tui-editor/latest/tui-editor-Editor-full.js"></script>
<!-- CSS -->
<link rel="stylesheet" href="css/freeCanvasLayout.css">
<!-- jQuery -->
<script type="text/javascript" src="./js/jquery-3.3.1.js"></script>
<!-- Booklet  -->
<script src="./js/jquery-ui.js"></script>
<script src="./js/jquery.easing.1.3.js"></script>
<script src="./js/jquery.booklet.latest.min.js"></script>
<link href="./css/jquery.booklet.latest.css" type="text/css" rel="stylesheet" media="screen, projection, tv" />
<script src="./js/min/plugins.min.js"></script>
<script src="./js/min/main.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<!-- js -->
<script src="./js/freeCanvas/freeCanvas.js" defer="defer"></script>
</head>
<body>
	<form method="post" enctype="multipart/form-data" name="frm" id="frm">
	<div id="mybook">
		<!-- 왼쪽 -->
		<div id="Left-Side4">
			<div id="IMG41" style="background-image: url('<%=list.get(0).getImg_spath()%>')">
			<label for="C_IMG41"><img src="./img/folder.png"></label> 
			<input id="C_IMG41" class="file" name="file" type="file" multiple="multiple" style="display: none;">
			</div>
			<input type="hidden" name="list[0].img_spath" class="img_spath0" value="<%=list.get(0).getImg_spath()%>">
			<input type="hidden" name="list[0].text_no" value="0"> 
		</div>

		<!-- 오른쪽 -->
		<div id="Right-Side4">
			<div id="TXT41">
				<textarea style="width: 100%; height: 100%; resize: none;"><%=list.get(1).getText_content() %></textarea>
			</div>
			<input type="hidden" name="list[1].text_content" class="text_content0" value="<%=list.get(1).getText_content() %>">
			<input type="hidden" name="list[1].text_no" value="1"> 
		</div>
	</div>
	</form>

	<div id="insert-container" onclick="insert()">
		<img id="insert" src="./img/check.png">
	</div>
</body>
</html> 