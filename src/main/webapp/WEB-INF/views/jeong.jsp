<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>정희태 테스트 페이지</title>

<script src="./js/jquery-3.3.1.js"></script>
<link rel="stylesheet" href="./css/lp-style.css">

</head>
<body>
	<div class="main-wrapper">
		<%@include file="./common/Sidebar.jsp"%>
		<div class="content-wrapper">
			
			<!-- 메인 컨텐츠   -->
			<div class="lpcontents">
				<div class="content">
				<div>
			 		<a href="#" onclick="like()"><img id="likeAfter" alt="likeHeart" src="./img/LikeAfter.png"></a>
			 		<a href="#"><!-- <img id="likeBefore" alt="likeEmpty" src="./img/LikeBefore.png"> --></a>
			 		<a href="#" onclick="scrape()"> <img alt="scrape" src="./img/scrape.png"> </a>
 				</div>	
				</div>
			</div>
			<!-- </div> 여기까지 메인 컨텐츠  -->
			<div class="footer">landpeople</div>
		</div>
	</div>
</body>
<script type="text/javascript">
function like(){
//	alert("좋아요 취소");
	LpLike();
}

var LpLike = function(){
    var user_email = "";
    var sketch_id = "";
	$.ajax({
		url: "CancelLike.do",
		type: "get",
		data: {"user_email" : user_email, "sketch_id" : sketch_id },
		dataType: "Json",
		success: function(result){
			//alert("실행되라");
			alert(result.result);	
			if(result.result == "F")
				$("#likeAfter").attr("src","./img/LikeBefore.png");	
			else
				$("#likeAfter").attr("src","./img/LikeAfter.png");	
		}, error : function() {
			alert("실패");
		}
		
	});
}


function scrape() {
	//alert("스크랩");
	LpScrape();
}

var LpScrape = function(){
	var user_email = "130@happy.com";
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
</script>
</html>