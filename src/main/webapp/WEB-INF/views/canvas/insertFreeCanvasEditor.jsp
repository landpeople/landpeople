<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 작성</title>
<!-- css -->
<link rel="stylesheet" href="./css/canvas/freeCanvas-Popup.css">
<!-- ckEditor -->
<script type="text/javascript" src="./ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="./ckeditor/config.js"></script>
<!-- jQuery -->
<script type="text/javascript" src="./js/jquery-3.3.1.js"></script>
<!-- bootstrap -->
<link rel="stylesheet" href="./css/theme/bootstrap.min.css">
</head>
<% String id = (String)request.getParameter("id"); %>
<body>
	<div class="info">
		<div class="infoTxt">글 작성 후 '작성 완료' 버튼을 눌러주세요!</div>
	</div>
	<div class="editorBox">
		<textarea id='editor' rows="20" cols="40"></textarea>
	</div>
	<div class="setTxt">
		<button onclick="closer()" class="btn btn-outline-dark btn-sm">닫기</button>
		<button onclick="setEditor()" class="btn btn-outline-warning btn-sm">작성 완료</button>
	</div>

<script type="text/javascript">
	CKEDITOR.replace('editor');
	
	$(document).ready(function(){
		var text = opener.document.getElementById("<%=id %>").innerHTML;
		var editor = CKEDITOR.instances.editor;
		editor.setData(text);
	});
	
	function setEditor(){
		var data = CKEDITOR.instances.editor.getData();
		opener.document.getElementById("<%=id %>").innerHTML = data;
		self.close();
	}
	
	function closer(){
		close();
	}
</script>
</body>
</html>