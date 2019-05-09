<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>김태우 화면 테스트</title>

<script src="./js/jquery-3.3.1.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<!-- 카카오 지도를 위한 js파일 -->
<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=2a8ce23f7f516bf0c39441ce65105c56&libraries=services"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">

<link rel="stylesheet" href="./css/normalize.css">
<link rel="stylesheet" href="./css/font-awesome.css">
<link rel="stylesheet" href="./css/bootstrap.min.css">
<link rel="stylesheet" href="./css/templatemo-style.css">

<script src="./js/vendor/modernizr-2.6.2.min.js"></script>
<script src="./js/min/plugins.min.js"></script>
<script src="./js/min/main.min.js"></script>

</head>
	<body>
	<!-- SIDEBAR -->
	<div class="sidebar-menu hidden-xs hidden-sm">
		<div class="top-section" style="padding-bottom: 0;">
			<div class="profile-image">
				<img src="img/제주배경임.png" alt="Volton">
			</div>
			<!--  <h3 class="profile-title">Volton</h3>
                <p class="profile-description">Digital Photography</p> -->
		</div>
		<!-- .top-section -->
		<div class="main-navigation">
			<ul class="navigation">
				<li><a href="#"><i class="fa fa-globe"></i>Welcome</a></li>
				<li><a href="#"><i class="fa fa-pencil"></i>About Me</a></li>
				<li><a href="#"><i class="fa fa-paperclip"></i>My Gallery</a></li>
				<li><a href="#"><i class="fa fa-link"></i>Contact Me</a></li>
			</ul>
		</div>
		<!-- .main-navigation -->

		<!-- 채팅 -->
		<div class="chatting"></div>
	</div>
	<!-- .sidebar-menu -->

	

	<!-- main에 있는 header 영역임 main 페이지 말고는 사용을 안하지만, 그냥 주석함. 지워도 됨-->
	<!-- <div class="banner-bg" id="top"> -->
	<!-- 	<div class="banner-overlay"></div> -->
	<!-- 		<div class="welcome-text"> -->
	<!-- 			<h2>LandPeople</h2> -->
	<!--            <h5>This is a mobile friendly layout with Bootstrap v3.3.1 framework. Maecenas eu ante at nunc posuere fringilla sit amet non dolor. Proin condimentum fermentum nunc.</h5> -->
	<!--        </div> -->
	<!--    </div> -->
	<!-- </div> -->
	
	<!-- 여기에 div 잡아서 작업하면 됨 -->
	<!-- templatemo-style.css에 보면 이안에 들어가는 div 클래스가 있음. 아니면 css를 temp -->
	<div class="main-content">			
			 <a href="./loadMap.do">아아아</a>	
			 <button onclick="showFood()">음식점</button>
			 <button onclick="showTrip()">관광지</button>
			 <button onclick="showRest()">숙소</button>
			 <div id="map" style="width:450px;height:450px;">			 	
			 </div>			
			 <p id="result"></p>
			 <a href="#" id="kakaomap">최단경로보기</a>
	</div>
	
	<script>
  		var chk = 1;   
		var container = document.getElementById('map');
		var options = {
			center: new daum.maps.LatLng(33.450701, 126.570667),
			level: 3
		};
		var map = new daum.maps.Map(container, options);
		// 마커들
		var markers = [];		
		var startMarker;
		var endMarker;
	
		/* var icon = new daum.maps.MarkerImage(
		        './food.png',
		        new daum.maps.Size(32, 32));
		
		var icon2 = new daum.maps.MarkerImage(
		        './tree.png',
		        new daum.maps.Size(32, 32)); */
	
		daum.maps.event.addListener(map, 'click',function(mouseEvent){
			// 클릭한 위도, 경도 정보를 가져옵니다 
		    var latlng = mouseEvent.latLng;
		    
		    var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
		    message += '경도는 ' + latlng.getLng() + ' 입니다';
		    
		    var resultDiv = document.getElementById('result'); 
		    resultDiv.innerHTML = message;
		    if(chk == 1){
			    startMarker = new daum.maps.Marker({ 			    
				    position: new daum.maps.LatLng(latlng.getLat(), latlng.getLng()),
				    clickable: true				   
			    }); 
				// 지도에 마커를 표시합니다
				startMarker.setMap(map);
				startMarker.setDraggable(true);
				chk++;
			}
		    
		    else if(chk == 2){
		    	endMarker = new daum.maps.Marker({ 			    
				    position: new daum.maps.LatLng(latlng.getLat(), latlng.getLng()),
				    clickable: true 				   
			    }); 
				// 지도에 마커를 표시합니다
				endMarker.setMap(map);
				endMarker.setDraggable(true);
				chk++;
				change(startMarker,endMarker);
				
				var linePath = [
				    new daum.maps.LatLng(startMarker.getPosition().getLat(), startMarker.getPosition().getLng()),
				    new daum.maps.LatLng(endMarker.getPosition().getLat(), endMarker.getPosition().getLng())		   
				];

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
		    
			// 인포윈도우를 생성합니다
			var infowindow = new daum.maps.InfoWindow({
			    content : '<div style="padding:5px;">출발점</div>',
			    removable : true
			});
			
			daum.maps.event.addListener(startMarker, 'click', function() {
			     // 마커 위에 인포윈도우를 표시합니다
			      infowindow.open(map, startMarker); 
			      //navi(marker);
			     // change(startMarker);
			});			
			
			/* if(endMarker != null){
			daum.maps.event.addListener(endMarker, 'dragend', function() {
				alert("이동완료");
			     // 도착 마커의 드래그가 종료될 때 마커 이미지를 원래 이미지로 변경합니다
			    //arriveMarker.setImage(arriveImage);  
				var linePath = [
				    new daum.maps.LatLng(startMarker.getPosition().getLat(), startMarker.getPosition().getLng()),
				    new daum.maps.LatLng(endMarker.getPosition().getLat(), endMarker.getPosition().getLng())		   
				];
	
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
				});
			} */
		});
		
		function change(startMarker , endMarker) {
			//var geocoder = new daum.maps.services.Geocoder(); // 좌표계 변환 객체를 생성합니다
			var startCoord = new daum.maps.LatLng(startMarker.getPosition().getLat(), startMarker.getPosition().getLng());
			var endCoord =  new daum.maps.LatLng(endMarker.getPosition().getLat(), endMarker.getPosition().getLng());
			$("#kakaomap").attr("href" , "https://map.kakao.com/?sX="+startCoord.toCoords().getX()+"&sY="+startCoord.toCoords().getY()+"&sName=출발점&eX="+endCoord.toCoords().getX()+"&eY="+endCoord.toCoords().getY()+"&eName=도착점");
			
			//location.href="https://map.kakao.com/?sX="+startCoord.toCoords().getX()+"&sY="+startCoord.toCoords().getY()+"&sName=출발점&eX="+endCoord.toCoords().getX()+"&eY="+endCoord.toCoords().getY()+"&eName=도착점";			
		}		
		
		if(endMarker != null){
			
		}
	
		//https://map.kakao.com/?sX=400437.5000000028&sY=-11539.999999998836&sName=%EC%9A%B0%EB%A6%AC%EC%A7%91&eX=400437.5000000028&eY=-11538.999999998836&eName=%EC%97%AD%EC%82%BC%EC%97%AD
			//alert(coord.toCoords().getX());
			//alert(coord.toCoords().getY());
		
		//wtmX = 160082.538257218, // 변환할 WTM X 좌표 입니다
	   // wtmY = -4680.975749087054; // 변환할 WTM Y 좌표 입니다
 		// var ps = new daum.maps.services.Places(); 

	/*  // 키워드로 장소를 검색합니다
	 ps.keywordSearch('쇠소깍', placesSearchCB); 

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
	 } */

	 // 지도에 마커를 표시하는 함수입니다
	/*  function displayMarker(place) {	     
	     // 마커를 생성하고 지도에 표시합니다
	     var marker = new daum.maps.Marker({
	         map: map,
	         position: new daum.maps.LatLng(place.y, place.x) 
	     });	   
	 } */
	 
	 function showFood() {
		alert("음식점 보여주기");
		 for(var i = 0; i < markers.length; i++)
			 markers[i].setMap(null);
		
		 $.ajax({
				url: "showFood.do", //요청 url
				type: "post", // 전송 처리방식
				asyn: false, // true 비동기 false 동기
				data: { 'type' : "음식점"}, // 서버 전송 파라메터
				dataType: "json", // 서버에서 받는 데이터 타입
				success: function(msg){	
					alert(msg.result[0].map_id);	
					for(var i = 0; i < msg.result.length ; i++){
						var foodMarker  = 	new daum.maps.Marker({ 			    
						    position: new daum.maps.LatLng(msg.result[i].map_y, msg.result[i].map_x),
						    clickable: true				   
					    }); 		
						
						// 지도에 마커를 표시합니다
						foodMarker.setMap(map);	
						markers.push(foodMarker);
						var foodMarkerInfo = new daum.maps.InfoWindow({
						    content : '<div style="padding:5px;">'+msg.result[i].map_title+'</div><button>일정등록</button><button>닫기</button>',
						    removable : true
						});						
						
						(function(foodMarker, foodMarkerInfo) {
					        // 마커에 mouseover 이벤트를 등록하고 마우스 오버 시 인포윈도우를 표시합니다 
					       daum.maps.event.addListener(foodMarker, 'click', function() {
						     // 마커 위에 인포윈도우를 표시합니다						    
						    	 foodMarkerInfo.open(map, foodMarker); 							     
							});						       
					    })(foodMarker, foodMarkerInfo);
						
					}
				}, error : function() {
					alert("실패");
				}
			});			
		}	 
	 
	 // 관광지보기
	 function showTrip(){
		 for(var i = 0; i < markers.length; i++)
			 markers[i].setMap(null);
		 
		 $.ajax({
				url: "showTrip.do", //요청 url
				type: "post", // 전송 처리방식
				asyn: false, // true 비동기 false 동기
				data: { 'type' : "관광"}, // 서버 전송 파라메터
				dataType: "json", // 서버에서 받는 데이터 타입
				success: function(msg){	
					alert(msg.result[0].map_id);	
					for(var i = 0; i < msg.result.length ; i++){
						var foodMarker  = 	new daum.maps.Marker({ 			    
						    position: new daum.maps.LatLng(msg.result[i].map_y, msg.result[i].map_x),
						    clickable: true				   
					    }); 		
						
						// 지도에 마커를 표시합니다
						foodMarker.setMap(map);	
						markers.push(foodMarker);
						var foodMarkerInfo = new daum.maps.InfoWindow({
						    content : '<div style="padding:5px;">'+msg.result[i].map_title+'</div><button>일정등록</button><button>닫기</button>',
						    removable : true
						});						
						
						(function(foodMarker, foodMarkerInfo) {
					        // 마커에 mouseover 이벤트를 등록하고 마우스 오버 시 인포윈도우를 표시합니다 
					       daum.maps.event.addListener(foodMarker, 'click', function() {
						     // 마커 위에 인포윈도우를 표시합니다						    
						    	 foodMarkerInfo.open(map, foodMarker); 							     
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
 		 
 		$.ajax({
			url: "showRest.do", //요청 url
			type: "post", // 전송 처리방식
			asyn: false, // true 비동기 false 동기
			data: { 'type' : "숙박"}, // 서버 전송 파라메터
			dataType: "json", // 서버에서 받는 데이터 타입
			success: function(msg){	
				alert(msg.result[0].map_id);	
				for(var i = 0; i < msg.result.length ; i++){
					var foodMarker  = 	new daum.maps.Marker({ 			    
					    position: new daum.maps.LatLng(msg.result[i].map_y, msg.result[i].map_x),
					    clickable: true				   
				    }); 		
					
					// 지도에 마커를 표시합니다
					foodMarker.setMap(map);	
					markers.push(foodMarker);
					var foodMarkerInfo = new daum.maps.InfoWindow({
					    content : '<div style="padding:5px;">'+msg.result[i].map_title+'</div><button>일정등록</button><button>닫기</button>',
					    removable : true
					});						
					
					(function(foodMarker, foodMarkerInfo) {
				        // 마커에 mouseover 이벤트를 등록하고 마우스 오버 시 인포윈도우를 표시합니다 
				       daum.maps.event.addListener(foodMarker, 'click', function() {
					     // 마커 위에 인포윈도우를 표시합니다						    
					    	 foodMarkerInfo.open(map, foodMarker); 							     
						});						       
				    })(foodMarker, foodMarkerInfo);
					
				}
			}, error : function() {
				alert("실패");
			}
		});
	 }
	</script>
	
	
	</body>
</html>