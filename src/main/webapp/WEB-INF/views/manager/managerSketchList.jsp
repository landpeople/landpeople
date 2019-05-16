<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <% request.setCharacterEncoding("UTF-8"); %>
    <% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체 스케치북 조회</title>
<link rel="stylesheet" href="./css/BoardList.css">
<link rel="stylesheet" type="text/css" media="screen" href="./css/jquery-ui.css" />
<link rel="stylesheet" type="text/css" media="screen" href="./css/ui.jqgrid.css" />
    
<script type="text/javascript" src="./js/BoardList.js"></script>
<script type="text/javascript" src="./js/jquery-3.3.1.js"></script> 
<script type="text/javascript" src="./js/grid.locale-kr.js"></script>
<script type="text/javascript" src="./js/jquery.jqGrid.min.js"></script>
<script type="text/javascript">
$(document).ready(function () {
	
	var cnames = ['아이디','작성자 메일','제목','테마','공유여부','삭제여부','공개여부'];
	
    $("#jqGrid").jqGrid({
    	
        url: "./searchSketchList.do",
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
            { name: 'SKETCH_ID', index: 'sketch_id', key : true, width: 70 },
            { name: 'USER_EMAIL', index: 'user_email', width: 160 },
            { name: 'SKETCH_TITLE', index: 'sketch_title', width: 100 },
            { name: 'SKETCH_THEME', index: 'sketch_theme', width: 100 },
            { name: 'SKETCH_SHARE', index: 'sketch_share', width: 80 },
            { name: 'SKETCH_DELFLAG', index: 'sketch_delflag', width: 80 },
            { name: 'SKETCH_BLOCK', index: 'sketch_block', width: 80, editable:true, edittype: "select",
   				editoptions: {
                    value : {"False":"F","True":"T"}, 
                     dataEvents : [{type: 'change',
                         fn : function(e) {  
   							var input = $("#jqGrid").getGridParam("selrow");

   							$.ajax({
   							    url: "modifyBlock.do", 
   							    data: { id: input }, 
   							    type: "POST",                             
   							    dataType: "json",
   							    success : function(result) {
   												alert("ajax 성공");
   															}
   								   });
                         					}
                     				}]
                   			}}
        ],
        height: 480,
        rowNum: 10,
        rowList: [10,20,30],
        pager: '#jqGridPager',
        rownumbers  : true,   
        viewrecords : true,
//         sortname : "sketch_title",
//         sortorder : "asc",
        emptyrecords : "데이터가 없습니다.",
        multiselect: true,
        caption:"전체 스케치북 조회",
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
        postData : {"param" : JSON.stringify(jsonObj), "param2" : JSON.stringify(jsonObj2)},
        loadComplete : function(data) {
        },
        gridComplete : function() {
        }
    }).trigger("reloadGrid"); // jqgrid가 데이터를 가져온 후 리로드를 해줘야 그리드에 적용이 되기 때문에 작업이 완료된 후 reload를 해줌
});

</script>
</head>
<div>
<a href="./jang.do">뒤로가기</a><br>
 <select id="selectId">
  <option value="" selected="selected">전체</option>
  <option value="user_email">작성자</option>
  <option value="sketch_title">제목</option>
</select>

 <span><input id="input" type="text" placeholder="검색어를 입력하세요" value=""></span>
 <span><input type="button" value="search" onclick="search()"> </span>
</div>

<table id="jqGrid"></table>
<div id="jqGridPager"></div>
</body>
</html>