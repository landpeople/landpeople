<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<input type="text" id="bigOne">

	<!-- The core Firebase JS SDK is always required and must be listed first -->
	<script src="https://www.gstatic.com/firebasejs/6.0.2/firebase-app.js"></script>

	<!-- TODO: Add SDKs for Firebase products that you want to use
     https://firebase.google.com/docs/web/setup#config-web-app -->

	<script>
		// Your web app's Firebase configuration
		var firebaseConfig = {
			apiKey : "AIzaSyCC99KToXOPLclnOIJea4uI8A4yWbLcXBs",
			authDomain : "endless-bonus-216906.firebaseapp.com",
			databaseURL : "https://endless-bonus-216906.firebaseio.com",
			projectId : "endless-bonus-216906",
			storageBucket : "endless-bonus-216906.appspot.com",
			messagingSenderId : "684991588524",
			appId : "1:684991588524:web:b7c83df49da06dae"
		};
		// Initialize Firebase
		firebase.initializeApp(firebaseConfig);
		
		var bigOne = document.getElementById("bigOne");
		var dbRef = firebase.database().ref.child('text');
		dbRef.on('value', snap => bigOne.value = snap.val());
	</script>
</body>
</html>