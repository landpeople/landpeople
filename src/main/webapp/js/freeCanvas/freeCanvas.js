 //책 모양 가져오기
$('#mybook').booklet({
	width:  960,
    height: 650,
    shadow: false,      	
    pageNumbers : false
});		
	
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
		//파일 확장자 확인
		if(extension($("input[id="+imgClass+"]").val())){
			//파일 업로드 실행
			fileUpload(subImgClass);
		}
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

	$.ajax({
		url : './uploadFile.do',
		type : 'post',
		data : formData,
		enctype : 'multipart/form-data',
		processData : false,
		contentType : false,
		success : function(result) {
			alert(result);
			var imgDiv = subImgClass;
			for (var i = 0; i < imgs.length; i++) {
		
				if (imgs.eq(i).attr("id") == imgDiv) {
					$("div[id="+imgDiv+"]").css("background-image", "url('" + result+ "')");
					var img_spath = $("input[class=img_spath"+i+"]");
					img_spath.val(result);
				}
			
			}
		}
	});
}
		
//확장자 확인 (업로드할 수 있는 확장자일시 true)
function extension(file){
	var reg = /gif|jpg|png|jpeg/i;
	if(reg.test(file)){
		return true;
	}else{
		alert("잘못된 확장자입니다.\n★jpg/png/gif★ 파일만 업로드 가능합니다.");
		return false;
	}
}
		
function insert() {
	for (var i = 0; i < editor.length; i++) {
		var text_content = $("input[class=text_content"+i+"]");
		text_content.val(editor[i].getHtml());
	}
			
	var frm = document.getElementById("frm");
	frm.action = './insertData.do';
	frm.method = 'post';
	frm.submit();
}