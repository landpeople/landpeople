<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html id="html">
<head>
<meta charset="UTF-8">
<style>
#html,#body {
 width: 236px; height: 131px; margin: 0px;
}
</style>
<title>Insert title here</title>
</head>
<script type="text/javascript">
    window.onload = function() {
   var refresh = document.getElementById("refresh");
   refresh.onclick = function() {
       alert("● 새롭게 접속자 정보를 가져옵니다.");
       window.location.reload();
   };
}
</script>
<body id="body">

   <%
      session.setAttribute("mynickname", "접속자1"); // 내 닉네임과 같은 리스트는 화면에 뿌려지지 않도록 하기 위해서 임의로 정해둠
      String mynickname = (String) session.getAttribute("mynickname");
   %>
   
   <div style="width: 100%; height: 45px; background-color: black; color: white;">접속한 사용자 정보</div>
   <div style="width: 100%; height: 100%; overflow: auto;">
      <c:forEach items="${nicknames}" var="nickname">
         <c:if test="${mynickname ne nickname}">
            <a href="#">${nickname}</a>
         </c:if>
      </c:forEach>
      <input id="refresh" type="button" value="새로고침"></input>
   </div>


   <script type="text/javascript">
      function click() { // 내부함수로 사용되며, thisHTML은 
          alert("대화하고 싶은 상대방 : " + this.innerHTML);
          alert("나의 닉네임 : " + '<%=(String)session.getAttribute("mynickname")%>');
          window.open("./socketOpen.do?mem=" + this.innerHTML +"&user="+"<%=(String)session.getAttribute("mynickname")%>","새창이름",
        	  'resizable=yes,width=600px,height=600px');
      }

      var as = document.getElementsByTagName("a");
      alert("나를 제외하고 세션에 접속한 인원" + as.length);

      [].forEach.call(as, function(e) {
          e.addEventListener("click", click); // 선택한 
      })
       </script>
</body>
</html>