<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>정희태 테스트 페이지</title>

<script src="./js/jquery-3.3.1.js"></script>
<link rel="stylesheet" href="./css/lp-style.css">
<link rel="stylesheet" href="./css/bootstrap.min.css">
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>









</head>
<body>
	<div class="main-wrapper">
		<%@include file="./common/Sidebar.jsp"%>
		<div class="content-wrapper">
			
			<!-- 메인 컨텐츠   -->
			<div class="lpcontents">
				<div class="content">
					<div>
				 		<a href="#" onclick="like()"><img id="likeState" alt="likeEmpty" src="./img/LikeBefore.png"></a>
				 		<a href="#"><!-- <img id="likeAfter" alt="likeHeart" src="./img/LikeAfter.png"> --></a>
				 		<a href="#" onclick="scrape()"> <img alt="scrape" src="./img/scrape.png"> </a>
	 				</div>	
					<input type="button" value="내 스크랩  목록 보기" onclick="scrapeSelectMine()">
					<form action="#" method="post" id="scrapDiv" name="scrapeDiv" onsubmit="return chkBox()">
					<input type="submit" value="스크랩 취소">
					<div id="scrapeSel" style="width: 500px;">
					
					</div>
					
					
					</form>
					<br>
					<input type="button" value="내 스케치북 보기" onclick="sketchSelectMine()">
					<input type="button" value="테마 조회" onclick="sketchSelectTheme()">
					<input type="hidden" value="나홀로" id="themeType"> 
					<div id="sketchSel" style="width: 500px;">
					<a href="#" onclick="sketchBookModify()"><img alt="modi" src="img/sketchBookImg/modifyIcon.png"></a>
					</div>
					
				<!-- 스케치북 수정 Modal -->
					<div class="modal fade" id="sketchModiForm" role="dialog">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h4 class="modal-title">스케치북 수정</h4>
								</div>
								<div class="modal-body">
									<form action="#" role="form" method="post" id="modiSketchBook"></form>
								</div>
							</div>
						</div>
					</div>
					<!-- 여기까지 스케치북 생성 Modal -->
				
				
				
				
				</div>
			
			
			
			
			
			</div>
			<!--  여기까지 메인 컨텐츠  -->
			<div class="footer">landpeople</div>
		</div>
	</div>
</body>
<script type="text/javascript">

//---------------------- 좋아요 등록 및 수정 --------------------
function like(){
//	alert("좋아요 취소");
	LpLike();
}

var LpLike = function(){
    var user_email = "130@happy.com";
    var sketch_id = "0004";
	$.ajax({
		url: "LPLike.do",
		type: "get",
		data: {"user_email" : user_email, "sketch_id" : sketch_id },
		dataType: "Json",
		success: function(result){
			//alert("실행되라");
			alert(result.result);	
			if(result.result == "F")
				$("#likeState").attr("src","./img/LikeBefore.png");	
			else
				$("#likeState").attr("src","./img/LikeAfter.png");	
		}, error : function() {
			alert("실패");
		}
		
	});
}

//---------------------- 좋아요 등록 및 수정 --------------------



//---------------------- 스크랩 등록 및 수정 --------------------
function scrape() {
	//alert("스크랩");
	LpScrape();
}

var LpScrape = function(){
	var user_email = "128@happy.com";
	var sketch_id = "0007";
//	alert("스크랩 등록");	
	$.ajax({
		url : "Scrape.do",
		type : "get",
		data :  "user_email="+user_email+"&sketch_id="+sketch_id,
		success : function(sresult){
			alert(sresult.sresult);
		}, error : function() {
			alert("실패");
		}
	});
	   
}

//---------------------- 스크랩 등록 및 수정 --------------------



//---------------------- 스크랩한 스케치북 보기 ---------------------- 

function scrapeSelectMine() {
//	alert("스크랩 보기");
	var user_email ="128@happy.com";
	$.ajax({
		url : "ScrapeSelect.do",
		type : "get",
		data : {"user_email" : user_email},
		dataType : "json",
		success : function(scrape){
			//alert(scrapeCnt);
			
			//alert(scrape.size());
			if(scrape== "" ||scrape==null){
				alert("스크랩한 스케치북이 없습니다.");
			}else{		
			var htmlTable = "";
				htmlTable +="<table class='table table-bordered'>"+
						"<tr>"+
						"<th><input type='checkbox' onclick='checkAllScrape(this.checked)'></th>"+
						"<th>스케치북 타이틀</th>"+
						"<th>스케치북 커버이미지</th>"+
						"<th>좋아요 Cnt</th>"+
						"<tr>";
				htmlTable += scrape.scrapeResult;	
				$("#scrapeSel").html(htmlTable);
			}
		}, error : function() {
			alert("실패");
		}
		
	});


}

//---------------------- 스크랩한 스케치북 보기 ---------------------- 



//---------------------- 스크랩한 스케치북 취소 -----------------------

function checkAllScrape(bool){
	var chks =  document.getElementsByName("chkVal");
//	alert(chks.length);
	for (var i = 0; i < chks.length; i++) {
		chks[i].checked = bool;
	}
}


function chkBox(){
//	alert("작동");
	var chks =  document.getElementsByName("chkVal");
	var c = 0;
	for (var i = 0; i < chks.length; i++) {
		if(chks[i].checked){
			c++;
		}
	}
	if(c>0){
//		var doc = document.getElementById("scrapeDiv");
//		var doc = document.forms[0];
		var scrapeChk = confirm("스크랩을 등록을 취소하시겠습니까?");
		if(scrapeChk == true){
		
			var doc =document.scrapeDiv;
			doc.action = "./multiScrapeUpdate.do";
			
			return true;
		}else{
			alert("취소x");
			
			return false;
		}
		
	}else{
		alert("선택된 스케치북이 없습니다.");
		return false;
	}
}

//---------------------- 스크랩한 스케치북 취소 -----------------------


//--------------------- 작성한 스케치북 조회 -----------------------

function sketchSelectMine() {
//	alert("작성 스케치북 보기");
	var user_email ="128@happy.com";
	$.ajax({
		url : "sketchSelMine.do",
		type : "post",
		data : {"user_email" : user_email},
		dataType : "json",
		success : function(sketchBook){
			//var mySketchBookSize = sketchBook.mySketchBook.size();
			alert(sketchBook);
			//alert(mySketchBookSize);
			htmlTable = "";
			htmlTable +="<table class='table table-bordered'>"+
					"<th>스케치북 타이틀</th>"+
					"<th>스케치북 커버이미지</th>"+
					"<th>좋아요 Cnt</th>"+
					"<tr>";
			htmlTable += sketchBook.mySketchBook;		
			$("#sketchSel").html(htmlTable);
			
			
		}, error : function() {
			alert("실패");
		}
	});
}

//--------------------- 작성한 스케치북 조회 -----------------------




//-------------------- 작성 스케치북 수정 --------------------

function sketchBookModify() {
	var user_email = "124@happy.com"
	var sketch_id = "0002"
//	alert("스케치북 수정");
//	alert(user_email);
	ajaxSketchModi(user_email, sketch_id);
	$("#sketchModiForm").modal();
}

	var ajaxSketchModi = function(user_email, sketch_id){
//	alert(user_email);
	
	$.ajax({
		url : "sketchModifyForm.do",
		type : "post",
		data : { "user_email" : user_email,
				 "sketch_id"  :	sketch_id },
		dataType : "json",
		success :function(modiModal){
			//alert(modiModal.sdto.sketch_title);
			//alert(modiModal.sdto.sketch_id);
			
			alert(modiModal.sdto.sketch_theme);
			
			
			var modiFormHTML = "<input type='hidden' name='sketch_id' value='"+modiModal.sdto.sketch_id+"'>"+
						
						 "<div class='form-group'>"
						+ "<label>스케치북 제목</label>"
						+ "<div class='modal-input'>"
						+ "<input type='text' class='form-control' id='sketchtitle' name='sketch_title' value='"+modiModal.sdto.sketch_title+"' style='width : 400px;' required='required'></div>"
						+ "</div>"
						+
			
						"<div class='form-group'>"
						+ "<label>스케치북 테마</label>"
						+ "<div class='themeradio'>"
						+ "<input type='radio' id='familytheme' name='sketch_theme' value='가족여행'><label for='familytheme'>가족여행</label>"
						+ "<input type='radio' id='solotheme' name='sketch_theme' value='나홀로'><label for='solotheme'>나홀로여행</label>"
						+ "<input type='radio' id='coupletheme' name='sketch_theme' value='연인과 함께'><label for='coupletheme'>연인과 함께</label>"
						+ "<input type='radio' id='friendtheme' name='sketch_theme' value='친구와 함께'><label for='friendtheme'>친구와 함께</label></div>"
						+ "</div>"
						+
			
						"<div class='form-group'>"
						+ "<label>스케치북 커버이미지</label>"
						+ "<input type='text' class='form-control' id='cover' name='coverimage' value='"+modiModal.sdto.sketch_spath+"' style='width : 400px;'>"
						+ "</div>"
						+
			
						"<div class='modal-footer'>"
						+ "<input class='btn btn-success' type='button' value='수정완료 ' onclick='sketchModify()'>"
						+ "<button type='button' class='btn btn-default' data-dismiss='modal'>닫기</button>"
						+ "</div>";
					$("#modiSketchBook").html(modiFormHTML);
					
					
					$('input:radio[name=sketch_theme]:input[value='+modiModal.sdto.sketch_theme+']').attr("checked", true);
					//$("input:radio[name='sketch_theme'][value="+ modiModal.sdto.sketch_theme +"]").prop('checked', true);

					
		}, error : function(){
			alert("실패");
		}
	});
	
}

//-------------------- 작성 스케치북 수정 --------------------

//-------------------  테마별 스케치북 조회 ------------------ 

function sketchSelectTheme(){
	var themeType = $("#themeType").val();
	
	location.href="./sketchBookTheme.do?type="+themeType;
}


//-------------------  테마별 스케치북 조회 ------------------

</script>
</html>