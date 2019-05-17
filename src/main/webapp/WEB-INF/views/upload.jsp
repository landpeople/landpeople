<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 업로드 테스트 페이지</title>
<style type="text/css">
 #imageArea{ 
/*  	width: 460px;  */
 	height: 480px;
 	background-color:black;
 	background-size: contain;
 	background-repeat: no-repeat;
 	background-position: center;
 	margin: auto;
 } 
</style>
</head>
<body>
<script type="text/javascript" src="./js/jquery-3.3.1.js"></script>
<script type="text/javascript">

	function insert(){
		var frm = document.forms[1];
		frm.action = './insertData.do';
		frm.method = 'post';
		frm.submit();
	}
	
	$(document).ready(function(){
		$("#file").on("change", fileUpload);
	});
	
	function fileUpload(){
		var frmEle = document.forms[0];
		var formData = new FormData(frmEle);
		
		//파일 업로드 확장자 확인
// 		var file = form.file; 여기 부분이 아직 불확실
// 		var fileExt = file.substring(file.lastIndex(".")+1);
// 		var reg = /gif|jpg|png|jpeg/i;
// 		if(reg.test(fileExt)==false){
// 			alert("이미지는 gifm jpg, png 파일만 올릴 수 있습니다.");
			
// 			return;
// 		}
		
		//파일 사이즈 확인
		
		//파일 업로드 확장자 및 사이즈 확인을 메소드로 만들어서 true가 되면 아작스 실행
		
		$.ajax({
			url : './uploadFile.do',
			type : 'post',
			data : formData,
			enctype : 'multipart/form-data',
			processData : false,
			contentType : false,
			success : function(result){
				$("div[id=imageArea]").css("background-image","url('"+result+"')");
				var img_path = $("input[name=img_spath]");
				img_path.val(result);
			}
		});
	}
</script>
<!--영역을 미리 만들어 놓고 영역의 번호(? 아이디를 구분할 수 있는 값)을 받아서  div을 바꿔가며 css을 입히는 방법-->
<!-- width는 height를 잡으면 알아서 잡히기 때문에 잡지 않아도 됨 -->
<!-- 파일 업로드를 위한 폴더 오픈 버튼을 hover로 올리기 div에 hover를 주고 class로 찾기-->
<div id="imageArea">
</div>
<div>
<fieldset>
	<legend>파일 업로드</legend>
	<form action="./insertData.do" method="post" enctype="multipart/form-data" name="frm" id="frm">
		<label for="file"><img src="./image/folder.png"></label>
		<input id="file" name="file" type="file" multiple="multiple" style="display: none;">
	</form>	
	<form>
		<input type="hidden" name="img_spath">
		<input type="hidden" name="text_content" value="-">
		<input type="hidden" name="text_id" value="001">
		<input type="hidden" name="can_id" value="can_001">
		<input type="hidden" name="text_no" value="1">
	</form>
	<div id="insert-container" onclick="insert()"><img id="insert" src="./image/check.png"></div>
</fieldset>
</div>
</body>
</html>