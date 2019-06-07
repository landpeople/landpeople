<%@page import="org.springframework.beans.factory.annotation.Autowired"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
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

<!-- Custom fonts for this template-->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

<link rel="stylesheet" type="text/css" href="./css/sweetalert.css">

<!-- Custom styles for this template-->
<link href="./css/theme/sb-admin-2.css" rel="stylesheet">
<link href="./css/theme/lp-template.css" rel="stylesheet">
<link href="./css/sketch/modal.css" rel="stylesheet">
<link rel="stylesheet" href="./css/manager/manager.css">
<link rel="stylesheet" type="text/css" media="screen" href="./css/jquery-ui.css" />
<link rel="stylesheet" type="text/css" media="screen" href="./css/manager/ui.jqgrid.css" />

</head>

<script type="text/javascript" src="./js/BoardList.js"></script>
<script type="text/javascript" src="./js/jquery-3.3.1.js"></script>
<script type="text/javascript" src="./js/grid.locale-kr.js"></script>
<script type="text/javascript" src="./js/jquery.jqGrid.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {

    var cnames = ['아이디', '상대방', '최근메시지', '날짜'];

    $("#jqGrid").jqGrid({

         url: "./selectChatList.do",
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
            colModel: [
            	{ name: 'CHR_ID', index: 'chr_id', key: true, width: 180, align: 'center', hidden: true },
                { name: 'CHR_RECEIVER', index: 'chr_receiver', width: 180, align: 'center' },
                { name: 'CHC_MESSAGE', index: 'chc_message', width: 455, align: 'center' },
                { name: 'CHC_REGDATE', index: 'chc_regdate', width: 155, align: 'center' }
                       ],
            height: 504,
            rowNum: 10,
            rowList: [10,20,30],
            pager: '#jqGridPager',
            rownumbers  : true, // row 넘버를 보여줄지 말지
            viewrecords : true, // 현재 몇 페이지며 총 데이터가 몇개인지를 보여 주는 설정        
            emptyrecords : "데이터가 없습니다.",
            multiselect : true,
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
        }).trigger("reloadGrid"); // jqgrid가 데이터를 가져온 후 리로드를 해줘야 그리드에 적용이 되기 때문에 작업이 완료된 후 reload를 해줌
    });

   // 다중 삭제
   function mutidel(){
	   		var ids = jQuery("#jqGrid").jqGrid('getGridParam', 'selarrrow');
            location.href="./deleteChatroom.do?chksVal="+ids;
   }
</script>            
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
               <div class="lp-other-content shadow-lg">
				<div id="jqGridDiv">
                  <h3>채팅 리스트</h3>
                  <hr>
			   	  <button id="mutidel" class="" onclick="mutidel()">채팅방 나가기</button>
                  <hr>
                  <table id="jqGrid"></table>
                  <div id="jqGridPager"></div>
               </div>
               
               
               </div>
            </div>
            <!--End of Page LandPeople Content Area -->
            <%@include file="../common/lp-footer.jsp"%>
            <!-- End of Page Wrapper -->
         </div>
      </div>
   </div>
</body>
</html>