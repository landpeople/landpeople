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
				 		<a href="#" onclick="like('${ldto.user_email}')"><img id="likeState" alt="likeEmpty" src="./img/LikeBefore.png"></a>
				 		
				 		<a href="#" onclick="scrape('${ldto.user_email}')"> <img alt="scrape" src="./img/scrape.png"> </a>
	 				</div>	
					<input type="button" value="내 스크랩  목록 보기" onclick="goScrapeMine('${ldto.user_email}')">
					
					<form action="#" method="post" id="scrapDiv" name="scrapeDiv" onsubmit="return chkBox()">
					<input type="submit" value="스크랩 취소">
					<div id="scrapeSel" style="width: 500px;">
					</div>
					</form>
					<br>
					<input type="button" value="내 스케치북 보기" onclick="sketchSelectMine()">
					<input type="hidden" value="${ldto.user_email}" id="user_email">
					
										
					<input type="button" value="테마 조회" onclick="sketchSelectTheme()">
					<input type="hidden" value="나홀로" id="themeType"> 
					
				
				
				</div>
			
			
			
			
			
			</div>
			<!--  여기까지 메인 컨텐츠  -->
			<div class="footer">landpeople</div>
		</div>
	</div>
</body>
<script type="text/javascript">

//---------------------- 좋아요 등록 및 수정 --------------------
function like(user){
//	alert("좋아요 취소");
	LpLike(user);
}

var LpLike = function(user){
    var user_email = user;
    var sketch_id = "4";
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
function scrape(user) {
	//alert("스크랩");
	LpScrape(user);
	alert(user);
}

var LpScrape = function(user){
//	var user_email = "128@happy.com";
	var sketch_id = "4";
//	alert("스크랩 등록");	
	$.ajax({
		url : "Scrape.do",
		type : "get",
		data :  "user_email="+user+"&sketch_id="+sketch_id,
		success : function(sresult){
			alert(sresult.sresult);
		}, error : function() {
			alert("실패");
		}
	});
	   
}

//---------------------- 스크랩 등록 및 수정 --------------------



//---------------------- 스크랩한 스케치북 보기 ---------------------- 

function goScrapeMine(email){
	alert(email);
	var user_email = email;
	location.href ="./SelectScrapeSketch.do?user_email="+user_email;
}





function scrapeSelectMine(email) {
//	alert("스크랩 보기");
	var user_email = email;
	alert(user_email);
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
						"</tr>";
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

function sketchSelectMine(){
	var email = $("#user_email").val();
	alert(email);
	location.href = "./sketchSelMine.do?user_email="+email;
	
}


//--------------------- 작성한 스케치북 조회 -----------------------




//-------------------- 작성 스케치북 수정 모달 생성 --------------------

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
			
			alert(modiModal.sdto.user_email);
			alert(modiModal.sdto.sketch_theme);
			alert(modiModal.sdto.sketch_spath);
			alert(modiModal.sdto.sketch_share);
			var modiFormHTML =	"<input type='hidden' name='user_email' value='"+modiModal.sdto.user_email+"'>"+
							  	"<input type='hidden' name='sketch_id' value='"+modiModal.sdto.sketch_id+"'>"+
						
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
						+"<label>스케치북 공유여부</label>"
						+"<div class='themeradio'>"
						+"<input type='radio' id='sketchShareY' name='sketch_share' value='Y'><label for='sketchShareY'>Y</label>"
						+"<input type='radio' id='sketchShareN' name='sketch_share' value='N'><label for='sketchShareN'>N</label>"
						+"</div>"
						+"</div>"
						+
						
						"<div class='form-group'>"
						+ "<label>스케치북 커버이미지</label>"
						+ "<div id='moSketchBookCover'>"+
							"<div id='modalIMG1' style='background-image :url("+modiModal.sdto.sketch_spath+")'>"+
								"<input type='hidden' name='sketch_spath' class='img_spath0'>"+
										"<label for='C_IMG1'><img src='./img/folder.png'></label>"+
										"<input id='C_IMG1' class='file'  name='file' type='file' multiple='multiple' style='display: none;'>"+
											
							"</div>"+
								
							"</div>"
						+ "</div>"
						+
			
						"<div class='modal-footer'>"
						+ "<input class='btn btn-success' type='button' value='수정완료 ' onclick='sketchModify()'>"
						+ "<button type='button' class='btn btn-default' data-dismiss='modal'>닫기</button>"
						+ "</div>";
					$("#modiSketchBook").html(modiFormHTML);
					
					
					$('input:radio[name=sketch_theme]:input[value='+modiModal.sdto.sketch_theme+']').attr("checked", true);
					//$("input:radio[name='sketch_share'][value="+ modiModal.sdto.sketch_share +"]").prop('checked', true);
					//$("input:radio[name='sketch_theme'][value="+ modiModal.sdto.sketch_theme +"]").prop('checked', true);

					
		}, error : function(){
			alert("실패");
		}
	});
	
}

//-------------------- 작성 스케치북 수정 모달 생성 --------------------

//-------------------- 작성 스케치북 수정  --------------------


function sketchModify(){
	var sketchModiModal = document.getElementById("modiSketchBook");
	var sketch_theme = $("input[name=sketch_theme]:checked").val();
	sketchModiModal.action = "./modifySketch.do";
	
	var title = $("#sketchtitle").val();
	var theme = $("input[name=sketch_theme]:checked").length;
	
	if (title == "" || theme == 0) {
		alert("스케치북 제목 혹은 스케치북 타입을 확인해주세요");
	} else if (title.length >= 20) {
		alert("스케치북의 제목이 너무 깁니다.");
		$("#sketchtitle").val("");
	} else {
		sketchModiModal.submit();
		alert("스케치북 수정완료");
	}
}



//-------------------- 작성 스케치북 수정  --------------------





//-------------------  테마별 스케치북 조회 ------------------ 

function sketchSelectTheme(){
	var themeType = $("#themeType").val();
	
	location.href="./sketchBookTheme.do?type="+themeType;
}


//-------------------  테마별 스케치북 조회 ------------------


//------------------- 작성 스케치북 완전 다중 삭제 ----------------- 

function checkAllSketch(bool){
	var chks =  document.getElementsByName("chkVal");
//	alert(chks.length);
	for (var i = 0; i < chks.length; i++) {
		chks[i].checked = bool;
	}
}

function DelchkBox(){
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
		var sketchDelChk = confirm("스케치북을 삭제하시겠습니까?");
		if(sketchDelChk == true){
		
			var doc =document.sketchSel;
			doc.action = "./sketchRealDeleteMulti.do";
			
			return true;
		}else{
			alert("스케치북 삭제가 취소되었습니다.");
			
			return false;
		}
		
	}else{
		alert("선택된 스케치북이 없습니다.");
		return false;
	}
}



//------------------- 작성 스케치북 완전 다중 삭제 ----------------- 

</script>
</html>