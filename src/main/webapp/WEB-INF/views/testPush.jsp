<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script src="./js/jquery-3.3.1.js"></script>
</head>


<!-- The core Firebase JS SDK is always required and must be listed first -->
<!-- Firebase App is always required and must be first -->
<script src="https://www.gstatic.com/firebasejs/5.9.1/firebase-app.js"></script>

<!-- Add additional services that you want to use -->
<script src="https://www.gstatic.com/firebasejs/5.9.1/firebase-auth.js"></script>
<script
	src="https://www.gstatic.com/firebasejs/5.9.1/firebase-database.js"></script>
<script
	src="https://www.gstatic.com/firebasejs/5.9.1/firebase-firestore.js"></script>
<script
	src="https://www.gstatic.com/firebasejs/5.9.1/firebase-messaging.js"></script>
<script
	src="https://www.gstatic.com/firebasejs/5.9.1/firebase-functions.js"></script>

<!-- Comment out (or don't include) services that you don't want to use -->
<!-- <script src="https://www.gstatic.com/firebasejs/5.9.1/firebase-storage.js"></script> -->

<!-- TODO: Add SDKs for Firebase products that you want to use
     https://firebase.google.com/docs/web/setup#config-web-app -->

<script>
window.onload = function() {
	if (window.Notification) {
		Notification.requestPermission();
	}
}

	// Your web app's Firebase configuration
	var firebaseConfig = {
		apiKey : "AIzaSyBbfnazJbymHv9WPuef6XMVF28L9n6PM_M",
		authDomain : "landpeople2.firebaseapp.com",
		databaseURL : "https://landpeople2.firebaseio.com",
		projectId : "landpeople2",
		storageBucket : "landpeople2.appspot.com",
		messagingSenderId : "116333295073",
		appId : "1:116333295073:web:9428a88be11bfa34"
	};
	// Initialize Firebase
	firebase.initializeApp(firebaseConfig);

	var database = firebase.database();
	var messagesRef = database.ref('/');
	//   messagesRef.set(2);

	// submit을 눌렀을 시 실행되는 function
	function submitForm(form) {
		// 	alert(form.message.value);
		var message = {};
		message = {
			sender : form.nick.value,
			content : form.message.value
		};

		messagesRef.push(message);
	}

	// messagesRef 를 보고 있다가 자식이 추가(push) 되면 이 function이 실행 됨
	messagesRef.on('child_added', function(snapshots) {
		// 	alert("hi");
		var message = snapshots.val();
		var html = '<div>' + message.sender + ':' + message.content + '</div>';
		$('#chat-app').append(html);

		setTimeout(function() {
			notify(message);
		}, 500);

	});

	// 알림
	function notify(message) {
		if (Notification.permission !== 'granted') { // 알림 거부 버튼을 눌렀을 시
			alert('notification is disabled');
		} else { // 알림 허용 버튼을 눌렀을 시
			var notification = new Notification(
					message.sender + "`s message!",
					{
						icon : 'http://cdn.sstatic.net/stackexchange/img/logos/so/so-icon.png',
						body : "Click Me~",
					});

			notification.onclick = function() {
				window.open('http://google.com');
			};
		}
	}

</script>
<body>
	<form onsubmit="submitForm(this); return false;">
		<input type="text" name="nick"> <input type="text"
			name="message"> <input type="submit" value="submit">

		<div id="chat-app"></div>
	</form>
</body>
</html>
