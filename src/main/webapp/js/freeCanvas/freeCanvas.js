 //책 모양 가져오기
$('#mybook').booklet({
	width:  960,
    height: 650,
    shadow: false,      	
    pageNumbers : false
});		
	
var text = $("div[id*='txt']");
var imgs =$("div[id*='IMG']");
var subImgClass;	

$(document).ready(function() {
	//에디터 버튼
	var inner = $(".inner");
	inner.css('opacity', '0');
	
	inner.mouseover(function(){
		$(this).css('opacity', '1');
	});
	
	inner.mouseout(function(){
		$(this).css('opacity', '0');
	});
	
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
	
	//이미지 삭제
//	$("img").click(function(){
//		$(this).parents().css("background-image","url('')");
//	});
	
});

function fileUpload(subImgClass) {
	var frmEle = document.getElementById("frm");
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

//에디터 팝업창
function editor(id){
	window.open('./editor.do?id='+id,'글 편집',
			'width=600, height=500, resizable=no, fullscreen=no, left=20, top=20');
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
		
//입력
function insert() {
	for (var i = 0; i < text.length; i++) {
		var text_content = $("input[class=text_content"+i+"]");
		text_content.val(text.eq(i).html());
	}
			
	var frm = document.getElementById("frm");
	frm.action = './insertData.do';
	frm.method = 'post';
	frm.submit();
}

//수정
function update() {
	for (var i = 0; i < text.length; i++) {
		var text_content = $("input[class=text_content"+i+"]");
		text_content.val(text.eq(i).html());
	}
	
	var frm = document.getElementById("frm");
	frm.action = './updateFreeCanvas.do';
	frm.method = 'post';
	frm.submit();
}