<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<meta charset="UTF-8">
<html>
<!-- Custom styles for this template-->
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">
<link href="./css/theme/sb-admin-2.css" rel="stylesheet">
<link href="./css/theme/lp-template.css" rel="stylesheet">
<link href="./css/chat/chatlist.css" rel="stylesheet">

<title>Chatable members</title>
<body class="scroll"><!-- 스크롤바 스타일을 주기 위해 style-3을 아이디로 줌 -->
	<%
		response.setHeader("P3P", "CP='CAO PSA CONi OTR OUR DEM ONL'"); // iframe 세션이 날아가지 않도록 잡아줌
		String session_name = ""; // session_name은 세션의 이름으로 저장할 변수
		String session_value = ""; // session_value는 세션의 내용으로 저장할 변수

		Enumeration enum_01 = session.getAttributeNames(); // 세션에 모든 이름들을 Enumeration에 하나씩 저장한다.

		while (enum_01.hasMoreElements()) {
			// hasMoreElements 0부터 시작 값이 있으면 true의 의미
			session_name = enum_01.nextElement().toString();// 해당 Enumeration 에서 세션 이름을 꺼내고
			session_value = session.getAttribute(session_name).toString();//해당 이름을 가지고 세션 value를 꺼낸다.
			System.out.println("SESSION NAME[ " + session_name + " ] SESSION VALUE [ " + session_value + " ]");
		}
	%>
	<div>
		<!--    <span class="user-list" id="timer"></span> -->
		<!-- 세션 만료 시간 알려주는 임시 span -->
		<!--    <a href="javascript:refreshTimer();"></a> -->
		<div class="chatable-member">
			<h6 class="chatmember-header">Chatable members</h6>
			<div class="refresh-block">
				<c:if test="${not empty ldto}">
					<a id="refresh"> <img class="lp-refresh"
						src="./img/chat/refresh.png"
						onMouseOver="this.src='./img/chat/refresh-hover.png'"
						onMouseOut="this.src='./img/chat/refresh.png'" border="0">
					</a>
				</c:if>
			</div>
		</div>
		<c:choose>
			<c:when test="${ldto ne null}">
				<div id="userlist">
					<c:forEach items="${users}" var="user">
						<c:if test="${ldto.user_nickname ne user}">
							<!-- 내가 아닌 상대방만 접속한 사용자정보에 출력됨 -->
							<a class="user-list" href="#">${user}</a>
							<!-- js파일에서 el값을 가져가기 위해 hidden 시켜서 처리 -->
							<input id='${user}input' type="hidden" value=${ldto.user_nickname}>
						</c:if>
					</c:forEach>
				</div>
			</c:when>
			<c:otherwise>
				<p class="user-status">You can chat after logging in.</p>
			</c:otherwise>
		</c:choose>
	</div>
	<!-- <script type="text/javascript" charset="utf-8" src="./js/chat/timeoutchk.js"></script> -->
	<!-- Bootstrap core JavaScript-->
	<script src="./js/theme/jquery.min.js"></script>
	<script src="./js/chat/chatlist.js"></script>
</body>
</html>