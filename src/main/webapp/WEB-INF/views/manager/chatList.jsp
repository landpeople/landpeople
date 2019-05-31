<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채팅방 목록</title>
<script src="./js/jquery-3.3.1.js"></script>

</head>
<script type="text/javascript">
	function allSel(bool) {
		var chks = document.getElementsByName("chk");
		for (var i = 0; i < chks.length; i++) {
			chks[i].checked = bool;
		}
	}
	
	function mutidel(){
		   var chksVal = [];
		   $('input:checkbox[name="chk"]:checked').each(function () {
			   chksVal.push($(this).val());
		   });
		      location.href="./deleteChatroom.do?chksVal="+chksVal;
		}
	
</script>
<body>
<table>
	<button onclick="mutidel()" >채팅방 나가기</button>
	<tr>
		<th><input type="checkbox" onclick="allSel(this.checked)"></th><th>상대방</th><th>최근메시지</th><th>날짜</th>
	</tr>
	<c:forEach var="list" items="${resultLists}" varStatus="status" >
		<tr>
			<td><input type="checkbox" name="chk" value="${list.get(0).get('CHR_ID')}"></td>
			<td>${list.get(0).get("CHR_RECEIVER")}</td>
			<td>${list.get(0).get("CHC_MESSAGE")}</td>
			<td>${list.get(0).get("CHC_REGDATE")}</td>
		</tr>
	</c:forEach>
</table>
</body>
</html>