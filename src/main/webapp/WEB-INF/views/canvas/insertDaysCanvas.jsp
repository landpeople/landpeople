<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
<!-- Custom fonts for this template-->
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

<link rel="stylesheet" type="text/css" href="./css/sweetalert.css">

<!-- Custom styles for this template -->
<link href="./css/theme/sb-admin-booklet.css" rel="stylesheet">
<link href="./css/theme/lp-template.css" rel="stylesheet">
<link href="./css/sketch/modal.css" rel="stylesheet">
<style type="text/css">
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

<script src="./js/jquery-3.3.1.js"></script>

<!-- 책모양  -->
<link href="./css/canvas/jquery.booklet.latest.css" type="text/css" rel="stylesheet" media="screen, projection, tv" />
<script src="./js/jquery-ui.js"></script>
<script src="./js/jquery.easing.1.3.js"></script>
<script src="./js/jquery.booklet.latest.min.js"></script>

<script src="./js/min/plugins.min.js"></script>
<!-- <script src="./js/min/main.min.js"></script> -->

<!-- 카카오 지도를 위한 js파일 -->
<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=559fa9d8ea227159941f35acba720d2b&libraries=services"></script>



<body id="page-top" class="scroll">

   <!-- Page Wrapper -->
   <div id="wrapper">
      <%@include file="../common/lp-sidebar.jsp"%>

      <!-- Content Wrapper -->
      <div id="content-wrapper" class="d-flex flex-column">
         <!-- flex 레이아웃 content와 푸터 정렬 -->

         <!-- Main Content -->
         <div id="content" style="display: flex; flex-direction: column;">

            <!-- LandPeople Content Area -->
            <div class="lp-container">
               <div class="lp-other-content shadow-lg scroll" style="overflow:hidden;">
               <div class="back" onclick="moveDetailCanvas(${sketch_id})">
                         	<img alt="뒤로가기" src="./img/canvas/back.png"
								onmouseover="this.src='./img/canvas/back-over.png';"
								onmouseout="this.src='./img/canvas/back.png';">
                         </div>
               
                 <%--  <a href='./detailCanvas.do?sketch_id=${sketch_id}'>뒤로가기</a> --%>
               <div id="mybook" style="border: 1px solid black;">
                  <div id="page3" style="width: 470px; height: 630px; overflow: auto;">
                     페이지 제목:
                     <input type="text" id="pageTitle" value="1일차">
                  </div>
                  <div>
                     <!-- <a href="./loadMap.do">지도정보가져오기</a>  -->               
                     <input type="button" onclick="showTrip()" style="margin-right: 5px; width:34px; height:34px; border: 1px solid black; background: url('./img/canvas/tour.png')" title="관광지">
                     <input type="button" onclick="showFood()" style="margin-right: 5px; width:34px; height:34px; border: 1px solid black; background: url('./img/canvas/restaurant.png')" title="음식점">
                     <input type="button" onclick="showRest()" style="margin-right: 5px; width:34px; height:34px; border: 1px solid black; background: url('./img/canvas/rest.png')" title="숙소">
                     <input type="button" onclick="searchKeyword()" style="float:right; width:34px; height:34px; border: 1px solid black; background: url('./img/manager/search.png')" title="검색">
                     <input type="text" id="searchKeyword" style="float:right; margin-right: 10px;">
                     <div id="map" style="width: 440px; height: 560px;"></div>                    
                  </div>
               </div>
               <input id="insertCanvas" type="button" style="width:64px; height:64px; border: none; background: url('./img/canvas/check.png')" title="저장 완료"/>
                  
               
               </div>
            </div>
            <!--End of Page LandPeople Content Area -->
            <%@include file="../common/lp-footer.jsp"%>
            <!-- End of Page Wrapper -->
         </div>
      </div>
   </div>
   
   <!-- main에 있는 header 영역임 main 페이지 말고는 사용을 안하지만, 그냥 주석함. 지워도 됨-->
   <!-- <div class="banner-bg" id="top"> -->
   <!--  <div class="banner-overlay"></div> -->
   <!--     <div class="welcome-text"> -->
   <!--        <h2>LandPeople</h2> -->
   <!--            <h5>This is a mobile friendly layout with Bootstrap v3.3.1 framework. Maecenas eu ante at nunc posuere fringilla sit amet non dolor. Proin condimentum fermentum nunc.</h5> -->
   <!--        </div> -->
   <!--    </div> -->
   <!-- </div> -->

   <!-- 여기에 div 잡아서 작업하면 됨 -->
   <!-- templatemo-style.css에 보면 이안에 들어가는 div 클래스가 있음. 아니면 css를 temp -->

   <script>
      //첫번째 일정 표시
      var daysNum = 1;
      //다음 맵 세팅
      var container = document.getElementById('map');
      var options = {
         center : new daum.maps.LatLng(33.48888971585, 126.4982271088),
         level : 7,
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
      // 주소-좌표 변환 객체를 생성합니다
      var geocoder = new daum.maps.services.Geocoder();     
      // 관광지/음식점/숙소 마커들
      var markers = [];
      // 일정 마커들
      var daysMarker = [];
      // 일정 마커들의 인포윈도우
      var daysInfo = [];
      // 일정 마커들의 시작시간,종료시간 정보
      var daysStart = [];
      var daysEnd = [];
      // 일정 마커들의 주소
      var daysAddress = [];

      //클릭시 나오는 임시 마커
      var marker;
      //입력 윈도우
      var infoWindow;
      // 윈도우 창이 열려있는지 확인
      var isInsertOpen = false;
      // 선 그려주는 변수
      var polyline = null;
      // 주소
      var detailAddr;
      /* var icon = new daum.maps.MarkerImage(
              './food.png',
              new daum.maps.Size(32, 32)); */
      daum.maps.event.addListener(map,'click',function(mouseEvent) {
                     
                if (isInsertOpen != true) {
               // 클릭한 위도, 경도 정보를 가져옵니다 
               var latlng = mouseEvent.latLng;
               // 마커 생성       
               marker = new daum.maps.Marker({
                   position : new daum.maps.LatLng(latlng.getLat(), latlng.getLng()),
                   clickable : true
               });
               //마커에 넣기
               marker.setMap(map);
               marker.setDraggable(true);
               
               
               //주소 가져오기               
               searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {                  
                      detailAddr = !!result[0]? result[0].address.address_name:'';                    
                  
               // 입력 윈도우를 생성합니다
               infoWindow = new daum.maps.InfoWindow({
                    content : '<div style="width:200px; height:140px;">일정제목 &nbsp;<input style="width:100px; height=30px;" type="text" id="daysTitle">'
                         +'<br><div style="font-size:14px;"><img src="./img/canvas/address.png">'+detailAddr+'</div>'+'<img src="./img/canvas/time.png">&nbsp;<select id="startHalf" style="font-size:14px"><option>AM</option><option>PM</option></select>'
                         +'&nbsp;<select id="startHH"><option>00</option><option>01</option><option>02</option><option>03</option><option>04</option><option>05</option><option>06</option><option>07</option><option>08</option><option>09</option><option>10</option><option>11</option></select>'
                         +'&nbsp;<select id="startMM"><option>00</option><option>30</option></select>'                  
                         +'<br>종료:&nbsp;<select id="endHalf" style="font-size:14px"><option>AM</option><option>PM</option></select>'
                         +'&nbsp;<select id="endHH"><option>00</option><option>01</option><option>02</option><option>03</option><option>04</option><option>05</option><option>06</option><option>07</option><option>08</option><option>09</option><option>10</option><option>11</option></select>'
                         +'&nbsp;<select id="endMM"><option>00</option><option>30</option></select>'  
                         +'<div style="margin-top: 5px;"><button style="width:100px; height=30px;" onclick="daysMake()">일정등록</button><button style="width:100px; height=30px;" onclick="closeInfo()">취소</button></div></div>',
                  });
               infoWindow.open(map, marker);
               isInsertOpen = true;
               map.setDraggable(false);
               map.setZoomable(false);
               
               });
               
                }
      });
   
       // 주소 가져오기    
      function searchDetailAddrFromCoords(coords, callback) {   
                geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
      }

      // 일정 만들기
      function daysMake() {
          var title = document.getElementById('daysTitle').value;
        
          var hour=0;
         // 시작 시간
         var startHalf = $("#startHalf").val();
         var startHour = $("#startHH").val();
         var startMin = $("#startMM").val(); 
         if(startHalf == "PM")      { hour = (12+parseInt(startHour)); }
         else                 { hour = parseInt(startHour); }
         var startTime = hour*60+parseInt(startMin);
         // 종료 시간
         var endHalf = $("#endHalf").val();
         var endHour = $("#endHH").val();
         var endMin = $("#endMM").val();
         if(endHalf == "PM")        { hour = (12+parseInt(endHour)); }
         else                 { hour = parseInt(endHour); }
         var endTime = hour*60+parseInt(endMin);
         var inputChk = true;
         
         // 이전 시간중 일정이 겹치는 시간이 있는지 확인
         for(var i=0; i < daysStart.length ; i++){
            var beforeStartTime = daysStart[i].split(":");
            var beforEndTime = daysEnd[i].split(":");
            
            var chkStartTime = parseInt(beforeStartTime[0])*60+parseInt(beforeStartTime[1]);
            var chkEndTime = parseInt(beforEndTime[0])*60+parseInt(beforEndTime[1]);
            if(startTime >= chkStartTime && startTime < chkEndTime ){
               inputChk = false;
            }
            if(endTime > chkStartTime && endTime <= chkEndTime){
               inputChk = false;
            }              
         }
          
          if(title == "" || title == null){
            alert("일정 제목을 입력해주세요.");
         }
         else if(startTime >= endTime){
            alert("시작시간이 종료시간보다 같거나 늦습니다.\n 시작시간이 종료시간보다 먼저 시작되게 해주세요.");
         }
         else if(inputChk == false){
            alert("시간이 겹치는 일정이 있습니다. 다시 입력해주세요.");
         } 
         else {
         // 완성이 되면 넣고 아니면 넣지 않는다.
         daysMarker.push(marker);
         marker.setMap(null);
          daysMarker[daysMarker.length-1].setMap(map);
         // 내용에 넣기
         daysInfo.push(title);
         // 시작 시간             
         var hour = $("#startHH").val();
         var min = $("#startMM").val();   
         if(startHalf == "PM"){ hour = (12+parseInt(hour)); }
         daysStart.push(hour+":"+min);
         // 종료 시간
         hour = $("#endHH").val();
         min = $("#endMM").val();
         if(endHalf == "PM"){ hour = (12+parseInt(hour)); }
         daysEnd.push(hour+":"+min);   
         //주소 넣기
         daysAddress.push(detailAddr);

         // 클릭 이벤트 설정
         var addwindow = new daum.maps.InfoWindow({
             content : '<div>'+title+'</div>', // 인포윈도우에 표시할 내용
             removable : true
         });
         // 마커에  이벤트 등록 
         daum.maps.event.addListener(daysMarker[daysMarker.length - 1], 'click', makeOverListener(map,daysMarker[daysMarker.length - 1],addwindow));
         daum.maps.event.addListener(daysMarker[daysMarker.length - 1], 'dragend',initRender);
         // 선 그리기
         initRender();
         // 일정 페이지 정보 가져오기
         var daysPage = document.getElementById("page3");
         var div = document.createElement('div');
      
         if(daysMarker.length >= 2){
            //시작 지점 과 끝지점 가져와서 최단거리 설정
            div.innerHTML += "<span style='margin-Left:226px;'>↓</span>";
            var startCoord = new daum.maps.LatLng(daysMarker[daysMarker.length-2].getPosition().getLat(), daysMarker[daysMarker.length-2].getPosition().getLng());
            var endCoord =  new daum.maps.LatLng(daysMarker[daysMarker.length-1].getPosition().getLat(), daysMarker[daysMarker.length-1].getPosition().getLng());
            div.innerHTML += "<a style='float:right; margin-right:30px;' href='https://map.kakao.com/?sX="+startCoord.toCoords().getX()+"&sY="+startCoord.toCoords().getY()+"&sName=출발점&eX="+endCoord.toCoords().getX()+"&eY="+endCoord.toCoords().getY()+"&eName=도착점' onclick='window.open(this.href, \"_경로보기\", \"width=1280px,height=860px;\"); return false;'>최단경로보기</a><br>";
         }
         div.innerHTML += "<div class='daysInfo'>"+daysMarker.length+"번째 일정:"+title                       
                     + "<div style='float:right;'><img src='./img/canvas/normalClose.png' class='deleteDays' title='"+(daysMarker.length-1)+"' width='38' height='38' onclick='deleteDay("+(daysMarker.length-1)+")'></div>"
                    + "<div style='font-size:12px; float:right; margin-right:50px;'>"+startHalf+" "+startHour+":"+startMin+"~"+endHalf+" "+endHour+":"+endMin+"</div></div>"; 
            daysPage.appendChild(div);
            infoWindow.close();
            isInsertOpen = false;
            map.setDraggable(true);
            map.setZoomable(true);                    
         }       
      }
      
      // 그려주기
      function render() {
          var linePath = [];              
         // 지도에 라인을 표시합니다.
            for(var i = 0 ; i < daysMarker.length ; i++)
            {
               var path =  new daum.maps.LatLng(daysMarker[i].getPosition().getLat(), daysMarker[i].getPosition().getLng());
               linePath.push(path);
            }
            
            if(daysMarker.length >= 2){      
               // 지도에 표시할 선을 생성합니다
               polyline = new daum.maps.Polyline({
                      path: linePath, // 선을 구성하는 좌표배열 입니다
                      strokeWeight: 5, // 선의 두께 입니다
                      strokeColor: '#FF0000', // 선의 색깔입니다
                      strokeOpacity: 0.7, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
                      strokeStyle: 'solid' // 선의 스타일입니다
               });
               // 지도에 선을 표시합니다 
               polyline.setMap(map);  
            }            
      }     
      // 초기화 후 그려주기
      function initRender() {
          if (polyline != null) {
            polyline.setMap(null);
            render();
          }else if(polyline == null){
            render();
          }        
      }           
      // 일정 등록시 info메세지 닫기
      function closeInfo() {
          infoWindow.close();
          isInsertOpen = false;
          map.setDraggable(true);
          map.setZoomable(true);
          marker.setMap(null);
      }
      // db에 저장
      $("#insertCanvas").click(function() {

         if($("#pageTitle").val() == null || $("#pageTitle").val().trim(" ") == ""){
            alert("제목에 값을 입력해주세요.");
         }else{
             //alert(daysMarker[0].getPosition().getLat());    
             var jsonObj = {};
             jsonObj["canvasTitle"] = $("#pageTitle").val();
             for (var i = 0; i < daysMarker.length; i++) {
               var testVal = {
                   'title' : String(daysInfo[i]),
                   'content' : "내용" + i,
                   'startDate' : "2019-05-14 " + daysStart[i] + ":00",
                   'endDate' : "2019-05-14 " + daysEnd[i] + ":00",
                   'x' : String(daysMarker[i].getPosition().getLat()),
                   'y' : String(daysMarker[i].getPosition().getLng()),
                   'address' : daysAddress[i]
               };
               jsonObj["days" + i] = testVal;
             }
             alert(jsonObj);
             $.ajax({
               url : "insertDaysCanvas.do", //요청 url
               type : "post", // 전송 처리방식
               asyn : false, // true 비동기 false 동기
               contentType : 'application/json',
               data : JSON.stringify(jsonObj), // 서버 전송 파라메터
               dataType : "json", // 서버에서 받는 데이터 타입
               success : function(msg) {
                   var sketch_id = msg.result;
                   location.href ="detailCanvas.do?sketch_id="+sketch_id;
               },
               error : function() {                   
               }
             });
         }
      });

      // 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
      function makeOverListener(map, marker, infowindow) {
          return function() {
         infowindow.open(map, marker);
          };
      }


      function showFood() {         
          for (var i = 0; i < markers.length; i++)
            markers[i].setMap(null);
          for(var i = 0; i < daysMarker.length; i++){     
             daysMarker[i].setMap(null);
             daysMarker[i].setMap(map);
          }

          $.ajax({
            url : "showFood.do", //요청 url
            type : "post", // 전송 처리방식
            asyn : false, // true 비동기 false 동기
            data : {
                'type' : "음식점"
            }, // 서버 전송 파라메터
            dataType : "json", // 서버에서 받는 데이터 타입
            success : function(msg) {
                alert(msg.result[0].map_id);
                for (var i = 0; i < msg.result.length; i++) {
               var foodMarker = new daum.maps.Marker({
                   position : new daum.maps.LatLng(
                      msg.result[i].map_y,
                      msg.result[i].map_x),
                   clickable : true
               });

               // 지도에 마커를 표시합니다
               foodMarker.setMap(map);
               markers.push(foodMarker);              
               
               var foodMarkerInfo = new daum.maps.InfoWindow(
                  {
                      content : '<div style="width:200px; height:140px;">일정제목 &nbsp;<input style="width:100px; height=30px;" type="text" id="daysTitle" value="'+msg.result[i].map_title+'">'
                      +'<br><div style="font-size:14px;"><img src="./img/canvas/address.png">'+msg.result[i].map_content+'<br>시작:&nbsp;<select id="startHalf" style="font-size:14px"><option>AM</option><option>PM</option></select>'
                      +'&nbsp;<select id="startHH"><option>00</option><option>01</option><option>02</option><option>03</option><option>04</option><option>05</option><option>06</option><option>07</option><option>08</option><option>09</option><option>10</option><option>11</option></select>'
                      +'&nbsp;<select id="startMM"><option>00</option><option>30</option></select>'                  
                      +'<br>종료:&nbsp;<select id="endHalf" style="font-size:14px"><option>AM</option><option>PM</option></select>'
                      +'&nbsp;<select id="endHH"><option>00</option><option>01</option><option>02</option><option>03</option><option>04</option><option>05</option><option>06</option><option>07</option><option>08</option><option>09</option><option>10</option><option>11</option></select>'
                      +'&nbsp;<select id="endMM"><option>00</option><option>30</option></select>'  
                      +'<div style="margin-top: 5px;"><button style="width:100px; height=30px;" onclick="daysMake()">일정등록</button></div>',
                      removable : true
                  });
               
               
               (function(foodMarker, foodMarkerInfo) {
                   // 마커에 mouseover 이벤트를 등록하고 마우스 오버 시 인포윈도우를 표시합니다 
                   daum.maps.event.addListener( foodMarker,'click',function() {
                        // 마커 위에 인포윈도우를 표시합니다                      
                        foodMarkerInfo.open(map,foodMarker);
                        marker = foodMarker;
                        detailAddr = "제주특별시";
                  });
               })(foodMarker, foodMarkerInfo);
               
                }
            },
            error : function() {
                alert("실패");
            }
         });
      }
   
   
   function deleteDay(number){         
      // 지울려는 배열 번호
      //var number = $(this).attr("title");     
      if(daysMarker.length == 1){
         alert("일정을 한개이상 입력하셔야 합니다.");
      }else{                  // 해당 일정의 데이터들 지우기
       daysMarker[number].setMap(null);
       daysMarker.splice(number,1);           
       daysInfo.splice(number,1);   
       daysStart.splice(number,1);
       daysEnd.splice(number,1); 
       
       alert(daysMarker);
       // 선 다시 그려주기
       initRender();
       var diffDays = document.getElementsByClassName("deleteDays");
       var diffNum;            
       for(var i = 0; i < diffDays.length ; i++){
         diffNum = parseInt(diffDays[i].title);
         if(diffNum > parseInt(number)){                 
            diffDays[i].title = --diffNum;
         }else if(diffNum == parseInt(number)){    
            $('.deleteDays:eq('+i+')').parent().parent().parent().remove();
         }
       }             
         if(number =="0"){
            // 0일경우 다음 일정에 있는 최단경로보기 찍어준 링크 찾아서 지워주기                 
            $('.deleteDays:eq(0)').parent().parent().parent().children('a').remove();
            $('.deleteDays:eq(0)').parent().parent().parent().children('span').remove();
            $('.deleteDays:eq(0)').parent().parent().parent().children('br').remove();
         }
      }
   }
   
    // 관광지보기
    function showTrip(){
       for(var i = 0; i < markers.length; i++)
          markers[i].setMap(null);
       for(var i = 0; i < daysMarker.length; i++){     
          daysMarker[i].setMap(null);
          daysMarker[i].setMap(map);
       }
       
       $.ajax({
            url: "showTrip.do", //요청 url
            type: "post", // 전송 처리방식
            asyn: false, // true 비동기 false 동기
            data: { 'type' : "관광"}, // 서버 전송 파라메터
            dataType: "json", // 서버에서 받는 데이터 타입
            success: function(msg){ 
               alert(msg.result[0].map_id);  
               for(var i = 0; i < msg.result.length ; i++){
                  var foodMarker  =    new daum.maps.Marker({            
                      position: new daum.maps.LatLng(msg.result[i].map_y, msg.result[i].map_x),
                      clickable: true              
                   });     
                  
                  // 지도에 마커를 표시합니다
                  foodMarker.setMap(map); 
                  markers.push(foodMarker);
                  var foodMarkerInfo = new daum.maps.InfoWindow({
                      content :  '<div style="width:200px; height:140px;">일정제목 &nbsp;<input style="width:100px; height=30px;" type="text" id="daysTitle" value="'+msg.result[i].map_title+'">'
                      +'<br><div style="font-size:14px;"><img src="./img/canvas/address.png">'+msg.result[i].map_content+'<br>시작:&nbsp;<select id="startHalf" style="font-size:14px"><option>AM</option><option>PM</option></select>'
                      +'&nbsp;<select id="startHH"><option>00</option><option>01</option><option>02</option><option>03</option><option>04</option><option>05</option><option>06</option><option>07</option><option>08</option><option>09</option><option>10</option><option>11</option></select>'
                      +'&nbsp;<select id="startMM"><option>00</option><option>30</option></select>'                  
                      +'<br>종료:&nbsp;<select id="endHalf" style="font-size:14px"><option>AM</option><option>PM</option></select>'
                      +'&nbsp;<select id="endHH"><option>00</option><option>01</option><option>02</option><option>03</option><option>04</option><option>05</option><option>06</option><option>07</option><option>08</option><option>09</option><option>10</option><option>11</option></select>'
                      +'&nbsp;<select id="endMM"><option>00</option><option>30</option></select>'  
                      +'<div style="margin-top: 5px;"><button style="width:100px; height=30px;" onclick="daysMake()">일정등록</button></div>',
                      removable : true
                  });                  
                  
                  (function(foodMarker, foodMarkerInfo) {
                       // 마커에 mouseover 이벤트를 등록하고 마우스 오버 시 인포윈도우를 표시합니다 
                      daum.maps.event.addListener(foodMarker, 'click', function() {
                       // 마커 위에 인포윈도우를 표시합니다                          
                         foodMarkerInfo.open(map, foodMarker);    
                         marker = foodMarker;
                     });                         
                   })(foodMarker, foodMarkerInfo);
                  
               }
            }, error : function() {
               alert("실패");
            }
         });   
    }
    
    // 숙소 보기
   function showRest(){
       for(var i = 0; i < markers.length; i++)
          markers[i].setMap(null);
       for(var i = 0; i < daysMarker.length; i++){     
          daysMarker[i].setMap(null);
          daysMarker[i].setMap(map);
       }
       
       
      $.ajax({
         url: "showRest.do", //요청 url
         type: "post", // 전송 처리방식
         asyn: false, // true 비동기 false 동기
         data: { 'type' : "숙박"}, // 서버 전송 파라메터
         dataType: "json", // 서버에서 받는 데이터 타입
         success: function(msg){ 
            alert(msg.result[0].map_id);  
            for(var i = 0; i < msg.result.length ; i++){
               var foodMarker  =    new daum.maps.Marker({            
                   position: new daum.maps.LatLng(msg.result[i].map_y, msg.result[i].map_x),
                   clickable: true              
                });     
               
               // 지도에 마커를 표시합니다
               foodMarker.setMap(map); 
               markers.push(foodMarker);
               var foodMarkerInfo = new daum.maps.InfoWindow({
                   content : '<div style="width:200px; height:140px;">일정제목 &nbsp;<input style="width:100px; height=30px;" type="text" id="daysTitle" value="'+msg.result[i].map_title+'">'
                   +'<br><div style="font-size:14px;"><img src="./img/canvas/address.png">'+msg.result[i].map_content+'<br>시작:&nbsp;<select id="startHalf" style="font-size:14px"><option>AM</option><option>PM</option></select>'
                   +'&nbsp;<select id="startHH"><option>00</option><option>01</option><option>02</option><option>03</option><option>04</option><option>05</option><option>06</option><option>07</option><option>08</option><option>09</option><option>10</option><option>11</option></select>'
                   +'&nbsp;<select id="startMM"><option>00</option><option>30</option></select>'                  
                   +'<br>종료:&nbsp;<select id="endHalf" style="font-size:14px"><option>AM</option><option>PM</option></select>'
                   +'&nbsp;<select id="endHH"><option>00</option><option>01</option><option>02</option><option>03</option><option>04</option><option>05</option><option>06</option><option>07</option><option>08</option><option>09</option><option>10</option><option>11</option></select>'
                   +'&nbsp;<select id="endMM"><option>00</option><option>30</option></select>'  
                   +'<div style="margin-top: 5px;"><button style="width:100px; height=30px;" onclick="daysMake()">일정등록</button></div>',
                   removable : true
               });                  
               
               (function(foodMarker, foodMarkerInfo) {
                    // 마커에 mouseover 이벤트를 등록하고 마우스 오버 시 인포윈도우를 표시합니다 
                   daum.maps.event.addListener(foodMarker, 'click', function() {
                    // 마커 위에 인포윈도우를 표시합니다                    
                      foodMarkerInfo.open(map, foodMarker);    
                        marker = foodMarker;
                  });                         
                })(foodMarker, foodMarkerInfo);
               
            }
         }, error : function() {
            alert("실패");
         }
      });
    }
    
   // ------- 검색 ------ // 
   // 장소 검색 객체를 생성합니다
   function searchKeyword() {
      var ps = new daum.maps.services.Places(); 
      var value = $("#searchKeyword").val();
      // 키워드로 장소를 검색합니다
      ps.keywordSearch(value, placesSearchCB); 

      // 키워드 검색 완료 시 호출되는 콜백함수 입니다
      function placesSearchCB (data, status, pagination) {
                  
          if (status === daum.maps.services.Status.OK) {
         
              // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
              // LatLngBounds 객체에 좌표를 추가합니다
              var bounds = new daum.maps.LatLngBounds();

              for (var i=0; i<data.length; i++) {
                  displayMarker(data[i]);    
                  bounds.extend(new daum.maps.LatLng(data[i].y, data[i].x));
              }       
              // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
              map.setBounds(bounds);
          } 
      }

      // 지도에 마커를 표시하는 함수입니다
      function displayMarker(place) {
          
          // 마커를 생성하고 지도에 표시합니다
          var keywordMarker = new daum.maps.Marker({
              map: map,
              position: new daum.maps.LatLng(place.y, place.x) 
          });
          
          var keywordInfo = new daum.maps.InfoWindow({
             content : '<div style="width:200px; height:140px;">일정제목 &nbsp;<input style="width:100px; height=30px;" type="text" id="daysTitle" value="'+place.place_name+'">'
             +'<br><div style="font-size:14px;"><img src="./img/canvas/address.png">'+place.address_name+'<br>시작:&nbsp;<select id="startHalf" style="font-size:14px"><option>AM</option><option>PM</option></select>'
             +'&nbsp;<select id="startHH"><option>00</option><option>01</option><option>02</option><option>03</option><option>04</option><option>05</option><option>06</option><option>07</option><option>08</option><option>09</option><option>10</option><option>11</option></select>'
             +'&nbsp;<select id="startMM"><option>00</option><option>30</option></select>'                  
             +'<br>종료:&nbsp;<select id="endHalf" style="font-size:14px"><option>AM</option><option>PM</option></select>'
             +'&nbsp;<select id="endHH"><option>00</option><option>01</option><option>02</option><option>03</option><option>04</option><option>05</option><option>06</option><option>07</option><option>08</option><option>09</option><option>10</option><option>11</option></select>'
             +'&nbsp;<select id="endMM"><option>00</option><option>30</option></select>'  
             +'<div style="margin-top: 5px;"><button style="width:100px; height=30px;" onclick="daysMake()">일정등록</button></div>',
             removable : true
         });

          // 마커에 클릭이벤트를 등록합니다
          daum.maps.event.addListener(keywordMarker, 'click', function() {
              // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
              //keywordInfo.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
              keywordInfo.open(map, keywordMarker);
              marker = keywordMarker;
          });
      }
   }
   
   $('#searchKeyword').keyup(function(e) {
          if (e.keyCode == 13) searchKeyword();        
   });
   
   // 뒤로 가기 이벤트
   function moveDetailCanvas(sketch_id) {
		location.href="./detailCanvas.do?sketch_id="+sketch_id;
	}  
   
   </script>
   
   <script type="text/javascript">
   $(function() {
       //single book
       $('#mybook').booklet({
            width:  960,
               height: 650,
               shadow: false,
               pageNumbers : false,
       });    
   });
   </script>
   
   
   
</body>
</html>



