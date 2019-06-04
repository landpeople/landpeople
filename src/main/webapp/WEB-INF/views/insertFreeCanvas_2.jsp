<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레이아웃 2번</title>
<!-- CKEditor -->
<script src="https://cdn.ckeditor.com/4.11.4/standard/ckeditor.js"></script>
<!-- CSS -->
<link rel="stylesheet" href="css/freeCanvasLayout.css">
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
<!-- js -->
<script src="./js/freeCanvas/freeCanvas.js" defer="defer"></script>
<!-- font awesome -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
</head>
<body>
<script type="text/javascript">
//에디터
$(document).ready(function(){
for (var i = 0; i < ids.length; i++) {
	setEditor(ids.eq(i).attr("id"));
	}
});

function setEditor(id) {
	CKEDITOR.disableAutoInline = true;
	CKEDITOR.inline( "'"+id+"'" );
}
</script>
<div class="main-wrapper">
<%@include file="./common/Sidebar.jsp" %>
	<div class="content-wrapper">
	<!-- 메인 컨텐츠   -->
	<div class="lpcontents">
	<div class="content">
		<div class="head-title">
			<div class="back" onclick="javascript:history.back(-1)"><i class="fas fa-reply fa-2x"></i></div>
			<div class="title">나홀로 떠나는 제주도 여행</div>
		</div>
		
		<div class="article-canvasContent">
		<form method="post" enctype="multipart/form-data" name="frm" id="frm">
		<div id="mybook">
			<!-- 왼쪽  -->
			<div id="Left-Side2">
				<div id="LS_TContainer2">
					<div id="TXT21" contenteditable="true">
					</div>
					<input type="hidden" name="list[0].text_content" class="text_content0">
					<input type="hidden" name="list[0].text_no" value="0"> 
				</div>
				<div id="LS_IContainer2">
					<div id="IMG21">
						<label for="C_IMG21"><img src="./img/folder.png"></label> 
						<input id="C_IMG21" class="file" name="file" type="file" multiple="multiple" style="display: none;">
					</div>
					<input type="hidden" name="list[1].img_spath" class="img_spath0">
					<input type="hidden" name="list[1].text_no" value="1"> 
					<div id="IMG22">
						<label for="C_IMG22"><img src="./img/folder.png"></label> 
						<input id="C_IMG22" class="file" name="file" type="file" multiple="multiple" style="display: none;">
					</div>
					<input type="hidden" name="list[2].img_spath" class="img_spath1">
					<input type="hidden" name="list[2].text_no" value="2"> 
					<div id="IMG23">
						<label for="C_IMG23"><img src="./img/folder.png"></label> 
						<input id="C_IMG23" class="file" name="file" type="file" multiple="multiple" style="display: none;">
					</div>
					<input type="hidden" name="list[3].img_spath" class="img_spath2">
					<input type="hidden" name="list[3].text_no" value="3"> 
				</div>
			</div>
	
			<!-- 오른쪽 -->
			<div id="Right-Side2">
				<div id="IMG24">
					<label for="C_IMG24"><img src="./img/folder.png"></label> 
					<input id="C_IMG24" class="file" name="file" type="file" multiple="multiple" style="display: none;">
				</div>
				<input type="hidden" name="list[4].img_spath" class="img_spath3">
				<input type="hidden" name="list[4].text_no" value="4"> 
				<div id="TXT22" contenteditable="true">
				</div>
				<input type="hidden" name="list[5].text_content" class="text_content1">
				<input type="hidden" name="list[5].text_no" value="5"> 
			</div>
			</div>
		</form>
		</div>
		
		<div class="footer-icon">
			<div class="insertIcon" onclick="insert()">
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