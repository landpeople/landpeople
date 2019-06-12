<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="happy.land.people.dto.LPSketchbookDto"%>
<%@page import="happy.land.people.dto.SketchPagingDto"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%
	SketchPagingDto pagingDto = (SketchPagingDto) request.getAttribute("pagingDto");
	Map<String, Integer> sketchLike = (Map<String, Integer>) request.getAttribute("sketchLike");
	Map<String, Integer> sketchLikes = (Map<String, Integer>) request.getAttribute("sketchLikes");
	List<LPSketchbookDto> mySketchBookLists = (List<LPSketchbookDto>) request.getAttribute("mySketchBookLists");
	Map<String, String> mySketchNickname = (Map<String, String>) request.getAttribute("mySketchNickname");
%>

<!DOCTYPE html>
<html lang="en">

<head>
<link rel="shortcut icon" href="./img/favicon.ico" type="image/x-icon">
<link rel="icon" href="./css/theme/sb-admin-2.css" type="image/x-icon">

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="LandPeople">

<title>제주도 여행 일정 공유 커뮤니티 | 육지사람</title>

<!-- Custom fonts for this template-->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

<link rel="stylesheet" type="text/css" href="./css/sweetalert.css">

<!-- Custom styles for this template-->
<link href="./css/theme/sb-admin-2.css" rel="stylesheet">
<link href="./css/theme/lp-template.css" rel="stylesheet">
<link href="./css/sketch/sketch.css" rel="stylesheet">
<link href="./css/sketch/modal.css" rel="stylesheet">
<link href="./css/theme/checkradio.css" rel="stylesheet">

</head>

<script src="./js/theme/jquery.min.js"></script>

<body id="page-top" class="scroll">

	<!-- Page Wrapper -->
	<div id="wrapper">
		<%@include file="../common/lp-sidebar.jsp"%>

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">
			<!-- flex 레이아웃 content와 푸터 정렬 -->

			<!-- Main Content -->
			<div id="content">
				<!-- LandPeople Content Area -->
				<div class="lp-container">
					<div class="lp-content shadow-lg">
						<div class="lp-content-sketch">
							<form action="#" method="post" id="sketchDel" name="sketchDel" onsubmit="return DelchkBox()">
                                <input type="hidden" name="user_email" value="${ldto.user_email}">
								<div class="lp-content-header">
									<h1 class="h2 mb-4 text-gray-800 lp-content-title">My Sketchbook</h1>
									<div>
									<input class="btn btn-success mb-4 lp-sketch-del" id="topBtn" type="button" value="Move to top">
									<input class="btn btn-danger mb-4 lp-sketch-del " type="submit" value="Delete selected">
									</div>
								</div>
								<div class="sketckBookScroll scroll">
									<div class="sketchBookContent">
										<c:forEach var="item" items="${mySketchBookLists}">
											<c:choose>
												<c:when test="${item.sketch_block eq 'T'}">
													<div class="single-sketchbook">
														<div class="hovereffect1">
															<img class="img-responsive" src="${item.sketch_spath}" alt="">
															<div class="overlay1">
																<input class="is-checkradio is-info is-circle" id="chk${item.sketch_id}" value="${item.sketch_id}" type="checkbox" name="chkVal">
																<label class="lp-check-box" for="chk${item.sketch_id}"></label>
																<h1>[ ${item.sketch_theme} ]</h1>
																<h2>This post has been deleted by admin.</h2>
																<p class="modify-icon">
																	<a href="#" onclick="return sketchBookModify('${item.sketch_id}')"> <i class="fas fa-pen-square"></i>
																	</a>
																</p>
																<p>
																	<a href="#" onclick="goCanvas('${item.sketch_id}')">Show detail</a>
																</p>
															</div>
														</div>
													</div>
												</c:when>
												<c:otherwise>
													<div class="single-sketchbook">
														<div class="hovereffect1">
															<img class="img-responsive" src="${item.sketch_spath}" alt="">
															<div class="overlay1">
																<input class="is-checkradio is-info is-circle" id="chk${item.sketch_id}" value="${item.sketch_id}" type="checkbox" name="chkVal"> <label class="lp-check-box" for="chk${item.sketch_id}"></label>
																<h1>[ ${item.sketch_theme} ]</h1>
																<h2>${item.sketch_title} | <i class="fas fa-heart"></i><span> ${sketchLike[item.sketch_id]}명</span>
																</h2>
																<p class="modify-icon">
																	<a href="#" onclick="return sketchBookModify('${item.sketch_id}')"> <i class="fas fa-pen-square"></i>
																	</a>
																</p>
																<p>
																	<a href="#" onclick="goCanvas('${item.sketch_id}')">Show detail</a>
																</p>
															</div>
														</div>
													</div>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</div>
								</div>
							</form>

							<c:if test="${fn:length(mySketchBookLists) eq '9'}">
								<div class="view-more">
									<button id="infinityScroll" class="view-btn">View more</button>
								</div>
							</c:if>
							<!-- 여기까지 스케치북 수정 Modal -->
						</div>
						<!-- 스케치북 정렬을 위한 lp-content-sketch -->
					</div>
				</div>
				<!--End of Page LandPeople Content Area -->
				<%@include file="../common/lp-footer.jsp"%>
				<!-- End of Page Wrapper -->
			</div>
		</div>
	</div>
</body>

<!-- 스케치북 수정 Modal -->
<div class="modal fade" id="sketchModiForm" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">Edit sketchbook</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			<div class="modal-body">
				<form action="#" role="form" method="post" id="modiSketchBook"></form>
			</div>
            <div class="modal-footer">
				<form action="#" role="form" method="post" id="modiSketchFooter"></form>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">

var pageCnt = <%=pagingDto.getNowPageNo()%>

$("document").ready(
	function() {
		$("#topBtn").hide();
		$("#infinityScroll").click(
			function() {
				$("#infinityScroll").hide();						
				$("#topBtn").show();						
				if(pageCnt >= <%=pagingDto.getLastPageNo()%>){
				}else{		
					pageCnt++;			
					getMySketchBook(pageCnt);
				}
			});
		
		$(".sketckBookScroll").scroll(
			function(event){
				  var scrollT = $(this).scrollTop(); //스크롤바의 상단위치
			      var scrollH = $(this).height(); //스크롤바를 갖는 div의 높이
			      var contentH = $('.sketchBookContent').height(); //문서 전체 내용을 갖는 div의 높이
			    
			      if(scrollT + scrollH + 1.5 >= contentH) { // 스크롤바가 맨 아래에 위치할 때
			      	 $("#infinityScroll").trigger("click");
			      }
			});
		});
	
function getMySketchBook(pageNo){      
   var user_email = "${ldto.user_email}"
   var sketchLikes = "${sketchLikes}"
      $.ajax({
         url: "mysketchBookPaging.do",
         type: "get",
         data: {"pageNo": pageNo , "user_email" : user_email}, 
         dataTypes: "json",
         success: function(msg){
		 	var sketchLikes = msg.likeMine;
			var mySketchNickname = msg.mySketchNicknames;
      		var sketch = "";
      		
      			for(var i = 0 ; i <  parseInt(msg.addMySketchBook.length); i++){
      				var sketch_id=	msg.addMySketchBook[i].sketch_id;
      				
            		if(msg.addMySketchBook[i].sketch_block.trim() == ('T')){// 관리자에 의해 스케치북이 차단된 경우 sketch_block= 'T' 
            			sketch += "<div class='single-sketchbook'>" +
            			 		  	 "<div class='hovereffect1'>" +
            			 	    		 "<img class='img-responsive' src=" + msg.addMySketchBook[i].sketch_spath + ">" +
            			 	        		 "<div class='overlay1'>" +
            			 	        	     	"<input class='is-checkradio is-info is-circle' id='chk" + msg.addMySketchBook[i].sketch_id + "' value=" + msg.addMySketchBook[i].sketch_id + " type='checkbox' name='chkVal'>" +
            			 	            	 	"<label class='lp-check-box' for='chk" + msg.addMySketchBook[i].sketch_id + "'></label>" +
            			 	            		"<h1>[ " + msg.addMySketchBook[i].sketch_theme + " ]</h1>" +
            			 	            		"<h2>This post has been deleted by admin.</h2>" +
            			 						"<p class='modify-icon'>" +
            			 						"<a href='#' onclick='return sketchBookModify(" + msg.addMySketchBook[i].sketch_id + ")'>" +
            			 							"<i class='fas fa-pen-square'></i>" +
            			 	         			"</a>" +
            			 	         			"</p>" +
            			 						"<p>" +
            			 						"<a href='#' onclick='goCanvas(" + msg.addMySketchBook[i].sketch_id + ")'>Show detail</a>" +
            			 						"</p>" +
            			 	         		"</div>" +
            			 	 			"</div>" +
            			 			"</div>";								 
            			}else{
            				sketch += "<div class='single-sketchbook'>" +
                           	 		"<div class='hovereffect1'>" +
                           	 	   		"<img class='img-responsive' src=" + msg.addMySketchBook[i].sketch_spath + ">" +
                           	 	    	"<div class='overlay1'>" +
	                           	 	    	"<input class='is-checkradio is-info is-circle' id='chk" + msg.addMySketchBook[i].sketch_id + "' value=" + msg.addMySketchBook[i].sketch_id + " type='checkbox' name='chkVal'>" +
	                           	 	       	"<label class='lp-check-box' for='chk" + msg.addMySketchBook[i].sketch_id + "'></label>" +
	                           	 	    	"<h1>[ " + msg.addMySketchBook[i].sketch_theme + " ]</h1>" +
	                           	 	    	"<h2>" + msg.addMySketchBook[i].sketch_title + " | <i class='fas fa-heart'></i><span>" + sketchLikes[msg.addMySketchBook[i].sketch_id] + "명</span></h2>" +
	                           	 			"<p class='modify-icon'>" +
	                           	 			"<a href='#' onclick='return sketchBookModify(" + msg.addMySketchBook[i].sketch_id + ")'>" +
	                           	 			"<i class='fas fa-pen-square'></i>" +
	                           	 	    	"</a>" +
	                           	 	    	"</p>" +
	                           	 		"<p>" +
	                           	 		"<a href='#' onclick='goCanvas(" + msg.addMySketchBook[i].sketch_id + ")'>Show detail</a>" +
	                           	 		"</p>" +
                           	 	     	"</div>" +
                           	 	 	"</div>" +
                  	 	        "</div>";								
         					}		
      				}
      					$(".sketchBookContent").append(sketch);
      			}, error : function() {
//       				alert("실패");
      			}
      	});
}

var topEle = $('#topBtn');
var delay = 1000;
topEle.on('click', function() {
  $('.sketckBookScroll').animate({scrollTop: 0}, delay);
});

//-------------------- 작성 스케치북 수정 모달 생성 --------------------
function sketchBookModify(sketch) {
	var user_email = "${ldto.user_email}"
	var sketch_id = sketch;
// 	alert(user_email);
// 	alert(sketch_id);
	ajaxSketchModi(user_email, sketch_id);
	$("#sketchModiForm").modal();
}
   var ajaxSketchModi = function(user_email, sketch_id){
   $.ajax({
      url : "sketchModifyForm.do",
      type : "post",
      data : { "user_email" : user_email,
             "sketch_id"  :   sketch_id },
      dataType : "json",
      success :function(modiModal){
//          alert(modiModal.sdto.sketch_theme.replace(' ',''));
         
         var modiFormHTML =   "<input type='hidden' name='user_email' value='"+modiModal.sdto.user_email+"'>"+
                        "<input type='hidden' name='sketch_id' value='"+modiModal.sdto.sketch_id+"'>"+
                  
                   "<div class='form-group'>"
                  + "<label>스케치북 제목</label>"
                  + "<div class='modal-input'>"
                  + "<input type='text' class='form-control' id='modiSketchTitle' name='sketch_title' value='"+modiModal.sdto.sketch_title+"' style='width : 400px;' required='required'></div>"
                  + "</div>"
                  +
         
                  "<div class='form-group'>"
                  + "<label>스케치북 테마</label>"
                  + "<div class='themeradio'>"
                  + "<input type='radio' id='solotheme' name='modiSketch_theme' value='Withme'><label for='solotheme'>With me</label>"
                  + "<input type='radio' id='familytheme' name='modiSketch_theme' value='Withfamily'><label for='familytheme'>With famliy</label>"
                  + "<input type='radio' id='coupletheme' name='modiSketch_theme' value='Withlove'><label for='coupletheme'>With love</label>"
                  + "<input type='radio' id='friendtheme' name='modiSketch_theme' value='Withfriend'><label for='friendtheme'>With friend</label></div>"
                  + "</div>"
                  +
         
                  "<div class='form-group'>"
                  +"<label>스케치북 공유여부</label>"
                  +"<div class='themeradio'>"
                  +"<input type='radio' id='sketchShareY' name='modiSketch_share' value='Y'><label for='sketchShareY'>Y</label>"
                  +"<input type='radio' id='sketchShareN' name='modiSketch_share' value='N'><label for='sketchShareN'>N</label>"
                  +"</div>"
                  +"</div>"
                  +
                  
                  "<div class='form-group'>"+
                  "<label>스케치북 커버이미지</label>&nbsp;<label style='color: red;'>(커버이미지를 변경하지 않으시면 기존 이미지가 입력됩니다)</label>"+
                              "<div id='moSketchBookCover'>"+
                                    "<div id='modalIMG2' style='background-image :url("+modiModal.sdto.sketch_spath+")'>"+
                                    "<input type='hidden' name='sketch_spath' class='img_spath0'>"+
                                          "<label for='C_IMG2' id='C_IMG1-label'><i class='fas fa-file-image'></i></label>"+
                                          "<input id='C_IMG2' class='file'  name='file' type='file' multiple='multiple' style='display: none;'>"+
                                    "</div>"+
                              "</div>"+
                   "</div>";
         
                  var modalFooter = "<button type='button' class='btn btn-secondary modal-close' data-dismiss='modal'>닫기</button>" +
                  						 "<input class='btn btn-lp-success' type='button' value='수정완료 ' onclick='sketchModify()'>";
                  					
               $("#modiSketchBook").html(modiFormHTML);
               $('#modiSketchFooter').html(modalFooter);
               
               $('input:radio[name=modiSketch_theme]:input[value='+modiModal.sdto.sketch_theme.replace(' ','')+']').attr("checked", true);
               $("input:radio[name='modiSketch_share'][value="+ modiModal.sdto.sketch_share +"]").prop('checked', true);
					$("input[id=C_IMG2]").change(function(){
						var imgClass = $(this).attr("id");
						subImgClass = imgClass.substring(imgClass.indexOf('_')+1);
						if(extension($("input[id="+imgClass+"]").val())){
							modiFileUpload(subImgClass);
						}
					});
		}, error : function(){
// 			alert("실패");
		}
	});
	
}
//-------------------- 작성 스케치북 수정 모달 생성 --------------------
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
function modiFileUpload(subImgClass) {
	var frmEle = document.getElementById("modiSketchBook");  
	var formData = new FormData(frmEle);
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
//    			alert("아작스 결과"+result);
   					$("div[id=modalIMG2]").css("background-image", "url('" + result+ "')");
   					var img_spath = $("input[class=img_spath0]");
   					img_spath.val(result);
   		},error : function(){
//    			alert("실패");
   		}
   	});
   }
	
//-------------------- 작성 스케치북 수정  --------------------
function sketchModify(){
   //var img= img;
   //chkModify = true;
   var email = '${ldto.user_email}';
   var img = $("div[id=modalIMG2]").css("background-image")
   img =img.replace('url(','').replace(')','').replace(/\"/gi, "");
//    alert(img);
   
   var sketchModiModal = document.getElementById("modiSketchBook");
   var modiSketch_theme = $("input[name=modiSketch_theme]:checked").val();
   var modiSketch_share = $("input[name=modiSketch_share]:checked").val();
   var sketchConver = $("input[class=img_spath0]").val();
   sketchModiModal.action = "./modifySketch.do?user_email"+ email;
   
   
   var title = $("#modiSketchTitle").val();
   var theme = $("input[name=modiSketch_theme]:checked").length;
   var share = $("input[name=modiSketch_share]:checked").length;

   if (title == "") {
		alert("스케치북 제목을 확인해주세요");
	} else if(theme == 0 || share == 0 ){
		alert("스케치북 타입 혹은 공유 여부를 선택해주세요");	
	} else if (title.length >= 20) {
		alert("스케치북의 제목이 너무 깁니다");
		$("#modiSketchTitle").val("");
	} else if(sketchConver == null||sketchConver == ""){
		//alert("커버이미지를 수정하지 않으시면 기존 이미지가 입력됩니다")
	
		var img_spath = $("input[class=img_spath0]").val(img);
// 		alert(img_spath);
		
		sketchModiModal.submit();
// 		alert("스케치북 수정완료");
	} else {
		sketchModiModal.submit();
// 		alert("스케치북 수정완료");
		//chkModify = false;
	}
}
//-------------------- 작성 스케치북 수정  --------------------
//------------------- 작성 스케치북 완전 다중 삭제 ----------------- 
function DelchkBox(){
// 	alert("작동");
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
		var sketchDelChk = confirm("작성하신 일정, 자유 캔버스 내용이 함께 삭제됩니다.\n선택한 스케치북을 삭제하시겠습니까?");
		if(sketchDelChk == true){
		
			var doc = document.sketchDel;
			doc.action = "./sketchMultiDelete.do";
			
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
//테마별, 작성, 스크랩  스케치북 조회 무한스크롤 후 캔버스 조회 페이지로 이동
function goCanvas(sketch_id) {
	//alert(sketch_id);
	location.href="./detailCanvas.do?sketch_id="+sketch_id;
}
</script>
</html>
