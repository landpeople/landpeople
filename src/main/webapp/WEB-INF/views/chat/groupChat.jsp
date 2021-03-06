<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="shortcut icon" href="./img/favicon.ico" type="image/x-icon">
<link rel="icon" href="./css/theme/sb-admin-2.css" type="image/x-icon">

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="LandPeople">
<title>제주도 여행 일정 공유 커뮤니티 | 육지사람</title>

<%
	String chr_id = (String) session.getAttribute("chr_id");
	String user = (String) session.getAttribute("user");
%>

</head>

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="./css/sweetalert.css">

<link rel="stylesheet" href="./css/chat/chatroom.css">
<link href="./css/theme/sb-admin-2.css" rel="stylesheet">
<link href="./css/theme/lp-template.css" rel="stylesheet">

<body>
	<div id="cover">
		<div id="cover-inner">
			<div class="inner-wrapper shadow-lg">

				<div class="message-box">
					<div class="message_area scroll">
						<input type="text" id="nickName" value=<%=user%> />
					</div>
					<div class="memListBox">
						<div class="listTitle">접속자 목록</div>
						<div class="memList"></div>
					</div>
				</div>

				<div class="type_msg">
					<div class="input_msg_write">
						<div class="btn-box">
							<form id="fileForm" class="file_btn">
								<i class="far fa-file-image" onclick="$('#file').click();"></i> <input id="file" type="file" name="file" accept="image/*" style="display: none;">
							</form>
						</div>
						<textarea class="write_msg txtarea chat scroll" placeholder="Type a message" wrap="hard"></textarea>
						<div class="btn-box">
							<button class="msg_send_btn chat_btn" type="button">
								<i class="fa fa-paper-plane" aria-hidden="true"></i>
							</button>
						</div>
					</div>
				</div>

				<input type="hidden" id="ip" value="<%=request.getRemoteAddr()%>"> <input type="hidden" id="messagelist" value="${messageList}"> <input type="hidden" id="chr_id" value="<%=(String) session.getAttribute("chr_id")%>">
			</div>
		</div>
	</div>
</body>
<script src="./js/theme/jquery.min.js"></script>
<script src="./js/chat/chatroom.js"></script>
</html>