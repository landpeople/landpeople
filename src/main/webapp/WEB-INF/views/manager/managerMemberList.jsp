<%@page import="org.springframework.beans.factory.annotation.Autowired"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <% request.setCharacterEncoding("UTF-8"); %>
    <% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체 회원 조회</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="./css/manage.css">
<link rel="stylesheet" href="./css/normalize.css">
<link rel="stylesheet" href="./css/font-awesome.css">
<link rel="stylesheet" href="./css/bootstrap.min.css">
<link rel="stylesheet" href="./css/templatemo-style.css">
<link rel="stylesheet" href="./css/BoardList.css">
<link rel="stylesheet" type="text/css" media="screen" href="./css/jquery-ui.css" />
<link rel="stylesheet" type="text/css" media="screen" href="./css/ui.jqgrid.css" />

<script src="./js/vendor/modernizr-2.6.2.min.js"></script>
<script src="./js/min/plugins.min.js"></script>
<script src="./js/min/main.min.js"></script>
<script type="text/javascript" src="./js/BoardList.js"></script>
<script type="text/javascript" src="./js/jquery-3.3.1.js"></script> 
<script type="text/javascript" src="./js/grid.locale-kr.js"></script>
<script type="text/javascript" src="./js/jquery.jqGrid.min.js"></script>
<script type="text/javascript">
$(document).ready(function () {
	
	var cnames = ['이메일','닉네임','등급','삭제 여부','메일 인증 여부','권한'];
	
    $("#jqGrid").jqGrid({
    	
        url: "./searchMemberList.do",
        datatype: "local",
        cellEdit: true,
        cellsubmit: "remote",
        jsonReader: {
        	records: "records",
        	rows: "rows",
        	page: "page",
        	total: "total"
        },
        colNames: cnames,
        // name은 db의 컬럼명과 일치해야함 , index는 jsp에서 쓸 변수명
        colModel: [
            { name: 'USER_EMAIL', index: 'user_email', key: true, width: 280, align: 'center' },
            { name: 'USER_NICKNAME', index: 'user_nickname', width: 205, align: 'center' },
            { name: 'USER_AUTH', index: 'user_auth', width: 80, align: 'center' },
            { name: 'USER_DELFLAG', index: 'user_delflag', width: 80, align: 'center' },
            { name: 'USER_EMAILCHK', index: 'user_emailchk', width: 80, align: 'center' },
            { name: 'USER_ISWRITE', index:'user_iswrite', width:80, editable:true, align: 'center', edittype: "select",
                editoptions: {
                 value : {"False":"F","True":"T"}, 
                  dataEvents : [{type: 'change',
                      fn : function(e) {  
                    	  
							var input = $("#jqGrid").getGridParam("selrow");

						 	$.ajax({
							    url: "modifyIswrite.do", // 클라이언트가 요청을 보낼 서버의 URL 주소
							    data: { email: input },                // HTTP 요청과 함께 서버로 보낼 데이터
							    type: "POST",                             
							    dataType: "json",                         // 서버에서 보내줄 데이터의 타입
							    success : function(result) {
									alert("ajax 성공");
								}
							});
                      					}
                  				}]
                			}
            }
        ],
        height: 614,
        rowNum: 10,
        rowList: [10,20,30],
        pager: '#jqGridPager',
        rownumbers  : true, // row 넘버를 보여줄지 말지
        viewrecords : true, // 현재 몇 페이지며 총 데이터가 몇개인지를 보여 주는 설정        
        emptyrecords : "데이터가 없습니다.",
//      caption:"전체 회원 조회",
//      multiselect: true,
//      sortname : "user_nickname",
//      sortorder : "asc",
//      sortable: true,
        loadonce : false // loadonce가 true면 (정렬이 되면) 페이징이 안됨...
    });
});

$(document).ready(function() {

 var jsonObj = {};
 var jsonObj2 = {};
    
	jsonObj.serviceImplYn = $("#selectId").val();
	jsonObj2.input = $("#input").val();
    
    $("#jqGrid").setGridParam({
        datatype : "json",
        postData : {"param" : JSON.stringify(jsonObj), "param2" : JSON.stringify(jsonObj2)},
//         loadComplete : function(data) {
//         },
//         gridComplete : function() {
//         }
    }).trigger("reloadGrid"); // jqgrid가 데이터를 가져온 후 리로드를 해줘야 그리드에 적용이 되기 때문에 작업이 완료된 후 reload를 해줌
});

</script>

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
	<div class="banner-bg" id="top">
		<div class="banner-overlay"></div>
		<div class="welcome-text"></div>
	   </div>
	   
<div class="main-content">
	<div class = "fluid-container">
		<div>
		 <a href="./jang.do">뒤로가기</a><br>
		 <select id="selectId">
		  <option value="" selected="selected">전체</option>
		  <option value="user_email">이메일</option>
		  <option value="user_nickname">닉네임</option>
		</select>
		
		 <span><input id="input" type="text" placeholder="검색어를 입력하세요" value=""></span>
		 <span><input id="inputBtn" type="button" value="search" onclick="search()"> </span>
		</div>
		<table id="jqGrid"></table>
		<div id="jqGridPager"></div>
	</div>
</div>

</body>
</html>