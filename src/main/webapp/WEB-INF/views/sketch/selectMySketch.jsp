<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="happy.land.people.dto.LPSketchbookDto"%>
<%@page import="happy.land.people.dto.SketchPagingDto"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

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
<link href="./css/theme/checkradio.min.css" rel="stylesheet">

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
    	              		<div class="lp-content-header">
        	          			<h1 class="h2 mb-4 text-gray-800 lp-content-title">My Sketchbook</h1>
            	      			<input class="btn btn-danger mb-4 lp-sketch-del " type="submit" value="Delete selected">
		                  	</div>
                     		<div class="sketchBookContent">
								<c:forEach var="item" items="${mySketchBookLists}">
										<c:choose>
											<c:when test="${item.sketch_block eq 'T'}">
						                         <div class="single-sketchbook">
						                              <div class="single-sketch-img">
                                                           <div class="figure" onclick="goCanvas('${item.sketch_id}')">
                                                               <img class="test" alt="" src="${item.sketch_spath}">
                                                           </div>
														   <div style="color:red" ><i class="fas fa-heart"></i>${sketchLike[item.sketch_id]}</div>
														   <div> [ ${item.sketch_theme} ] ${item.sketch_title}</div>
						                                 </div>
						                              <div class="single-title">
                                                         <div class="field">
	                                                    	 <input class="is-checkradio is-info is-circle" id="chk+${item.sketch_id}"  value="${item.sketch_id}" type="checkbox" name="chkVal">
	                                                     	<label for="chk+${item.sketch_id}"></label>
	                                                  	 </div>
						                                  	<h5>관리자에 의해 삭제되었습니다.</h5>
						                                 	<label>${item.sketch_title}</label>
							                                <label>
							                                 	<a href="#" onclick="return sketchBookModify('${item.sketch_id}')">
							                                       <<i class="fas fa-pen-square"></i>
							                                    </a>
						                                	</label>
						                              </div>
						                           </div>
											</c:when>
											<c:otherwise>
											    <div class="single-sketchbook">
			                                       <div class="single-sketch-img figure">
                                                        <div class="sigle-box" onclick="goCanvas('${item.sketch_id}')">
                                                            <img class="sketch-img" alt="" src="${item.sketch_spath}">
                                                        </div>
                                                   </div>
												   <div class="sigle-title">
	                                                   <div class="field">
	                                                     <input class="is-checkradio is-info is-circle" id="chk+${item.sketch_id}"  value="${item.sketch_id}" type="checkbox" name="chkVal">
	                                                     <label for="chk+${item.sketch_id}"></label>
	                                                   </div>
                                                      <div>[ ${item.sketch_theme} ]</div>
                                                      <div>${item.sketch_title}</div>
                                                      <div onclick="return sketchBookModify('${item.sketch_id}')"><i class="fas fa-pen-square"></i></div>
                                                      <span class="badge badge-danger badge-counter hover-item">${sketchLike[item.sketch_id]} <i class="fas fa-heart"></i></span>
                                                   </div>
					                           </div>
											</c:otherwise>
										</c:choose>
								</c:forEach>
                     		</div>
                    	</form>
                     
                     <c:if test="${fn:length(mySketchBookLists) eq '9'}">
		                  <button id="infinityScroll">View more</button>
                     </c:if>
                  <!-- 여기까지 스케치북 수정 Modal -->
               </div><!-- 스케치북 정렬을 위한 lp-content-sketch -->
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
      </div>
   </div>
</div>

<script type="text/javascript">
var pageCnt = <%=pagingDto.getNowPageNo()%>
//var chkModify = false;
$("document").ready(
		function() {
			$("#infinityScroll").click(
					function() {
						$("#infinityScroll").hide();						
				if(pageCnt >= <%=pagingDto.getEndPageNo()%>){
					alert("마지막페이지 입니다.");
				}else{		
					pageCnt++;			
					getMySketchBook(pageCnt);
				}
			});
			
			
			$(".content").scroll(
					function(event){
				
						var hh = $(".content").height();
						var ee = $(".content").scrollTop();
						
						var scHeight = $(".content").prop('scrollHeight');
						
						if (scHeight - hh - ee < 1) {
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
            //alert(msg.addMySketchBook);    
            alert(msg.addMySketchBook.length);
            //alert(msg.likeMine);
            //alert(msg.mySketchNicknames);
            var sketchLikes = msg.likeMine;
            var mySketchNickname = msg.mySketchNicknames;
            
            //"<form action='#' method='post' id='sketchDel' name='sketchDel' onsubmit='return DelchkBox()'>"
               
               for(var i = 0 ; i <  parseInt(msg.addMySketchBook.length/3); i++){
                  
                  var sketchBookContainer = document.createElement('div');
                  sketchBookContainer.className = 'sketchBookContainer';
                  
                  for(var j = 0; j < 3; j++){
                     
                      var sketch_id=   msg.addMySketchBook[i*3+j].sketch_id;
                     
                     // 관리자에 의해 스케치북이 차단된 경우 sketch_block= 'T' 
                     if(msg.addMySketchBook[i*3+j].sketch_block.trim() == ('T')){   
                     sketchBookContainer.innerHTML += "<div style='width: 280px; height: 230px; border: 1px solid gray; display: inline-block; margin: 0 0 0 10px; position: relative;'>"+
                                                 "<div class='selectTheme' style='background-image: url("+msg.addMySketchBook[i*3+j].sketch_spath+")'>"+
                                                    "<div class='sketchTheme_hover' style=' cursor: pointer;'>"+
                                                       "<div class='hover_inside'>"+
                                                         "<h5>관리자에 의해 삭제되었습니다.</h5>"+
                                                       "</div>"+
                                                    "</div>"+
                                                 "</div>"+
                                                "<div style='width: 100%; height: 60px; border: 1px solid black; position: absolute; bottom: 0px;'>"+
                                                   "<input type='checkbox' name='chkVal' value='"+msg.addMySketchBook[i*3+j].sketch_id+"'>"+
                                                   "<label>"+msg.addMySketchBook[i*3+j].sketch_title+"</label>"+"<label style='float: right;'>"+mySketchNickname[(sketch_id)]+"</label><br>"+
                                                   "<label><a href='#' onclick='return sketchBookModify("+msg.addMySketchBook[i*3+j].sketch_id+")'><img alt='modi' src='img/sketch/modifyIcon.png'>스케치북 수정</a></label>"+
                                                "</div>"+
                                              "</div>";
                                                 
                     }else{
                     
                     // 관리자에 의해 스케치북이 차단되지 않은 경우 sketch_block= 'F'   
                     sketchBookContainer.innerHTML +="<div style='width: 280px; height: 230px; border: 1px solid gray; display: inline-block; margin: 0 0 0 10px; position: relative;'>"+
                                                "<div class='selectTheme' style='background-image: url("+msg.addMySketchBook[i*3+j].sketch_spath+")'>"+
                                                   "<div class='sketchTheme_hover' style=' cursor: pointer;' onclick='goCanvas("+msg.addMySketchBook[i*3+j].sketch_id+")'>"+
                                                      "<div class='hover_inside'>"+
                                                         "<h5><img alt='likeIcon' src='./img/sketch/likeIcon.png'>"+
                                                         sketchLikes[(sketch_id)]+""+msg.addMySketchBook[i*3+j].sketch_theme+"</h5>"+ 
                                                      "</div>"+
                                                   "</div>"+
                                                "</div>"+
                                                "<div style='width: 100%; height: 60px; border: 1px solid black; position: absolute; bottom: 0px;'>"+
                                                   "<input type='checkbox' name='chkVal' value='"+msg.addMySketchBook[i*3+j].sketch_id+"'>"+
                                                   "<label>"+msg.addMySketchBook[i*3+j].sketch_title+"</label>"+"<label style='float: right;'>"+mySketchNickname[(sketch_id)]+"</label><br>"+
                                                   "<label><a href='#' onclick='return sketchBookModify("+msg.addMySketchBook[i*3+j].sketch_id+")'><img alt='modi' src='img/sketch/modifyIcon.png'>스케치북 수정</a></label>"+
                                                "</div>"+
                                             "</div>";
                                             
                                             
                     
                     
                     }     
                     
                                             
                     }
                        $(".sketchBookContent").append(sketchBookContainer);
               
                  
               }                          
                     
               if(msg.addMySketchBook.length%3 !=0){ 
                  var sketchBookContainer = document.createElement('div');
                  sketchBookContainer.className = 'sketchBookContainer';      
               
                  for(var i = 0; i < msg.addMySketchBook.length%3; i++){                     
                           
                     var sketch_id= msg.addMySketchBook[parseInt(parseInt(msg.addMySketchBook.length/3)*3+i)].sketch_id;
                     
                     // 스케치북이 관리자에 의해 차단된 경우 sketch_block= 'T'
                     if(msg.addMySketchBook[parseInt(parseInt(msg.addMySketchBook.length/3)*3+i)].sketch_block.trim()== ('T')){     
                     sketchBookContainer.innerHTML += "<div style='width: 280px; height: 230px; border: 1px solid gray; display: inline-block; margin: 0 0 0 10px; position: relative;'>"+
                                                "<div class='selectTheme'  style='background-image: url(\""+msg.addMySketchBook[parseInt(parseInt(msg.addMySketchBook.length/3)*3+i)].sketch_spath+"\")'>"+
                                                   "<div class='sketchTheme_hover' style=' cursor: pointer;'>"+
                                                      "<div class='hover_inside'>"+
                                                         "<h5>관리자에 의해 삭제되었습니다.</h5>"+
                                                      "</div>"+
                                                   "</div>"+
                                                "</div>"+
                                                "<div style='width: 100%; height: 60px; border: 1px solid black; position: absolute; bottom: 0px;'>"+
                                                   "<input type='checkbox' name='chkVal' value='"+msg.addMySketchBook[parseInt(parseInt(msg.addMySketchBook.length/3)*3+i)].sketch_id+"'>"+
                                                   "<label>"+msg.addMySketchBook[parseInt(parseInt(msg.addMySketchBook.length/3)*3+i)].sketch_title+"</label>"+"<label style='float: right;'>"+mySketchNickname[(sketch_id)]+"</label><br>"+
                                                   "<label><a href='#' onclick='return sketchBookModify("+msg.addMySketchBook[parseInt(parseInt(msg.addMySketchBook.length/3)*3+i)].sketch_id+")'><img alt='modi' src='img/sketch/modifyIcon.png'>스케치북 수정</a></label>"+
                                                "</div>"+     
                                              "</div>";
                                              
                     }else{
                     
                     // 스케치북이 관리자에 의해 차단되지 않은 경우 sketch_block= 'F'
                     sketchBookContainer.innerHTML += "<div style='width: 280px; height: 230px; border: 1px solid gray; display: inline-block; margin: 0 0 0 10px; position: relative;'>"+
                                                "<div class='selectTheme' style='background-image: url("+msg.addMySketchBook[parseInt(parseInt(msg.addMySketchBook.length/3)*3+i)].sketch_spath+")'>"+
                                                   "<div class='sketchTheme_hover' style=' cursor: pointer;' onclick='goCanvas("+msg.addMySketchBook[parseInt(parseInt(msg.addMySketchBook.length/3)*3+i)].sketch_id+")'>"+
                                                      "<div class='hover_inside'>"+
                                                         "<h5><img alt='likeIcon' src='./img/sketch/likeIcon.png'>"+
                                                         sketchLikes[(sketch_id)]+""+msg.addMySketchBook[parseInt(parseInt(msg.addMySketchBook.length/3)*3+i)].sketch_theme+"</h5>"+ 
                                                      "</div>"+
                                                   "</div>"+
                                                "</div>"+
                                                "<div style='width: 100%; height: 60px; border: 1px solid black; position: absolute; bottom: 0px;'>"+
                                                   "<input type='checkbox' name='chkVal' value='"+msg.addMySketchBook[parseInt(parseInt(msg.addMySketchBook.length/3)*3+i)].sketch_id+"'>"+
                                                   "<label>"+msg.addMySketchBook[parseInt(parseInt(msg.addMySketchBook.length/3)*3+i)].sketch_title+"</label>"+"<label style='float: right;'>"+mySketchNickname[(sketch_id)]+"</label><br>"+
                                                   "<label><a href='#' onclick='return sketchBookModify("+msg.addMySketchBook[parseInt(parseInt(msg.addMySketchBook.length/3)*3+i)].sketch_id+")'><img alt='modi' src='img/sketch/modifyIcon.png'>스케치북 수정</a></label>"+
                                                "</div>"+
                                             "</div>";
                     
                                                                     
                              
                                          
                                          /* 원본 <div style='width: 280px; height: 230px; border: 1px solid gray; display: inline-block; margin: 0 0 0 10px; position: relative;'>"+
                                           "<div class='selectTheme'  style='background-image: url(\""+msg.addMySketchBook[parseInt(parseInt(msg.addMySketchBook.length/3)*3+i)].sketch_spath+"\")'>"+
                                              "<div class='sketchTheme_hover' onclick='goCanvas("+msg.addMySketchBook[parseInt(parseInt(msg.addMySketchBook.length/3)*3+i)].sketch_id+")'>"+
                                                 "<div class='hover_inside'>"+
                                                    "<div>"+"<a href='#' onclick='return sketchBookModify("+msg.addMySketchBook[parseInt(parseInt(msg.addMySketchBook.length/3)*3+i)].sketch_id+")'><img alt='modi' src='img/sketch/modifyIcon.png'></a>"+"</div>"+
                                                    "<span>"+msg.addMySketchBook[parseInt(parseInt(msg.addMySketchBook.length/3)*3+i)].sketch_title+"</span>"+"<h5>"+"<img alt='likeIcon' src='./img/sketch/likeIcon.png'>"+
                                                    sketchLikes[(sketch_id)]+"</h5>"+"<h5>"+msg.addMySketchBook[parseInt(parseInt(msg.addMySketchBook.length/3)*3+i)].sketch_theme+""+mySketchNickname[(sketch_id)]+"</h5>"+
                                                    "</div>"+
                                                "</div>"+
                                              "</div>"+
                                           "</div>"+
                                        "</div>" */
                                          
                     
                     
                     }
                                             
                  }
						$(".sketchBookContent").append(sketchBookContainer);
									
					}		
					
					
			}, error : function() {
				alert("실패");
			}
		});
	
}
//-------------------- 작성 스케치북 수정 모달 생성 --------------------
function sketchBookModify(sketch) {
	var user_email = "${ldto.user_email}"
	var sketch_id = sketch;
	alert(user_email);
	alert(sketch_id);
	ajaxSketchModi(user_email, sketch_id);
	$("#sketchModiForm").modal();
}
   var ajaxSketchModi = function(user_email, sketch_id){
// alert(user_email);
// var user_email 
   $.ajax({
      url : "sketchModifyForm.do",
      type : "post",
      data : { "user_email" : user_email,
             "sketch_id"  :   sketch_id },
      dataType : "json",
      success :function(modiModal){
         //alert(modiModal.sdto.sketch_title);
         //alert(modiModal.sdto.sketch_id);
         
         alert(modiModal.sdto.sketch_share);
         //alert(modiModal.sdto.user_email);
         //alert(modiModal.sdto.sketch_theme);
         //alert(modiModal.sdto.sketch_spath);
         
         var modiFormHTML =   "<input type='hidden' name='user_email' value='"+modiModal.sdto.user_email+"'>"+
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
                  + "<input type='radio' id='coupletheme' name='sketch_theme' value='연인과함께'><label for='coupletheme'>연인과함께</label>"
                  + "<input type='radio' id='friendtheme' name='sketch_theme' value='친구와함께'><label for='friendtheme'>친구와함께</label></div>"
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
                  
                  
                  "<div class='form-group'>"+
                  "<label>스케치북 커버이미지</label>&nbsp;<label style='color: red;'>(커버이미지를 변경하지 않으시면 기존 이미지가 입력됩니다)</label>"+
                              "<div id='moSketchBookCover'>"+
                                    "<div id='modalIMG1' style='background-image :url("+modiModal.sdto.sketch_spath+")'>"+
                                    "<input type='hidden' name='sketch_spath' class='img_spath0'>"+
                                          "<label for='C_IMG1'><img src='./img/folder.png'></label>"+
                                          "<input id='C_IMG1' class='file'  name='file' type='file' multiple='multiple' style='display: none;'>"+
                                    "</div>"+
                              "</div>"+
                   "</div>"+
         
                  "<div class='modal-footer'>"
                  + "<input class='btn btn-success' type='button' value='수정완료 ' onclick='sketchModify()'>"
                  + "<button type='button' class='btn btn-default' data-dismiss='modal'>닫기</button>"
                  + "</div>";
               $("#modiSketchBook").html(modiFormHTML);
               
               
               $('input:radio[name=sketch_theme]:input[value='+modiModal.sdto.sketch_theme+']').attr("checked", true);
               $("input:radio[name='sketch_share'][value="+ modiModal.sdto.sketch_share +"]").prop('checked', true);
					$("input[id=C_IMG1]").change(function(){
						var imgClass = $(this).attr("id");
						subImgClass = imgClass.substring(imgClass.indexOf('_')+1);
						if(extension($("input[id="+imgClass+"]").val())){
							fileUpload(subImgClass);
						}
										
					});
					
					
					
		}, error : function(){
			alert("실패");
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
function fileUpload(subImgClass) {
	var frmEle = document.forms[1];
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
					var img_spath = $("input[class=img_spath0]");
					img_spath.val(result);
		},error : function(){
			alert("실패");
		}
	});
}
	
//-------------------- 작성 스케치북 수정  --------------------
function sketchModify(){
   //var img= img;
   //chkModify = true;
   var img = $("div[id=modalIMG1]").css("background-image")
   img =img.replace('url(','').replace(')','').replace(/\"/gi, "");
   alert(img);
   
   
   
   var sketchModiModal = document.getElementById("modiSketchBook");
   var sketch_theme = $("input[name=sketch_theme]:checked").val();
   var sketch_share = $("input[name=sketch_share]:checked").val();
   var sketchConver = $("input[class=img_spath0]").val();
   sketchModiModal.action = "./modifySketch.do";
   
   
   var title = $("#sketchtitle").val();
   var theme = $("input[name=sketch_theme]:checked").length;
   var share = $("input[name=sketch_share]:checked").length;
   
   
   
   
   
	
	
	if (title == "") {
		alert("스케치북 제목을 확인해주세요");
	} else if(theme == 0 || share == 0 ){
		alert("스케치북 타입 혹은 공유 여부를 선택해주세요");	
	} else if (title.length >= 20) {
		alert("스케치북의 제목이 너무 깁니다");
		$("#sketchtitle").val("");
	} else if(sketchConver == null||sketchConver == ""){
		//alert("커버이미지를 수정하지 않으시면 기존 이미지가 입력됩니다")
	
		var img_spath = $("input[class=img_spath0]").val(img);
		alert(img_spath);
		
		sketchModiModal.submit();
		alert("스케치북 수정완료");
	} else {
		sketchModiModal.submit();
		alert("스케치북 수정완료");
		//chkModify = false;
	}
}
//-------------------- 작성 스케치북 수정  --------------------
//------------------- 작성 스케치북 완전 다중 삭제 ----------------- 
function DelchkBox(){
	alert("작동");
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
