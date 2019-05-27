<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>

<script src="./js/jquery-3.3.1.js"></script>
<script src="./js/sketchbook/sketchbook.js"></script>
<link rel="stylesheet" href="./css/lp-style.css">
<link rel="stylesheet" href="./css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

<script type="text/javascript">
  
  
function sketchBookMake(user){
var user_email= user;
	//	alert();
	ajaxSketchMake(user_email);
	
}  
 
var ajaxSketchMake = function(user_email){
	//alert(user_email);
	
	$.ajax({
		url : "sketchMakeForm.do",
		type : "get",
		data : {"user_email":user_email},
		dataType : "json",
		success : function(map){
				
			if(map.user_iswrite=="F" || map.user_iswrite== null)
				alert("작성권한이 없습니다.");
			else{
				//alert(map.user_iswrite);
				//alert(map.user_email);
				$("#sketchForm").modal();
				var htmlModal = "<input type='hidden' name='user_email' value='"+map.user_email+"'>"+
											
								"<div class='form-group'>"+
								"<label>스케치북 제목</label>"+
								"<div class='modal-input'>"+
								"<input type='text' class='form-control' id='sketchtitle' name='sketch_title' style='width : 400px;' required='required'></div>"+
								"</div>"+
								
								"<div class='form-group'>"+
								"<label>스케치북 테마</label>"+
								"<div class='themeradio'>"+
								"<input type='radio' id='familytheme' name='sketch_theme' value='가족여행'><label for='familytheme'>가족여행</label>"+
								"<input type='radio' id='solotheme' name='sketch_theme' value='나홀로여행'><label for='solotheme'>나홀로여행</label>"+
								"<input type='radio' id='coupletheme' name='sketch_theme' value='연인과 함께'><label for='coupletheme'>연인과 함께</label>"+
								"<input type='radio' id='friendtheme' name='sketch_theme' value='친구와 함께'><label for='friendtheme'>친구와 함께</label></div>"+
								"</div>"+
								
								"<div class='form-group'>"
								+ "<label>스케치북 공유여부</label>"
								+ "<div class='themeradio'>"
								+ "<input type='radio' id='sketchShareY' name='sketch_share' value='Y'><label for='sketchShareY'>Y</label>"
								+ "<input type='radio' id='sketchShareN' name='sketch_share' value='N'><label for='sketchShareN'>N</label>"
								+"</div>"
								+ "</div>"
								+
								
								"<div class='form-group'>"+
// 								"<form method='post' enctype='multipart/form-data' name='sketchCover' id='sketchCover'>"+
								"<label>스케치북 커버이미지</label>"+
									"<div id='moSketchBookCover'>"+
											"<div id='modalIMG1'>"+
													"<label for='C_IMG1'><img src='./img/folder.png'></label>"+
													"<input id='C_IMG1' class='file'  name='sketch_spath' type='file' multiple='multiple' style='display: none;'>"+
// 													"<button onclick='fileUpload()'>등록</button>"
											"</div>"+
// 											"<input type='hidden' name='list[0].img_spath' class='img_spath0'>"+
// 											"<input type='hidden' name='list[0].text_no' value='0'>"+
									"</div>"+
// 								"</form>"+
								"</div>"+
								
								"<div class='modal-footer'>"+
									"<input class='btn btn-success' type='button' value='작성완료 ' onclick='sketchInsert()'>"+
									"<button type='button' class='btn btn-default' data-dismiss='modal'>닫기</button>"+
								"</div>";
				
				$("#makeSketchBook").html(htmlModal);
				
				$("input[id=C_IMG1]").change(function(){
					fileUpload();				
				});
			}
			
		}, error : function() {
			alert("실패");
		}
	}); 
}

/* function sketchInsert(){
	var sketch= document.getElementById("makeSketchBook");
	var sketch_theme = $("input[name=sketch_theme]:checked").val();
	sketch.action ="./writeSketch.do";
	var title = $("#sketchtitle").val();
	var theme = $("input[name=sketch_theme]:checked").length;
	
	
	if(title == "" || theme == 0){
		alert("스케치북 제목 혹은 스케치북 타입을 확인해주세요");
	}else if(title.length >= 20){
		alert("스케치북의 제목이 너무 깁니다.");
		$("#sketchtitle").val("");
	}else{
		sketch.submit();
		alert("스케치북 작성완료");
	}
	
	
} */
  
  
</script>






</head>
<body>

	${ldto.user_email}
	<!--젤로 레이아웃- 전체 영역 감싸는 div-->
	<div class="main-wrapper">

		<!-- SIDEBAR -->
		<div class="sidebar-menu">
			<div class="top-section">
				<!-- 프로필 사진 영역 전체 감싸는  div -->
				<div class="profile-image"></div>
			</div>
			<!-- 여기까지 프로필 사진 영역 전체 감싸는 div -->

			<!-- 네비게이션 메뉴 -->
			<div class="main-navigation">
				<ul class="navigation">
					<li><a href="#">로그인/로그아웃</a></li>
					<li><a href="#" onclick="sketchBookMake('${ldto.user_email}')">여행일정 작성</a></li>
					<li><a href="#">마이페이지/관리자 페이지</a></li>
				</ul>
			</div>
			<!-- .main-navigation 여기까지 네비게이션 메뉴 -->

			<!-- 채팅 -->
			<div class="chatting">
			<!-- 	<iframe src="http://www.daum.net"></iframe> -->
			</div>
			<!-- 채팅 -->
			
			<!-- 스케치북 생성 Modal -->
				<div class="modal fade" id="sketchForm" role="dialog">
				  <div class="modal-dialog">
				
				    
				    <div class="modal-content">
					      <div class="modal-header">
					        <button type="button" class="close" data-dismiss="modal">&times;</button>
					        <h4 class="modal-title">스케치북 작성</h4>
				      	  </div>
						  <div class="modal-body">
						  	
								 <form action="#" role="form" method="post" id="makeSketchBook" enctype='multipart/form-data'></form>
						      
						  
						  </div>
				    </div>
				  </div>
				</div><!-- 여기까지 스케치북 생성 Modal -->
			
			
			
			
			
		</div>
		<!-- .sidebar-menu 여기까지 사이드 바 -->

		<div class="content-wrapper">
			<!-- 헤더 그림 -->
			<div class="banner-bg" id="top">
				<div class="banner-overlay"></div>
				<div class="welcome-text"></div>
			</div>
			<!-- 메인 컨텐츠   -->
			<div class="main-lpcontents">
				<div class="content">
					<!-- <div class="page-section" id="projects"> -->
					<a href="./test.do">테스트 페이지로 이동</a><br> <a href="./kim.do">김태우
						페이지로 이동</a><br> <a href="./na.do">나원서 페이지로 이동</a><br> <a
						href="./lee.do">이연지 페이지로 이동</a><br> <a href="./jang.do">장석영
						페이지로 이동</a><br> <a href="./jung.do">정희태 페이지로 이동</a> 
				
		<!-- <form method="post" enctype="multipart/form-data" name="frm" id="frm">		
			<div class="moSketchBookCover">
				<div>
					<div id="modalIMG1">
						<label for="C_IMG1"><img src="./img/folder.png"></label> 
						<input id="C_IMG1" class="file" name="file" type="file" multiple="multiple" style="display: none;">
					</div>
						<input type="hidden" name="list[5].img_spath" class="img_spath1">
						<input type="hidden" name="list[5].text_no" value="5"> 
				</div>
			</div>
		</form>		
				 -->
				
				
			
				
				
				</div>
			</div><!--  여기까지 메인 컨텐츠  -->
			
			
			
			
			
			


			<div class="footer">landpeople</div>
		</div>
	</div>
</body>

<script type="text/javascript">
// var imgs =$("div[id*='modalIMG1']");
// var subImgClass;



$(document).ready(function() {


	//이미지 업로드
	//alert("이미지 업로드");
	
	
	
});



function fileUpload() {
	var frmEle = document.forms[0];
	var formData = new FormData(frmEle);
	
		/* formData.append("text_no",subImgClass); */

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
		url : './uploadSketchBook.do',
		type : 'post',
		data : formData,
		enctype : 'multipart/form-data',
		processData : false,
		contentType : false,
		success : function(result) {
			alert("아작스 결과"+result);
					$("div[id=modalIMG1]").css("background-image", "url('" + result+ "')");
					var img_spath = $("input[id=C_IMG1]");
					img_spath.val(result);
		},error : function(){
			alert("실패");
		}
	});
}



</script>






</html>