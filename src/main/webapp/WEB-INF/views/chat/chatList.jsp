<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<meta charset="UTF-8">
<link rel="stylesheet" href="./fonts/stylesheet.css">

<style>
@import url('//cdn.jsdelivr.net/font-iropke-batang/1.2/font-iropke-batang.css');

@font-face {
	font-family: 'NanumBarunGothic';
	font-style: normal;
	font-weight: 400;
	src: url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWeb.eot');
	src: url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWeb.eot?#iefix') format('embedded-opentype'), url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWeb.woff') format('woff'), url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWeb.ttf') format('truetype');
}

@font-face {
	font-family: 'NanumBarunGothic';
	font-style: normal;
	font-weight: 700;
	src: url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWebBold.eot');
	src: url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWebBold.eot?#iefix') format('embedded-opentype'), url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWebBold.woff') format('woff'), url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWebBold.ttf') format('truetype')
}

@font-face {
	font-family: 'NanumBarunGothic';
	font-style: normal;
	font-weight: 300;
	src: url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWebLight.eot');
	src: url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWebLight.eot?#iefix') format('embedded-opentype'), url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWebLight.woff') format('woff'), url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWebLight.ttf') format('truetype');
}

.nanumbarungothic * {
	font-family: 'NanumBarunGothic', sans-serif;
}

html, body, timer {
	width: inherit;
	height: inherit;
	margin: 0px;
	overflow-x: hidden;
	overflow-y: auto;
	font-family: NanumBarunGothic;
	font-weight: 300;
}
</style>

<!-- Custom styles for this template-->
<link href="./css/theme/sb-admin-2.css" rel="stylesheet">
<title>Insert title here</title>

채팅 리스트 페이지 : ${ldto.user_nickname }
<%
	//    	response.setHeader("P3P", "CP='CAO PSA CONi OTR OUR DEM ONL'"); // iframe 세션이 날아가지 않도록 잡아줌
	String session_name = ""; //session_name은 세션의 이름으로 저장할 변수
	String session_value = ""; //session_value는 세션의 내용으로 저장할 변수

	Enumeration enum_01 = session.getAttributeNames(); //세션에 모든 이름들을 Enumeration에 하나씩 저장한다.

	while (enum_01.hasMoreElements()) {
		//hasMoreElements 0부터 시작 값이 있으면 true의 의미
		session_name = enum_01.nextElement().toString();//해당 Enumeration 에서 세션이름을 꺼내고
		session_value = session.getAttribute(session_name).toString();//해당이름을 가지고 세션 밸류를 꺼낸다.
		System.out.println("SESSION NAME[ " + session_name + " ] SESSION VALUE [ " + session_value + " ]");
	}
%>
<div id="test">
   <span id="timer"></span>
   <a href="javascript:refreshTimer();"></a>

   <c:choose>
      <c:when test="${ldto ne null}">
         <div id="userlist">
            <c:forEach items="${users}" var="user">
               <c:if test="${ldto.user_nickname ne user}">
                  <!-- 내가 아닌 상대방만 접속한 사용자정보에 출력됨 -->
                  <a href="#">${user}</a>
               </c:if>
            </c:forEach>
            <input id="refresh" type="button" value="새로고침"></input>
         </div>
      </c:when>
      <c:otherwise>
         <a class="collapse-item" href="#">로그인 후 채팅이 가능합니다.</a>
      </c:otherwise>
   </c:choose>
</div>
<script type="text/javascript" charset="utf-8" src="./js/chat/timeoutchk.js"></script>
<script type="text/javascript">
    var refresh = document.getElementById("refresh");
    refresh.onclick = function() {
	alert("● chatList.jsp / 접속자 정보를 새로고침 합니다.");
	window.location.reload();
    };

    function click() { // 내부함수로 사용되며, this.innerHTML은 채팅을 하고 싶은 상대방의 닉네임을 가져옴
	alert("● chatList.jsp / 상대 : " + this.innerHTML);
	alert("● chatList.jsp / 나 : ${ldto.user_nickname}");
	window.open("./socketOpen.do?sender=${ldto.user_nickname}&receiver="
		+ this.innerHTML, '_blank', 'width=600px,height=600px');
    }

    var as = document.getElementById("userlist");
    var a = as.getElementsByTagName("a");

    [].forEach.call(a, function(e) {
	e.addEventListener("click", click); // 접속한 회원마다 이벤트를 붙여줌
    });
</script>
