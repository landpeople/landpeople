<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
html,body {
 width: 236px; height: 131px; margin: 0px;
}
</style>
<title>Insert title here</title>
</head>
<script type="text/javascript">
    window.onload = function() {
	var refresh = document.getElementById("refresh");
	alert(refresh);
	refresh.onclick = function() {
	    alert("● 새롭게 접속자 정보를 가져옵니다.");
	    window.location.reload();
	};
    }
</script>
<body>

   <div style="width:100%; height:45px; background-color:black; color:white;" >접속한 사용자 정보</div>
   <div style="width: 100%; height: 100%; overflow: auto;">
      ${nicknames }

      <input id="refresh" type="button" value="새로고침"></input>
   </div>
</body>
</html>