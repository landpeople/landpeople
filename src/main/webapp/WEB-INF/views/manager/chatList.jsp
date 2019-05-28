<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<table>
	<tr>
		<th>상대방</th><th>최근메시지</th><th>날짜</th>
	</tr>
	<c:forEach var="list" items="${resultLists}" varStatus="status" >
		<tr>
			<td>${list.get(0).get("CHR_RECEIVER")}</td>
			<td>${list.get(0).get("CHC_MESSAGE")}</td>
			<td>${list.get(0).get("CHC_REGDATE")}</td>
		</tr>
	</c:forEach>
</table>
</body>
</html>