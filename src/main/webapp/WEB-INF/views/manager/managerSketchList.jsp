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

      var cnames = [ '글번호', '작성자', '제목', '테마', '공유여부', '공개여부*' ];

      $("#jqGrid").jqGrid({

         url : "./searchSketchList.do",
         datatype : "local",
         cellEdit : true,
         cellsubmit : "remote",
         jsonReader : {
            records : "records",
            rows : "rows",
            page : "page",
            total : "total"
         },
         colNames : cnames,
         // name은 db의 컬럼명과 일치해야함 , index는 jsp에서 쓸 변수명
         colModel : [ {
            name : 'SKETCH_ID',
            index : 'sketch_id',
            key : true,
            width : 50,
            align : 'center'
         }, {
            name : 'USER_NICKNAME',
            index : 'user_nickname',
            width : 200,
            align : 'center'
         }, {
            name : 'SKETCH_TITLE',
            index : 'sketch_title',
            width : 333,
            align : 'center'
         }, {
            name : 'SKETCH_THEME',
            index : 'sketch_theme',
            width : 80,
            align : 'center'
         }, {
            name : 'SKETCH_SHARE',
            index : 'sketch_share',
            width : 80,
            align : 'center'
         }, {
            name : 'SKETCH_BLOCK',
            index : 'sketch_block',
            width : 81,
            editable : true,
            align : 'center',
            edittype : "select",
            editoptions : {
               value : {
                  "False" : "F",
                  "True" : "T"
               },
               dataEvents : [ {
                  type : 'change',
                  fn : function(e) {
                     var input = $("#jqGrid").getGridParam("selrow");

                     $.ajax({
                        url : "modifyBlock.do",
                        data : {
                           id : input
                        },
                        type : "POST",
                        dataType : "json",
                        success : function(result) {
                           alert("ajax 성공");
                        }
                     });
                  }
               } ]
            }
         } ],
         height : 504,
         rowNum : 10,
         rowList : [ 10, 20, 30 ],
         pager : '#jqGridPager',
         rownumbers : true,
         viewrecords : true,
         //         sortname : "sketch_title",
         //         sortorder : "asc",
         emptyrecords : "데이터가 없습니다.",
         //         multiselect: true,
         //         caption:"전체 스케치북 조회",
         //         sortable: true,
         loadonce : false
      });
   });

   $(document).ready(function() {

      var jsonObj = {};
      var jsonObj2 = {};

      jsonObj.serviceImplYn = $("#selectId").val();
      jsonObj2.input = $("#input").val();

      $("#jqGrid").setGridParam({
         datatype : "json",
         postData : {
            "param" : JSON.stringify(jsonObj),
            "param2" : JSON.stringify(jsonObj2)
         },
//          loadComplete : function(data) {
//          },
//          gridComplete : function() {
//          }
      }).trigger("reloadGrid"); // jqgrid가 데이터를 가져온 후 리로드를 해줘야 그리드에 적용이 되기 때문에 작업이 완료된 후 reload를 해줌
   });
   
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
               <div class="lp-content-header">
                  <h1 id="title" class="h2 mb-4 text-gray-800 lp-content-title">Member Sketchbook list</h1>
                     <div id="selectDiv">
                        <select id="selectId">
                           <option value="" selected="selected">전체</option>
                           <option value="user_nickname">작성자</option>
                           <option value="sketch_title">제목</option>
                        </select> 
                        <input id="input" type="text" placeholder="검색어를 입력하세요" value="">
                        <button id="inputBtn" onclick="search()"><i class="fas fa-search"></i></button>
                     </div>
                     </div>
               <div id="jqGridDiv">
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



