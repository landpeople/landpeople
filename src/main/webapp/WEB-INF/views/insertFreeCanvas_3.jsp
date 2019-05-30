<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레이아웃 3번</title>
<!-- 토스트 에디터 파일 가져오기 -->
<link rel="stylesheet" href="https://uicdn.toast.com/tui-editor/latest/tui-editor.css"></link>
<link rel="stylesheet" href="https://uicdn.toast.com/tui-editor/latest/tui-editor-contents.css"></link>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.33.0/codemirror.css"></link>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.12.0/styles/github.min.css"></link>
<script src="https://uicdn.toast.com/tui-editor/latest/tui-editor-Editor-full.js"></script>
<script type="text/javascript" src="./js/jquery-3.3.1.js"></script>
<!-- CSS -->
<link rel="stylesheet" href="css/freeCanvasLayout.css">
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
		<div id="Left-Side3">
			<div id="IMG31">
			<label for="C_IMG31"><img src="./img/folder.png"></label> 
			<input id="C_IMG31" class="file" name="file" type="file" multiple="multiple" style="display: none;">
			</div>
			<input type="hidden" name="list[0].img_spath" class="img_spath0">
			<input type="hidden" name="list[0].text_no" value="0"> 
		</div>
		
		<!-- 오른쪽 -->
		<div id="Right-Side3">
			<div id="RS_TContainer3">
				<div id="TXT31">
					<textarea style="width: 100%; height: 100%; resize: none;"></textarea>
				</div>
				<input type="hidden" name="list[1].text_content" class="text_content0">
				<input type="hidden" name="list[1].text_no" value="1"> 
				<div id="TXT32">
					<textarea style="width: 100%; height: 100%; resize: none;"></textarea>
				</div>
				<input type="hidden" name="list[2].text_content" class="text_content1">
				<input type="hidden" name="list[2].text_no" value="2"> 
			</div>
			<div id="RS_IContainer3">
				<div id="IMG32">
				<label for="C_IMG32"><img src="./img/folder.png"></label> 
				<input id="C_IMG32" class="file" name="file" type="file" multiple="multiple" style="display: none;">
				</div>
				<input type="hidden" name="list[3].img_spath" class="img_spath1">
				<input type="hidden" name="list[3].text_no" value="3"> 
				<div id="IMG33">
				<label for="C_IMG33"><img src="./img/folder.png"></label> 
				<input id="C_IMG33" class="file" name="file" type="file" multiple="multiple" style="display: none;">
				</div>
				<input type="hidden" name="list[4].img_spath" class="img_spath2">
				<input type="hidden" name="list[4].text_no" value="4"> 
				<div id="TXT33">
					<textarea style="width: 100%; height: 100%; resize: none;"></textarea>
				</div>
				<input type="hidden" name="list[5].text_content" class="text_content2">
				<input type="hidden" name="list[5].text_no" value="5"> 
			</div>
		</div>
		</div>
	</form>
	
	<div id="insert-container" onclick="insert()">
		<img id="insert" src="./img/check.png">
	</div>
</body>
</html>