/**
 * 채팅방 리스트 파일의 js
 */
var refresh = document.getElementById("refresh");

if (refresh != null) {
	refresh.onclick = function() {
		alert("● chatList.jsp / 접속자 정보를 새로고침 합니다.");
		window.location.reload();
	};

	function click() { // 내부함수로 사용되며, this.innerHTML은 채팅을 하고 싶은 상대방의 닉네임을 가져옴
	    
	    var w = 600; // 윈도우 창을 다양한 위치에서 열기 위해 random 위치를 생성해주도록 함
	    var h = 700;
	    
	    w += 32;
	    h += 96;
	    
	    wleft = (screen.width - w) / 2;
	    wtop = (screen.height - h) / 2;

	    if (wleft < 0) {
	      w = screen.width;
	      wleft = 0;
	    }
	    if (wtop < 0) {
	      h = screen.height;
	      wtop = 0;
	    }
	    if (wleft > 0) {
	      wleft = Math.floor(Math.random() * wleft); // for example
	    }
	    
	    var sender = $("#" + this.innerHTML + "input").val();
	    alert("● chatList.jsp / 상대 : " + this.innerHTML);
	    alert("● chatList.jsp / 나 : " + sender);
	    var win = window.open("./socketOpen.do?sender=" + sender + "&receiver="
				+ this.innerHTML, '_blank', 'width=600px,height=700px, scrollbars=no, resizable=no, toolbars=no, menubar=no, left=' + wleft + ',top=' + wtop);
	    win.focus();
	}

	var as = document.getElementById("userlist");
	var a = as.getElementsByTagName("a");

	[].forEach.call(a, function(e) {
		e.addEventListener("click", click); // 접속한 회원마다 이벤트를 붙여줌
	});
}
