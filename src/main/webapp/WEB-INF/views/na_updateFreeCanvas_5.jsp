<%@page import="happy.land.people.dto.kim.LPTextDto"%>
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
<title>레이아웃 5번</title>
<link rel="stylesheet" href="css/Layout_5.css">
<!-- 토스트 에디터 파일 가져오기 -->
<link rel="stylesheet" href="https://uicdn.toast.com/tui-editor/latest/tui-editor.css"></link>
<link rel="stylesheet" href="https://uicdn.toast.com/tui-editor/latest/tui-editor-contents.css"></link>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.33.0/codemirror.css"></link>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.12.0/styles/github.min.css"></link>
<script src="https://uicdn.toast.com/tui-editor/latest/tui-editor-Editor-full.js"></script>
<script type="text/javascript" src="./js/jquery-3.3.1.js"></script>
</head>
<body>
	<form method="post" enctype="multipart/form-data" name="frm" id="frm">
	<!-- 왼쪽 -->
	<div id="Left-Side">
		<div id="LS_IContainer">
			<div id="IMG1" style="background-image: url('<%=list.get(0).getImg_spath()%>')">
			<label for="C_IMG1"><img src="./img/folder.png"></label> 
			<input id="C_IMG1" class="file" name="file" type="file" multiple="multiple" style="display: none;">
			</div>
			<input type="hidden" name="list[0].img_spath" class="img_spath0" value="<%=list.get(0).getImg_spath()%>">
			<input type="hidden" name="list[0].text_no" value="0"> 
		</div>
		<div id="LS_TContainer">
			<div id="TXT1">
				<textarea style="width: 100%; height: 100%; resize: none;"><%=list.get(1).getText_content() %></textarea>
			</div>
			<input type="hidden" name="list[1].text_content" class="text_content0" value="<%=list.get(1).getText_content() %>">
			<input type="hidden" name="list[1].text_no" value="1"> 
		</div>
	</div>
	
	<!-- 오른쪽 -->
	<div id="Right-Side">
		<div id="RS_ITContainer1">
			<div id="IMG2" style="background-image: url('<%=list.get(2).getImg_spath()%>')">
			<label for="C_IMG2"><img src="./img/folder.png"></label> 
			<input id="C_IMG2" class="file" name="file" type="file" multiple="multiple" style="display: none;">
			</div>
			<input type="hidden" name="list[2].img_spath" class="img_spath1" value="<%=list.get(2).getImg_spath()%>">
			<input type="hidden" name="list[2].text_no" value="2"> 
			<div id="TXT2">
				<textarea style="width: 100%; height: 100%; resize: none;"><%=list.get(3).getImg_spath()%></textarea>
			</div>
			<input type="hidden" name="list[3].text_content" class="text_content1" value="<%=list.get(3).getImg_spath()%>">
			<input type="hidden" name="list[3].text_no" value="3"> 
			<div id="IMG3" style="background-image: url('<%=list.get(4).getImg_spath()%>')">
			<label for="C_IMG3"><img src="./img/folder.png"></label> 
			<input id="C_IMG3" class="file" name="file" type="file" multiple="multiple" style="display: none;">
			</div>
			<input type="hidden" name="list[4].img_spath" class="img_spath2" value="<%=list.get(4).getImg_spath()%>">
			<input type="hidden" name="list[4].text_no" value="4"> 
		</div>
		<div id="RS_ITContainer2">
			<div id="TXT3">
				<textarea style="width: 100%; height: 100%; resize: none;"><%=list.get(5).getText_content()%></textarea>
			</div>
			<input type="hidden" name="list[5].text_content" class="text_content2" val>
			<input type="hidden" name="list[5].text_no" value="5"> 
			<div id="IMG4" style="background-image: url('<%=list.get(6).getImg_spath()%>')">
			<label for="C_IMG4"><img src="./img/folder.png"></label> 
			<input id="C_IMG4" class="file" name="file" type="file" multiple="multiple" style="display: none;">
			</div>
			<input type="hidden" name="list[6].img_spath" class="img_spath3" value="<%=list.get(6).getImg_spath()%>">
			<input type="hidden" name="list[6].text_no" value="6"> 
			<div id="TXT4">
				<textarea style="width: 100%; height: 100%; resize: none;"><%=list.get(7).getText_content()%></textarea>
			</div>
			<input type="hidden" name="list[7].text_content" class="text_content3" value="<%=list.get(7).getText_content()%>">
			<input type="hidden" name="list[7].text_no" value="7"> 
		</div>
	</div>
	</form>
	
	<div id="insert-container" onclick="insert()">
		<img id="insert" src="./img/check.png">
	</div>
	
	<script type="text/javascript">
		var ids = $("div[id*='TXT']");
		var editor = new Array(ids.length);
		var imgs =$("div[id*='IMG']");
		var subImgClass;	
	
		$(document).ready(function() {
			//에디터
			for (var i = 0; i < ids.length; i++) {
				setEditor(ids.eq(i).attr("id"), i);
			}
			//이미지 업로드
			$(".file").on("change", function(){
				var imgClass = $(this).attr("id");
				subImgClass = imgClass.substring(imgClass.indexOf('_')+1);
				fileUpload(subImgClass);
			});
		});
	
		function setEditor(id, i) {
			editor[i] = new tui.Editor({
							el : document.querySelector("#" + id),
							initialEditType : 'wysiwyg',
							previewStyle : 'tab',
							height : "'" + $("div[id='" + id + "']").attr("height") + "'"
					});
		}
		
		function fileUpload(subImgClass) {
			
			var frmEle = document.forms[0];
			var formData = new FormData(frmEle);
			for (var i = 0; i < imgs.length; i++) {
				formData.append("file",$(".file")[i]);
			}
				formData.append("text_no",subImgClass);
	
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
				success : function(result) {
					var imgDiv = subImgClass;
					for (var i = 0; i < imgs.length; i++) {
						
						if (imgs.eq(i).attr("id") == imgDiv) {
							$("div[id="+imgDiv+"]").css("background-image", "url('" + result+ "')");
							var img_spath = $("input[class=img_spath"+i+"]");
							img_spath.val(result);
						}//if
					
					}//for
				}
			});
		}
		
		function insert() {
			//editor 텍스트를 서버에 넘기기 위한 변수에 저장
			for (var i = 0; i < editor.length; i++) {
				var text_content = $("input[class=text_content"+i+"]");
				text_content.val(editor[i].getHtml());
			}
			
			var frm = document.getElementById("frm");
			frm.action = './updateFreeCanvas.do';
			frm.method = 'post';
			frm.submit();
		}
	</script>
</body>
</html>