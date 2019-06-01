<%@page import="happy.land.people.dto.SketchPagingDto"%>
<%@page import="happy.land.people.dto.LPSketchbookDto"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="happy.land.people.dto.cho.ChoDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%		
		SketchPagingDto pagingDto = (SketchPagingDto)request.getAttribute("pagingDto");	
		ChoDto ldto = (ChoDto) session.getAttribute("ldto");
	    Map<String,Integer> sketchLike = ( Map<String,Integer> )request.getAttribute("sketchLike");
	    Map<String,Integer> sketchLikes = ( Map<String,Integer> )request.getAttribute("sketchLikes");
	    List<LPSketchbookDto> mySketchBookLists = (List<LPSketchbookDto>)request.getAttribute("mySketchBookLists");
	    Map<String,String> mySketchNickname = (Map<String,String>)request.getAttribute("mySketchNickname");
%> 
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>작성 스케치북 조회 페이지</title>
</head>

<script src="./js/jquery-3.3.1.js"></script>
<link rel="stylesheet" href="./css/lp-style.css">
<link rel="stylesheet" href="./css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

<script type="text/javascript">
$(document).ready(function() {
	

	$("#checkAll").click(function (){
		alert("123");
	var chks =  document.getElementsByName("chkVal");
	//	alert(chks.length);
	for (var i = 0; i < chks.length; i++) {
		chks[i].checked = this.checked;
	}
	});
});


	

</script>




	<body>
<%-- 	${pagingDto}
	${mySketchBookLists}
	${likeCnt}
	${sketchLike}
	${sketchNickname} --%>
<!--젤로 레이아웃- 전체 영역 감싸는 div-->
	<div class="main-wrapper">
		<%@include file="../common/Sidebar.jsp"%>
		<div class="content-wrapper">
			
			<!-- 메인 컨텐츠   -->
			<div class="lpcontents">
				<div class="content" style="overflow-x: hidden;">
					<!-- <div class="sketchBookContent"> -->
					<% 
					for(int i =0; i < mySketchBookLists.size()/3 ; i++ ) { 
					%>
						<div class="sketchBookContainer">
					
					<% 
						for(int j = 0 ; j <  3 ; j++){ 
						
						String sketch_id =	mySketchBookLists.get(i*3+j).getSketch_id();	
					%>
							<div class="selectTheme" style="background-image: url('<%=mySketchBookLists.get(i*3+j).getSketch_spath()%>');">
								<% 
								if(mySketchBookLists.get(i*3+j).getSketch_block().trim().compareToIgnoreCase("T")==0){
									 %> 
										 <div class="sketchTheme_hover" style=" cursor: pointer;"><div class="hover_inside"><h5>관리자에 의해 삭제되었습니다.</h5></div></div>
									 <%
								}else{
									%>
								
									 <div class="sketchTheme_hover" style=" cursor: pointer;"><%-- onclick="location.href='./kim.do?sketch_id=<%=mySketchBookLists.get(i*3+j).getSketch_id()%>' --%>
										 <a href="#" onclick="location.href='./kim.do?sketch_id=<%=mySketchBookLists.get(i*3+j).getSketch_id()%>'">
										 <div class="hover_inside">
											<div><a href="#" style="z-index: 100; position: relative;" onclick="return sketchBookModify('<%=mySketchBookLists.get(i*3+j).getSketch_id()%>')"><img alt="modi" src="img/sketch/modifyIcon.png"></a></div>
											<span><%=mySketchBookLists.get(i*3+j).getSketch_title()%> </span>
											<h5><img alt="likeIcon" src="./img/sketch/likeIcon.png">
											<%=sketchLike.get(sketch_id) %> <%=mySketchBookLists.get(i*3+j).getSketch_theme()%> <%=mySketchNickname.get(sketch_id) %> </h5>
											</div>
										</a>	
									</div> 
									<%
								}
								%>
							</div>
							
					<%
						}
					%>
						</div>
					
					<%
						}
					%>
					
					
					<% 
						if(mySketchBookLists.size()%3 !=0){ 
						
					%>
						<div class="sketchBookContainer">
					
					<% for(int i = 0 ; i < mySketchBookLists.size()%3 ; i++){
						String sketch_id = mySketchBookLists.get((mySketchBookLists.size()/3)*3+i).getSketch_id();	
					%>
							<div class="selectTheme" style="background-image: url('<%=mySketchBookLists.get((mySketchBookLists.size()/3)*3+i).getSketch_spath()%>');">
								<% 
								if(mySketchBookLists.get((mySketchBookLists.size()/3)*3+i).getSketch_block().trim().compareToIgnoreCase("T")==0){
									 %> 
										<div class="sketchTheme_hover" style=" cursor: pointer;"><div class="hover_inside"><h5>관리자에 의해 삭제되었습니다.</h5></div></div>
									 <%
								}else{
									%>
										<div class="sketchTheme_hover"  style="cursor: pointer;" onclick="location.href='./kim.do?sketch_id=<%=mySketchBookLists.get((mySketchBookLists.size()/3)*3+i).getSketch_id()%>'">
											<div class="hover_inside">
												<div ><a href="#" style="z-index: 100; position: relative;" onclick="return sketchBookModify('<%=mySketchBookLists.get((mySketchBookLists.size()/3)*3+i).getSketch_id()%>')"><img alt="modi" src="img/sketch/modifyIcon.png"></a></div> 
												<span><%=mySketchBookLists.get((mySketchBookLists.size()/3)*3+i).getSketch_title()%></span>
												<h5><img alt="likeIcon" src="./img/sketch/likeIcon.png">
												<%=sketchLike.get(sketch_id)%> <%=mySketchBookLists.get((mySketchBookLists.size()/3)*3+i).getSketch_theme()%> <%=mySketchNickname.get(sketch_id) %></h5>
											</div>
										</div>
									<%
								}
								%>
							</div>
							
					<%
						}
					%>
						</div>
					
					<%
						}
					%>
					
				
					
					<!-- </div> -->			
					
					
					
					
					
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
					<!-- 여기까지 스케치북 수정 Modal -->
					
					
					
					<button id="infinityScroll" style="width: 100%;">더보기</button>	
				</div>
			</div>
			<!-- </div> 여기까지 메인 컨텐츠  -->
			<div class="footer">landpeople</div>
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
					
				
						
						for(var i = 0 ; i <  parseInt(msg.addMySketchBook.length/3); i++){
							
							var sketchBookContainer = document.createElement('div');
							sketchBookContainer.className = 'sketchBookContainer';
							
							for(var j = 0; j < 3; j++){
								
								 var sketch_id=	msg.addMySketchBook[i*3+j].sketch_id;
								
								// 스케치북이 관리자에 의해 차단된 경우 sketch_block= 'T' 
								if(msg.addMySketchBook[i*3+j].sketch_block.trim() == ('T')){	
								sketchBookContainer.innerHTML += "<div class='selectTheme' style='background-image: url("+msg.addMySketchBook[i*3+j].sketch_spath+")'>"+
																 "<div class='sketchTheme_hover' style=' cursor: pointer;'>"+
								     							 "<div class='hover_inside'>"+
																 "<h5>관리자에 의해 삭제되었습니다.</h5>"+
																 "</div></div></div>";
																	 
								}else{
								
								// 스케치북이 관리자에 의해 차단되지 않은 경우 sketch_block= 'F'	
								sketchBookContainer.innerHTML +=  "<div class='selectTheme' style='background-image: url("+msg.addMySketchBook[i*3+j].sketch_spath+")'>"+
																	"<div class='sketchTheme_hover' style=' cursor: pointer;' onclick='goCanvas("+msg.addMySketchBook[i*3+j].sketch_id+")'>"+
																	"<div class='hover_inside'>"+
																	"<div>"+"<a href='#' style='z-index: 100; position: relative;' onclick='return sketchBookModify("+msg.addMySketchBook[i*3+j].sketch_id+")'><img alt='modi' src='img/sketch/modifyIcon.png'></a>"+"</div>"+
																	"<span>"+msg.addMySketchBook[i*3+j].sketch_title+"</span>"+"<h5>"+"<img alt='likeIcon' src='./img/sketch/likeIcon.png'>"+
																	sketchLikes[(sketch_id)]+"</h5>"+"<h5>"+msg.addMySketchBook[i*3+j].sketch_theme+""+mySketchNickname[(sketch_id)]+"</h5>"+
																	"</div></div></div>";
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
								sketchBookContainer.innerHTML += "<div class='selectTheme'  style='background-image: url(\""+msg.addMySketchBook[parseInt(parseInt(msg.addMySketchBook.length/3)*3+i)].sketch_spath+"\")'>"+
																 "<div class='sketchTheme_hover' style=' cursor: pointer;'>"+
																 "<div class='hover_inside'>"+
																 "<h5>관리자에 의해 삭제되었습니다.</h5>"+
																 "</div></div></div>";
																 
								}else{
								
								// 스케치북이 관리자에 의해 차단되지 않은 경우 sketch_block= 'F'		
								sketchBookContainer.innerHTML += "<div class='selectTheme'  style='background-image: url(\""+msg.addMySketchBook[parseInt(parseInt(msg.addMySketchBook.length/3)*3+i)].sketch_spath+"\")'>"+
									  							"<div class='sketchTheme_hover' onclick='goCanvas("+msg.addMySketchBook[parseInt(parseInt(msg.addMySketchBook.length/3)*3+i)].sketch_id+")'>"+
																"<div class='hover_inside'>"+
																"<div>"+"<a href='#' style='z-index: 100; position: relative;' onclick='return sketchBookModify("+msg.addMySketchBook[parseInt(parseInt(msg.addMySketchBook.length/3)*3+i)].sketch_id+")'><img alt='modi' src='img/sketch/modifyIcon.png'></a>"+"</div>"+
																"<span>"+msg.addMySketchBook[parseInt(parseInt(msg.addMySketchBook.length/3)*3+i)].sketch_title+"</span>"+"<h5>"+"<img alt='likeIcon' src='./img/sketch/likeIcon.png'>"+
																sketchLikes[(sketch_id)]+"</h5>"+"<h5>"+msg.addMySketchBook[parseInt(parseInt(msg.addMySketchBook.length/3)*3+i)].sketch_theme+""+mySketchNickname[(sketch_id)]+"</h5>"+
																"</div>"+
																"</div></div></div>";
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
//		alert(user_email);
//		var user_email 
		$.ajax({
			url : "sketchModifyForm.do",
			type : "post",
			data : { "user_email" : user_email,
					 "sketch_id"  :	sketch_id },
			dataType : "json",
			success :function(modiModal){
				//alert(modiModal.sdto.sketch_title);
				//alert(modiModal.sdto.sketch_id);
				
				alert(modiModal.sdto.sketch_share);
				//alert(modiModal.sdto.user_email);
				//alert(modiModal.sdto.sketch_theme);
				//alert(modiModal.sdto.sketch_spath);
				
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
							"<label>스케치북 커버이미지</label>"+
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
			alert("커버이미지를 수정하지 않으시면 기존 이미지가 입력됩니다")
		
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
			var sketchDelChk = confirm("스케치북을 삭제하시겠습니까?");
			if(sketchDelChk == true){
			
				var doc = document.sketchDel;
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
	
	</body>

</html>