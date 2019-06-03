<%@page import="happy.land.people.dto.LPTextDto"%>
<%@page import="happy.land.people.dto.LPCanvasDto"%>
<%@page import="java.util.Map"%>
<%@page import="happy.land.people.dto.LPDaysDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>김태우 화면 테스트</title>
<%
	Map<Integer,List<LPDaysDto>>  daysList = (Map<Integer,List<LPDaysDto>>)request.getAttribute("daysList");
	List<LPCanvasDto>	 canvasList = 	(List<LPCanvasDto>)request.getAttribute("daysType");
	Map<Integer,List<LPTextDto>> textList = (Map<Integer,List<LPTextDto>>)request.getAttribute("textList");
%>

<script src="./js/jquery-3.3.1.js"></script>

<!-- 책모양  -->
<script src="./js/jquery-ui.js"></script>
<script src="./js/jquery.easing.1.3.js"></script>
<script src="./js/jquery.booklet.latest.min.js"></script>
<link href="./css/jquery.booklet.latest.css" type="text/css" rel="stylesheet" media="screen, projection, tv" />

<script src="./js/min/plugins.min.js"></script>
<script src="./js/min/main.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

<!-- 카카오 지도를 위한 js파일 -->
<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=559fa9d8ea227159941f35acba720d2b&libraries=services"></script>

<!-- 자유 캔버스 레이아웃  -->
<link rel="stylesheet" href="css/freeCanvasLayout.css">
<!-- font awesome -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">

<style type="text/css">
.insertForms{	
	margin-bottom: 30px;
	margin-top: 30px;
	margin-left : 15px;
	margin-right : 15px;
	width : 240px;
	height: 180px;
}

.daysInfo{
	font-size:20px;
	width:430px; 
	height:35px; 
	border:1px solid #e3e6f0;
	border-radius: 4px;
	background: linear-gradient(to right ,yellow 1%, white 1%);
	padding-left: 20px;
	box-shadow: 0 .15rem 1.75rem 0 rgba(58,59,59,.15)!important;
	margin-bottom: 0px;
}

</style>
</head>
<body>
   <div class="main-wrapper">
      <%@include file="./common/Sidebar.jsp"%>
      <div class="content-wrapper">

         <!-- 메인 컨텐츠   -->
         <div class="lpcontents">
            <div class="content">               
                <input type="button" id="downloadExcel"  class="far fa-edit" style="width:64px; height:64px; border: none; background: url('./img/canvas/excelIcon.png')" title="Excel로 다운로드">               
              	<div style="margin-bottom: -15px;">이곳은 스케치북 제목을 적어봅시다.</div>
               <div><hr></div>
               <div id="custom-menu"></div>              
               <div id="mybook" style="border: 1px solid black;">                    	            
                  <div>마지막페이지 입니다.</div>
                  <div>마지막페이지 입니다.</div>                 
               </div>
               <c:choose>
               <c:when test="${ldto.user_email eq sketch_email}">                
               	<button data-toggle="modal" data-target="#myModal" style="width:64px; height:64px; border: none; background: url('./img/canvas/addPage.png')" title="페이지 추가"></button>
               	<input type="button" style="width:64px; height:64px; border: none; background: url('./img/canvas/editPage.png')" id="pageUpdate" title="페이지 수정"></input>
               	<input type="button" style="width:64px; height:64px; border: none; background: url('./img/canvas/removePage.png')" id="pageDelete" title="페이지 삭제"></input>
               </c:when>      
               <c:otherwise>          	   
               	        <div style="float: right; margin-right: 10px; ">
						 <a href="#" onclick="like('${ldto.user_email}','${sketch_id}')"><img id="likeState" alt="likeEmpty" src="./img/LikeBefore.png" title="좋아요"></a>				 		
						 <a href="#" onclick="scrape('${ldto.user_email}','${sketch_id}')"> <img id="scrapState" alt="scrape" src="./img/scrape.png" title="스크랩"> </a>
			 		    </div>	
		 	  </c:otherwise>               
               </c:choose>
               
              

               <form action="./insertDaysForm.do" onsubmit="return false" method="post" id="frm">
                  <input type="hidden" value=1  id="nowPageNo" name="nowPageNo">
              	  <input type="hidden" value="0" id="selectType" name="selectType">
               </form>         
         </div>
         </div>
         </div>
         </div>
              
  <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content" style="width:1000px; height:800px;">
        <div class="modal-header">          
          <h4 class="modal-title" style="text-align: center;">페이지 입력</h4>
        </div>
        <div class="modal-body" style="padding: 30px 30px 30px 30px;">
          <p><img src="./img/days.jpg" class="insertForms" title="1번스타일"></img>
          	 <img src="./img/free2.png" class="insertForms" title="2번스타일"></img>
          	 <img src="./img/free2.png" class="insertForms" title="3번스타일"></img><br>
          	 <img src="./img/free3.png" class="insertForms" title="4번스타일"></img>
          	 <img src="./img/free4.png" class="insertForms" title="5번스타일"></img>
          	 <img src="./img/free5.png" class="insertForms" title="6번스타일"></img>
          </p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal" id="closeModal">Close</button>
          <button type="button" class="btn btn-default" id="canvasInsertFrom">ok</button>
        </div>
      </div>
   </div>
   </div>
   

 <script>  		 
 	
 
	/*  $(".b-current").mouseover(function() {
		alert("마우스 오버");
		$(".b-current ul").css("border","2px solid black");
	}); */
	 
	/*  $("document").on("mouseover",".b-current",function(event){
		 alert("마우스 오버");
	 }); */
 
	$("document").ready(function() {	
		
		 //책 모양 가져오기
 	    $('#mybook').booklet({
 	    		width:  960,
 	            height: 650,
 	            shadow: false,
 	            arrows: true,
 	            pageNumbers : false,
 	            change: function(event, data) { 
 	  			  $('#nowPageNo').val(data.index/2+1);  	  				
 	  		    }, 	  		  
 	  		    menu: '#custom-menu',
 	  		    pageSelector: true,
 	  		 	tabs:  true,
 	        	tabWidth:  180,
 	        	tabHeight:  20
 	    });				 
		 
		// 캔버스 클릭시
		$(".insertForms").click(function(){
			// 모든 캔버스 투명도 및 배경색(나중에 이미지로 바뀔예정) 조절
			$(".insertForms").css('opacity','1.0');
			$(".insertForms").css('background-color','');
			// 선택한 캔버스 아이콘 투명도 설정
			$(this).css('opacity','0.5');
			$(this).css('background-color','green');
			// 현재 제목을 가져와서 해당 값을 넘김
			var titleContent = $(this).attr('title');			
			$('#selectType').val(titleContent.substr(0,1));	
			alert($('#selectType').val());
		});		
		// 엑셀로 다운로드
		$("#downloadExcel").click(function() {
			if(confirm("해당 스케치북의 일정 페이지를 \nExcel파일로 받으시겠습니까?")){						
					location.href="./canvasDownloadExcel.do";		
			}
		});
		// 수정 버튼 클릭시
		$("#pageUpdate").click(function() {
			alert("수정");			
			//location.href="./updateDaysForm.do?pageNo="+pageNo;			
			var updateForm = $('<form></form>');
			updateForm.attr('action', './updateCanvas.do');
		    updateForm.attr('method', 'post');		    
		    updateForm.appendTo('body');		 
		    // 페이지 번호 받아옴
		    var pageNo = $('<input type="hidden" name="nowPageNo">');
		    pageNo.val($('#nowPageNo').val());
		    // 해당 캔버스의 타입을 받아옴
		    var typeNo = $('<input type="hidden" name="selectType">');
		    typeNo.val($('#selectType').val());
		    // 세션에 등록된 스케치북 받아오기		 
		    updateForm.append(pageNo);
		    updateForm.append(typeNo);
		    updateForm.submit();	
		});
		//삭제 버튼 클릭시
		$("#pageDelete").click(function() {			
			var pageNo = $('#nowPageNo').val();		
			alert(pageNo);
			$.ajax({
				url : "deleteCanvas.do", //요청 url
				type : "post", // 전송 처리방식

				asyn : false, // true 비동기 false 동기				

				data : {"nowPageNo" : pageNo}, // 서버 전송 파라메터
				dataType : "json", // 서버에서 받는 데이터 타입
				success : function(msg) {
				    var sketch_id = msg.result;
				    location.href ="detailCanvas.do?sketch_id="+sketch_id;
				},
				error : function() {
				    alert("삶의 지혜가 부족하다.");
				}
		    });		
		});
		
		// 등록 버튼 클릭시
		$("#canvasInsertFrom").click(function() {			
			if($('#selectType').val() == "1"){				
				var daysSize = <%=daysList.size()%>;
				alert(daysSize);
				if( parseInt(daysSize) < 10){
				 	var pageNo = $('#nowPageNo').val();
				 	document.getElementById("frm").action = "./insertDaysForm.do";
				 	document.getElementById("frm").submit();
				}else{
					alert("일정 캔버스는 최대 10개까지 가능합니다.");
				}
			}else{	
				var freeSize = <%=textList.size()%>;
				alert(freeSize);
				if(parseInt(freeSize) < 10){
				 var pageNo = $('#nowPageNo').val();
				 document.getElementById("frm").action = "./upload.do";
				 document.getElementById("frm").submit();
				}else {
					alert("자유 캔버스는 최대 30개까지 가능합니다.");
				}
			}
		});
		
		
		//페이지 만들기
		<% if(canvasList != null){ %>
			makePage();
			//일정 게시판일경우 불러오기
			daysLoad();	
		<% }%>
		function makePage(){
			<%
			for(int i = 0 ; i < canvasList.size(); i++){
			%>
				$('#mybook').booklet("add", <%=2*i%>,"<div id='page<%=i+1%>'></div>");
    			$('#mybook').booklet("add", <%=2*i+1%>,"<div><div id='map<%=i+1%>' style='width:440px;height:560px;'></div>");
    		<%    			
			}
    		%>
		}
		
		function daysLoad() {			
			<%
				for(int i = 0 ; i < canvasList.size();i++){
					if(canvasList.get(i).getCan_type().equalsIgnoreCase("1")){
			%>
				var container = document.getElementById("map"+<%=i+1%>);
	    		var options = {
	    			center: new daum.maps.LatLng(<%=daysList.get(i).get(0).getDays_x()%>, <%=daysList.get(i).get(0).getDays_y()%>),
	    			level: 7,
	    			disableDoubleClickZoom : true
	    		};
	    		
	    		var map = new daum.maps.Map(container, options);
	    		
	    		// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
	    		var mapTypeControl = new daum.maps.MapTypeControl();

	    		// 지도에 컨트롤을 추가해야 지도위에 표시됩니다	    		
	    		map.addControl(mapTypeControl, daum.maps.ControlPosition.TOPRIGHT);

	    		// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
	    		var zoomControl = new daum.maps.ZoomControl();
	    		map.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);
	    		
	    		// 일정 마커들
	    		var daysMarker = [];
	    		// 일정 마커들의 인포윈도우
	    		var daysInfo = [];	
	    		// 일정 마커 시작시간
	    		var daysStart = [];
	    		// 일정 마커 종료시간
	    		var daysEnd = [];
	    		
	    		// 일정 마커들 정보 가져오기
	    		<%
	    			for(int j = 0; j < daysList.get(i).size(); j++){
	    		%>
	    		
	    		daysMarker[<%=j%>] = new daum.maps.Marker({ 			    
	    			position: new daum.maps.LatLng(<%=daysList.get(i).get(j).getDays_x()%>,<%=daysList.get(i).get(j).getDays_y()%>),
	    			clickable: true				   
	    		});
	    		daysInfo[<%=j%>] = '<%=daysList.get(i).get(j).getDays_title()%>';
	    		
	    		// 시작 시간 설정
	    		var startHour = '<%=daysList.get(i).get(j).getDays_sdate().getHours()%>';
	    		var startMin = '<%=daysList.get(i).get(j).getDays_sdate().getMinutes()%>';
	    		var startHalf = "AM";
	    		if(parseInt(startHour) >= 12){ 
	    			startHalf = "PM";
	    			startHour = parseInt(startHour)-12;
	    		}
	    		if(parseInt(startHour) < 10)		{ 	startHour = "0"+startHour;   }
	    		if(parseInt(startMin) < 10)			{	startMin = "0"+startMin; 	}	    		
	    		daysStart[<%=j%>] = startHalf+" "+startHour+":"+startMin;    		
	    		
	    		// 종료 시간 설정
	    		var endHour = '<%=daysList.get(i).get(j).getDays_edate().getHours()%>';
	    		var endMin = '<%=daysList.get(i).get(j).getDays_edate().getMinutes()%>';
	    		var endHalf = "AM";
	    		if(parseInt(endHour) >= 12){ 
	    			endHalf = "PM";
	    			endHour = parseInt(endHour)-12;
	    		}
	    		if(parseInt(endHour) < 10)		{ 	endHour = "0"+endHour;   }
	    		if(parseInt(endMin) < 10)			{	endMin = "0"+endMin; 	}	    		
	    		daysEnd[<%=j%>] = endHalf+" "+endHour+":"+endMin;	    	
	    		
	    		// 인포윈도우에 표시할 내용
	    		var infowindow = new daum.maps.InfoWindow({
	    			content: '<div><%=daysList.get(i).get(j).getDays_title()%></div>',     		        
    		        removable : true
	    		});

    		    // 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
    		    // 이벤트 리스너로는 클로저를 만들어 등록합니다 
    		    // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
    		    daum.maps.event.addListener(daysMarker[<%=j%>], 'click', makeOverListener(map, daysMarker[<%=j%>], infowindow));
    		    //daum.maps.event.addListener(daysMarker[<%=j%>], 'mouseout', makeOutListener(infowindow));
	    		<%	
	    			}
	    		%>
	    		// 선그리기
	    		 var linePath = [];
	    			// 지도에 마커를 표시합니다
	    			for(var i = 0 ; i < daysMarker.length ; i++)
	    			{
	    				daysMarker[i].setMap(map);				
	    				var path =  new daum.maps.LatLng(daysMarker[i].getPosition().getLat(), daysMarker[i].getPosition().getLng());
	    				linePath.push(path);
	    			}
	    			
	    			if(daysMarker.length >= 2){		
	    				// 지도에 표시할 선을 생성합니다
	    				var polyline = new daum.maps.Polyline({
	    					    path: linePath, // 선을 구성하는 좌표배열 입니다
	    					    strokeWeight: 5, // 선의 두께 입니다
	    					    strokeColor: '#FF0000', // 선의 색깔입니다
	    					    strokeOpacity: 0.7, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
	    					    strokeStyle: 'solid' // 선의 스타일입니다
	    				});
	    				// 지도에 선을 표시합니다 
	    				polyline.setMap(map);  
	    			}    
	    			
	    			// 일정 페이지 정보 가져오기
	    			var daysPage = document.getElementById("page"+<%=i+1%>);				
	    			daysPage.innerHTML ="<div style='text-align : center;'><h4><%=canvasList.get(i).getCan_title()%></h4></div>";
	    			for(var i = 0 ; i < daysMarker.length ; i++){ 				
	    				
	    				var div = document.createElement('div');
	    				div.style.width="460px";
	    				div.style.height = "40px";
	    				if(i >= 1){
	    					div.style.height = "60px";
	    					//시작 지점 과 끝지점 가져와서 최단거리 설정
	    					div.innerHTML += "<span style='margin-Left:226px;'>↓</span>";
	    					var startCoord = new daum.maps.LatLng(daysMarker[i-1].getPosition().getLat(), daysMarker[i-1].getPosition().getLng());
	    					var endCoord =  new daum.maps.LatLng(daysMarker[i].getPosition().getLat(), daysMarker[i].getPosition().getLng());
	    					div.innerHTML += "<a style='float:right; margin-right:30px;' href='https://map.kakao.com/?sX="+startCoord.toCoords().getX()+"&sY="+startCoord.toCoords().getY()+"&sName=출발점&eX="+endCoord.toCoords().getX()+"&eY="+endCoord.toCoords().getY()+"&eName=도착점'"
	    							+ " onclick='window.open(this.href, \"_경로보기\", \"width=1280px,height=860px;\"); return false;'"
	    							+ ">최단경로보기</a><br>";
	    				}				
	    				div.innerHTML += "<div class='daysInfo'>"+daysInfo[i] //+(i+1)+"번째 일정:"+daysInfo[i]
	    							  + "<div style='font-size:12px; float:right; margin-right:10px;'>"+daysStart[i]+"~"+daysEnd[i]+"</div></div>";	
	    				daysPage.appendChild(div);	
	    			}	
	    			
			<%
					}
					else if(canvasList.get(i).getCan_type().equalsIgnoreCase("2")){
			%>
					// 일정 페이지 정보 가져오기
					var daysPage = document.getElementById("page"+<%=i+1%>);
					var div = document.createElement('div');
					div.innerHTML += "<div id='Left-Side'>"
								  +  "<div id='IMG1' style='background-image: url(\"<%=textList.get(i).get(0).getImg_spath()%>\")'>"
								  +  "</div><div id='LS_Container'><div id='TXT1'>"
								  +  "<%=textList.get(i).get(1).getText_content()%>"
								  + "</div></div></div>";								 					
					daysPage.appendChild(div);	
					
					var mapPage = document.getElementById("map"+<%=i+1%>);
					var div1 = document.createElement('div');
					div1.innerHTML  += "<div id='Right-Side'><div id='RS_Container_1'>"
					  				+ "<div id='TXT2'><%=textList.get(i).get(2).getText_content()%></div>"
					  				+	"<div id='TXT3'><%=textList.get(i).get(3).getText_content()%></div>"
					  				+ "<div id='TXT4'><%=textList.get(i).get(4).getText_content()%></div>"
					  				+ "</div><div id='RS_Container_2'><div>"
					  				+	"<div id='IMG2' style='background-image: url(\"<%=textList.get(i).get(5).getImg_spath()%>\")'>"
					  				+ "</div><div id='IMG3' style='background-image: url(\"<%=textList.get(i).get(6).getImg_spath()%>\")'>"
					  				+	"</div></div></div></div>";	
					mapPage.appendChild(div1);
			<%
					}else if(canvasList.get(i).getCan_type().equalsIgnoreCase("3")){
			%>
						// 일정 페이지 정보 가져오기
						var daysPage = document.getElementById("page"+<%=i+1%>);
						var div = document.createElement('div');
						div.innerHTML += "<div id='Left-Side2'>"
									  +  "<div id='LS_TContainer2'>"
									  + "<div id='TXT21'><%=textList.get(i).get(0).getText_content() %></div></div>"
									  + "<div id='LS_IContainer2'>"
									  + "<div id='IMG21' style='background-image: url(\"<%=textList.get(i).get(1).getImg_spath()%>\")'></div>"
									  + "<div id='IMG22' style='background-image: url(\"<%=textList.get(i).get(2).getImg_spath()%>\")'></div>"	
									  + "<div id='IMG23' style='background-image: url(\"<%=textList.get(i).get(3).getImg_spath()%>\")'></div>"
					  				  + "</div></div>";
						daysPage.appendChild(div);
						
						var mapPage = document.getElementById("map"+<%=i+1%>);
						var div1 = document.createElement('div');
						div1.innerHTML += "<div id='Right-Side2'>"
									   + "<div id='IMG24' style='background-image: url(\"<%=textList.get(i).get(4).getImg_spath()%>\")'></div>"
									   + "<div id='TXT22'><%=textList.get(i).get(5).getText_content() %></div></div>";
					 mapPage.appendChild(div1);					
			<%
					}else if(canvasList.get(i).getCan_type().equalsIgnoreCase("4")){			
			%>
					// 일정 페이지 정보 가져오기
					var daysPage = document.getElementById("page"+<%=i+1%>);
					var div = document.createElement('div');
					div.innerHTML += "<div id='Left-Side3'>"
								  + "<div id='IMG31' style='background-image: url(\"<%=textList.get(i).get(0).getImg_spath()%>\")'></div></div>";
					daysPage.appendChild(div);
					
					var mapPage = document.getElementById("map"+<%=i+1%>);
					var div1 = document.createElement('div');
					div1.innerHTML  += "<div id='Right-Side3'>"
									+ "<div id='RS_TContainer3'>"
									+ "<div id='TXT31'><%=textList.get(i).get(1).getText_content() %></div>"
									+ "<div id='TXT32'><%=textList.get(i).get(2).getText_content() %></div></div>"
									+ "<div id='RS_IContainer3'>"
									+ "<div id='IMG32' style='background-image: url(\"<%=textList.get(i).get(3).getImg_spath()%>\")'></div>"
									+ "<div id='IMG33' style='background-image: url(\"<%=textList.get(i).get(4).getImg_spath()%>\")'></div>"
									+ "<div id='TXT33'><%=textList.get(i).get(5).getText_content() %></div></div></div>";
					mapPage.appendChild(div1);	
			<%
					}else if(canvasList.get(i).getCan_type().equalsIgnoreCase("5")){			
			%>
					var daysPage = document.getElementById("page"+<%=i+1%>);
					var div = document.createElement('div');
					div.innerHTML += "<div id='Left-Side4'>"
								   + "<div id='IMG41' style='background-image: url(\"<%=textList.get(i).get(0).getImg_spath()%>\")'></div></div>";
					daysPage.appendChild(div);
									
					var mapPage = document.getElementById("map"+<%=i+1%>);
					var div1 = document.createElement('div');
					div1.innerHTML += "<div id='Right-Side4'>"
								   + "<div id='TXT41'><%=textList.get(i).get(1).getText_content() %></div></div>";
					mapPage.appendChild(div1);
			<%
					}else if(canvasList.get(i).getCan_type().equalsIgnoreCase("6")){			
			%>							
						var daysPage = document.getElementById("page"+<%=i+1%>);
						var div = document.createElement('div');
						div.innerHTML += "<div id='Left-Side5'>"
									   + "<div id='LS_IContainer5'>"
									   + "<div id='IMG51' style='background-image: url(\"<%=textList.get(i).get(0).getImg_spath()%>\")'></div></div>"
									   + "<div id='LS_TContainer5'>"
									   + "<div id='TXT51'><%=textList.get(i).get(1).getText_content() %></div></div></div>";
						daysPage.appendChild(div);
						
						var mapPage = document.getElementById("map"+<%=i+1%>);
						var div1 = document.createElement('div');
						div1.innerHTML += "<div id='Right-Side5'>"
									   + "<div id='RS_ITContainer51'>"
									   + "<div id='IMG52' style='background-image: url(\"<%=textList.get(i).get(2).getImg_spath()%>\")'></div>"
									   + "<div id='TXT52'><%=textList.get(i).get(3).getText_content() %></div>"
									   + "<div id='IMG53' style='background-image: url(\"<%=textList.get(i).get(4).getImg_spath()%>\")'></div></div>"
									   + "<div id='RS_ITContainer52'>"
									   + "<div id='TXT53'><%=textList.get(i).get(5).getText_content() %></div>"
									   + "<div id='IMG54' style='background-image: url(\"<%=textList.get(i).get(6).getImg_spath()%>\")'></div>"
									   + "<div id='TXT54'><%=textList.get(i).get(7).getText_content() %></div></div></div>";
						mapPage.appendChild(div1);						
			<%
					}					
				}
			%>
		}
		
		
		// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
		function makeOverListener(map, marker, infowindow) {
		    return function() {
		        infowindow.open(map, marker);
		    };
		}
		
		// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
		function makeOutListener(infowindow) {
		    return function() {
		        infowindow.close();
		    };
		} 
		
		// 모달 초기화
		$("#closeModal").click(function(){	
			// 모든 캔버스 투명도 및 배경색(나중에 이미지로 바뀔예정) 조절
			$(".insertForms").css('opacity','1.0');
			$(".insertForms").css('background-color','');
		});
	});		
	//--------------- 좋아요 등록 및 취소---------------------
	function like(user,id){	
		if(user == ""){
			alert("로그인 후 사용가능합니다.");
		}
		else{
		LpLike(user,id);
		}
	}

	var LpLike = function(user,id){
	    var user_email = user;
	    var sketch_id = id;
		$.ajax({
			url: "LPLike.do",
			type: "get",
			data: {"user_email" : user_email, "sketch_id" : sketch_id },
			dataType: "Json",
			success: function(result){					
				if(result.result == "F")
					$("#likeState").attr("src","./img/LikeBefore.png");	
				else
					$("#likeState").attr("src","./img/LikeAfter.png");	
			}, error : function() {
				alert("실패");
			}			
		});
	}
	
	//---------------------- 스크랩 등록 및 수정 --------------------
	function scrape(user,id) {
		//alert("스크랩");		
		if(user == ""){
			alert("로그인 후 사용가능합니다.");
		}
		else{
			LpScrape(user,id);		
		}
	}

	var LpScrape = function(user,id){
//		var user_email = "128@happy.com";
		var sketch_id = id;
//		alert("스크랩 등록");	
		$.ajax({
			url : "Scrape.do",
			type : "get",
			data :  "user_email="+user+"&sketch_id="+sketch_id,
			success : function(sresult){			
				if(sresult.sresult == "F")
					$("#scrapState").attr("src","./img/scrape.png");	
				else
					$("#scrapState").attr("src","./img/scrapeT.png");
			}, error : function() {
				alert("실패");
			}
		});		   
	}
	
	
	</script> 	
	
	</body>
</html>