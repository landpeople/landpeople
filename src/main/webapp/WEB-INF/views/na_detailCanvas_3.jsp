<%@page import="happy.land.people.dto.kim.LPTextDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	List<LPTextDto> list = (List<LPTextDto>)request.getAttribute("list3");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레이아웃 3번 조회 페이지</title>
<!-- 토스트 에디터  -->
<link rel="stylesheet" href="https://uicdn.toast.com/tui-editor/latest/tui-editor.css"></link>
<link rel="stylesheet" href="https://uicdn.toast.com/tui-editor/latest/tui-editor-contents.css"></link>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.33.0/codemirror.css"></link>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.12.0/styles/github.min.css"></link>
<script src="https://uicdn.toast.com/tui-editor/latest/tui-editor-Editor-full.js"></script>
<!-- CSS -->
<link rel="stylesheet" href="css/Layout_1.css">
<!-- jQuery -->
<script type="text/javascript" src="./js/jquery-3.3.1.js"></script>
</head>
<body>
		<!-- 왼쪽 -->
		<div id="Left-Side">
			<div id="IMG1" style="background-image: url('<%=list.get(0).getImg_spath()%>')">
			</div>
		</div>
		
		<!-- 오른쪽 -->
		<div id="Right-Side">
			<div id="RS_TContainer">
				<div id="TXT1">
				<%=list.get(1).getText_content() %>
				</div>
				<div id="TXT2">
				<%=list.get(2).getText_content() %>
				</div>
			</div>
			<div id="RS_IContainer">
				<div id="IMG2" style="background-image: url('<%=list.get(3).getImg_spath()%>')">
				</div>
				<div id="IMG3" style="background-image: url('<%=list.get(4).getImg_spath()%>')">
				</div>
				<div id="TXT3">
				<%=list.get(5).getText_content() %>
				</div>
			</div>
		</div>
</body>
</html>