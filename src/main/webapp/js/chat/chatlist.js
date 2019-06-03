/**
 * 채팅방 리스트 파일의 js
 */
var refresh = document.getElementById("refresh");

if (refresh != null) {
	refresh.onclick = function() {
		alert("● chatList.jsp / 접속자 정보를 새로고침 합니다.");
		window.location.reload();
	};

	function click() { // 내부함수로 사용되며, this.innerHTML은 채팅을 하고 싶은 상대방의 닉네임을
		// 가져옴
		var sender = $("#" + this.innerHTML + "input").val();
		alert("● chatList.jsp / 상대 : " + this.innerHTML);
		alert("● chatList.jsp / 나 : " + sender);
		window.open("./socketOpen.do?sender=" + sender + "&receiver="
				+ this.innerHTML, '_blank', 'width=600px,height=600px');
	}

	var as = document.getElementById("userlist");
	var a = as.getElementsByTagName("a");

	[].forEach.call(a, function(e) {
		e.addEventListener("click", click); // 접속한 회원마다 이벤트를 붙여줌
	});
}
