<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>그룹채팅</title>

<!-- Firebase App is always required and must be first -->
<script src="https://www.gstatic.com/firebasejs/5.9.1/firebase-app.js"></script>

<!-- Add additional services that you want to use -->
<script src="https://www.gstatic.com/firebasejs/5.9.1/firebase-auth.js"></script>
<script src="https://www.gstatic.com/firebasejs/5.9.1/firebase-database.js"></script>
<script src="https://www.gstatic.com/firebasejs/5.9.1/firebase-firestore.js"></script>
<script src="https://www.gstatic.com/firebasejs/5.9.1/firebase-messaging.js"></script>
<script src="https://www.gstatic.com/firebasejs/5.9.1/firebase-functions.js"></script>
<!-- Comment out (or don't include) services that you don't want to use -->
<!-- <script src="https://www.gstatic.com/firebasejs/5.9.1/firebase.js"></script> -->
<script>
  // Initialize Firebase
  // TODO: Replace with your project's customized code snippet
  var config = {
	  apiKey: "AIzaSyBMapdnIIEh-OEgBPZPtMc9ndKPD8gTeTw",
      authDomain: "landpeople-444c5.firebaseapp.com",
      databaseURL: "https://landpeople-444c5.firebaseio.com",
      projectId: "landpeople-444c5",
      storageBucket: "landpeople-444c5.appspot.com",
      messagingSenderId: "593127478674",
      appId: "1:593127478674:web:ec271f0a5609507f"
  };
  firebase.initializeApp(config);
</script>

<style type="text/css">
@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
/*    @font-face{
      font-family: "the120";
      src: url('font/The120.ttf');
   } */
body {
	padding: 0px;
	font-family: 'Jeju Gothic', sans-serif;
}

table {
	border: 1px solid #B4B4B4;
	border-collapse: collapse;
}

.sender_img { /* 본인 메시지 css */
	border: 1px solid;
	background-color: #69B55B;
	background-clip: padding-box;
	-webkit-border-image: url(images/sender_bubble.png) 25 25 round;
	-o-border-image: url(images/sender_bubble.png) 25 25 round;
	border-image: url(images/sender_bubble.png) 25 25 round;
	padding-top: 3px;
	padding-bottom: 3px;
	padding-left: 3px;
	padding-right: 11px;
	float: right;
	font-size: 12px;
	text-align: justify;
}

.receiver_img { /* 상대방 메시지 css */
	border: 1px solid;
	background-color: #E6F4B5;
	background-clip: padding-box;
	-webkit-border-image: url(images/receiver_bubble.png) 25 25 round;
	-o-border-image: url(images/receiver_bubble.png) 25 25 round;
	border-image: url(images/receiver_bubble.png) 25 25 round;
	padding-top: 3px;
	padding-bottom: 3px;
	padding-right: 3px;
	padding-left: 11px;
	float: left;
	font-size: 12px;
	text-align: justify;
}

.receive_msg {
	padding: 3px;
	width: 350px;
	height: 400px;
	overflow: auto;
	overflow-x: hidden;
	background: #F3F3F3;
}

.chat {
	width: 340px;
	height: 20px;
	padding: 5px;
	float: left;
	margin-top: 4px;
	margin-left: 2px;
	resize: none;
	border: 0.5px solid #F3F3F3;
}

.chat:focus {
	outline: none;
}

/*    .chat_btn{ */
/*       margin-top: 0px; */
/*       margin-left: 5px; */
/*       width: 52px; */
/*       height: 31px; */
/*       background-image: url('images/btn_send.png'); */
/*       background-size: 100% 100%; */
/*       display: inline-block; */
/*    } */
.memListBox {
	text-align: center;
	vertical-align: text-top;
	padding: 10px;
	overflow: auto;
	/* background: #D8D8D8; */
}

.listTitle {
	height: 50px;
	vertical-align: top;
	font-size: 12px;
	font-weight: bold;
}

.mem_icon {
	padding: 0px;
	display: inline-block;
	float: left;
}

.memList {
	vertical-align: top;
}

.noticeTxt {
	clear: both;
	margin: 10px;
}

.noticeTxt font {
	padding-top: 5px;
	padding-bottom: 5px;
	padding-left: 20px;
	padding-right: 20px;
	background: white;
	border-radius: 3px;
}

.sendTxt {
	width: 172px;
	float: right;
	margin: 2px;
	word-break: break-word;
}

.receiveTxt {
	width: 172px;
	float: left;
	margin: 2px;
	word-break: break-word;
}
</style>

	<% 
    String chr_id = (String)session.getAttribute("chr_id"); 
    String user = (String) session.getAttribute("user");
    %>

<script type="text/javascript" src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script type="text/javascript">
      var ws = null ;
      var url = null ;
      var nick = null ; 
      var content = [];
      
      $(document).ready(function() {
	  
          nick = $("#nickName").val();
          alert("● groupChat.jsp var nick : " + nick);
          $(".receive_msg").html('');
          $(".chat_div").show();
          $(".chat").focus(); /* 텍스트 박스에 focus를 주어 입력할 수 있는 상태로 만들어 줌 */
          
          ws = new WebSocket("ws://192.168.177.1:8091/LandPeople/wsChat.do");
          
          ws.onopen = function() {
          	alert("● groupChat.jsp ws.onopen");
            alert("${messageList}");
            ws.send("#$nick_"+nick); // 소켓이 열렸을 때 사용자가 입장하면 입장 메시지를 화면에 띄워 줄 수있도록 이벤트를 발생하여 핸들러를 호출
            $(".receive_msg").append("${messageList}");
          };
          
          ws.onmessage = function(event){
           	var msg = event.data; // 이벤트 핸들러에서 처리해서 다시 되돌아온 data
            var chr_id = "<%=chr_id%>";
            
            if(msg.startsWith("<font color=")){ // 입장, 퇴장 시 이 메시지로 되돌아오게됨
               $(".receive_msg").append($("<div class = 'noticeTxt'>").append(msg+"<br/>"));
           	   viewList(chr_id);
            }else{
        		if(msg.startsWith("[${user}]")){ // 대화 내용
                 	 $(".receive_msg").append($("<div class = 'sendTxt'>").append($("<span class ='sender_img'>").text(msg))).append("<br><br>");
                         content.push("<div class = 'sendTxt'><span class ='sender_img'>"+msg + "</span></div><br><br>"); // 받은 메시지 content에 저장
        		}else{
               		 $(".receive_msg").append($("<div class = 'receiveTxt'>").append($("<span class = 'receiver_img'>").text(msg))).append("<br><br>");
                         content.push("<div class = 'receiveTxt'><span class = 'receiver_img'>" + msg + "</span></div><br><br>"); // 받은 메시지 content에 저장
        		}
             		$(".receive_msg").scrollTop($(".receive_msg")[0].scrollHeight);              
          		}
          }
         
          ws.onclose = function(event) {
             alert("● groupChat.jsp ws.close / 웹소켓 닫힘");
             ws.send("#$nick_"+nick);
          }
      
         $(".chat_btn").bind("click",function() { /* 전송 버튼 눌렀을 때 이벤트 */
          var canWrite;
          $.ajax({
                 type: "POST",
                 url: "./chkChatMember.do",
                 data: { chr_id: "${chr_id}"},
				 dataType : "json",
				 async : false,
				 success : function(result) {
				    canWrite = result.result;
				},
				error : function() {
				    alert("실패");
				}
			    });
          
			    if ($(".chat").val().trim() == ''
				    || $(".chat").val() == '\n') { /*공백이나 개행문자만 입력 했을 시 전송 안되도록 함*/
				alert("● groupChat.jsp / 내용을 입력하세요. ");
				return;
			    }
			    else if (canWrite == 'cantChat') {
				alert("● 대화 상대가 없습니다. *채팅 불가*");
				return;
				}
			    else {
				ws.send(nick + " : " + $(".chat").val());
				// content.push(nick+" : "+$(".chat").val()); // 보내는 메시지 content에 저장
				
// 				$.ajax({
// 				  type: "POST",
// 				  url : "./insertMessage.do",
// 				  data: {"chc_content" : "<div class = 'sendTxt'><span class ='sender_img'>['${user}']"+$(".chat").val()+"</span></div><br><br>"}
// 				  success : function(){
// 				      alert("성고옹");
// 				  }
// 				});
				
				$(".chat").val('');
				$(".chat").empty();
				$(".chat").focus();
			    }
			}); /* 전송 버튼 눌렀을 때 이벤트 */

// 		$(window).bind("beforeunload", function() {
// 		    //실행할 함수를 리턴해야한다.
// 		    return fn_removeLocalStorage("openchatwait");
// 		});
	    });

    function fn_removeLocalStorage(x) {
		alert(x);
    }

    var isCheck = true; /* 나중에 저장하기 버튼이나, 그런거,, 비밀채팅 하고싶을 때 써먹을려고 혹~시나 만들어둠 */

    window.addEventListener("unload", function(e) { /* 새로고침이나 닫기 버튼 클릭시의 이벤트 */
	var confirmationMessage = "\o/";

	(e || window.event).returnValue = confirmationMessage; /*ie*/
	return roomClose(e); //Webkit, Safari, Chrome
    });

    window.addEventListener("beforeunload", function(e) { /* 새로고침이나 닫기 버튼 클릭시의 이벤트 */
	var confirmationMessage = "\o/";

	(e || window.event).returnValue = confirmationMessage; /*ie*/
	return; //Webkit, Safari, Chrome
    });

    function roomClose(e) {

	/* 새로운 변경사항이 있다면 ?*/
	if (isCheck) {
	    $.ajax({
		type : "POST",
		url : "./socketOut.do",
		data : {
		    "chc_content" : content.toString()
		},
	    });
	}
    }

    function disconnect() {
	ws.close();
	ws = null;
    }

    function viewList(grId) { /* 접속자 목록 보여주기 위한 함수*/
	$(".memList").children().remove();
	$
		.ajax({
		    type : "POST",
		    url : "./viewChatList.do",
		    data : "user=" + $("#nickName"),
		    async : false, /* 동기식으로 전달 */
		    success : function(result) {
			for ( var k in result.list) {
			    if (result.list[k] == grId) {
				$(".memList")
					.prepend(
						"<img class = 'mem_icon' src = 'img/smile.png' alt = '접속자 아이콘'><p style = 'font-size : 13px;padding : 5px;border-bottom: 0.5px solid #B4B4B4;'>"
							+ k + "</p>");
			    }
			}
		    }
		});
    }
</script>
</head>
<body>
   <table id="contentsss">
      <tr>
         <td width="360x" height="390px" align="center">
            <div class="receive_msg" style="border: 1px">
               <input type="text" id="nickName" value=<%=user%> />
            </div>
         </td>
         <td width="130px" class="memListBox">
            <div class="listTitle">접속자 목록</div>
            <div class="memList"></div>
         </td>
      </tr>
   </table>

   <div class="chat_div" style="display: none; margin-top: 10px;">
      <input type="text" id="txtarea" class="chat" onKeypress="if(event.keyCode==13) $('.chat_btn').click();" />
      <input type="button" class="chat_btn" value="전송" />
      <input type="button" class="exit_btn" value="나가기" />
      <br>
   </div>
   그룹아이디 :
   <%=chr_id%>
   나의아이디 :
   <%=user%>
</body>
</html>