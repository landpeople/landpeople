<!DOCTYPE html>
 
<html>
<head>
    <meta charset="utf-8" />
    <title></title>
</head>
<body>
<!-- HTML 문서에 버튼을 하나 생성하고, 버튼을 클릭하면 calculate() 함수가 호출된다. -->
    <button onclick="calculate()">calculate</button>
 
 <!-- HTML 문서가 생성될 때, notification 기능에 대한 허용 여부를 확인한다. -->
    <script type="text/javascript">
        window.onload = function () {
            if (window.Notification) {
                Notification.requestPermission();
            }
        }

//notify() 함수를 호출하여 브라우저에 알림을 출력한다. [코드 1]에서는 의도적으로 1초 후에 알림을 출력하도록 했다.
        function calculate() {
            setTimeout(function () {
                notify();
            }, 100);
        }
 
        function notify() {
            if (Notification.permission !== 'granted') { // 알림 거부 버튼을 눌렀을 시
                alert('notification is disabled'); 
            }
            else { // 알림 허용 버튼을 눌렀을 시
                var notification = new Notification('Notification title', {
                    icon: 'http://cdn.sstatic.net/stackexchange/img/logos/so/so-icon.png',
                    body: 'Notification text',
                });
 
                notification.onclick = function () {
                    window.open('http://google.com');
                };
            }
        }
    </script>
</body>
</html>
