<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%
	response.setContentType("text/html; charset=UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체 스케치북 조회</title>
<link rel="stylesheet" href="./css/manage.css">
<link rel="stylesheet" type="text/css" media="screen"
	href="./css/jquery-ui.css" />
<link rel="stylesheet" type="text/css" media="screen"
	href="./css/ui.jqgrid.css" />
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

<script type="text/javascript" src="./js/BoardList.js"></script>
<script type="text/javascript" src="./js/jquery-3.3.1.js"></script>
<script type="text/javascript" src="./js/grid.locale-kr.js"></script>
<script type="text/javascript" src="./js/jquery.jqGrid.min.js"></script>

<!-- Custom styles for this template-->
<link href="./css/theme/sb-admin-2.css" rel="stylesheet">

<!--    Bootstrap core JavaScript-->
<!--    <script src="./js/theme/jquery.min.js"></script> --> <!-- 이거 하면 jqGrid 안됨 -->
   <script src="./js/theme/bootstrap.bundle.min.js"></script>

<!--    Core plugin JavaScript-->
   <script src="./js/theme/jquery.easing.min.js"></script>

<!--    Custom scripts for all pages-->
   <script src="./js/theme/sb-admin-2.min.js"></script>

   <script src="./js/chat/chat.js"></script>
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
				width : 313,
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
				width : 80,
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
// 			loadComplete : function(data) {
// 			},
// 			gridComplete : function() {
// 			}
		}).trigger("reloadGrid"); // jqgrid가 데이터를 가져온 후 리로드를 해줘야 그리드에 적용이 되기 때문에 작업이 완료된 후 reload를 해줌
	});
	
</script>
</head>
<body>
	<!--젤로 레이아웃- 전체 영역 감싸는 div-->
	<div class="main-wrapper">
		<%@include file="../common/Sidebar.jsp"%>
		<div class="content-wrapper">

			<!-- 메인 컨텐츠   -->
			<div class="lpcontents">
				<div class="content">
					<div id="jqGridDiv">
					<h3>육지 관리자</h3>
						<hr>
						<div id="selectDiv">
							<button onclick="location.href='./jqgrid.do'" id="memBtn" style="background: gray;"><i class="fas fa-users fa-2x"></i><br>회원</button>
							<button onclick="location.href='./jqgrid2.do'" id="sketBtn"><i class="fas fa-book-open fa-2x"></i><br>스케치북</button>
								<br>
							<select id="selectId">
								<option value="" selected="selected">전체</option>
								<option value="user_nickname">작성자</option>
								<option value="sketch_title">제목</option>
							</select> 
							<input id="input" type="text" placeholder="검색어를 입력하세요" value="">
							<button id="inputBtn" onclick="search()"><i class="fas fa-search"></i></button>
						</div>
						<hr>
						<table id="jqGrid"></table>
						<div id="jqGridPager"></div>
					</div>
				</div>
			</div>
			<div class="footer">landpeople</div>
		</div>
	</div>
</body>
</html>