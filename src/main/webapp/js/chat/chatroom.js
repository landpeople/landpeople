var ws = null ;
var url = null ;
var nick = null ; 
var content = [];

var img = $(".img");

$('textarea').on('keydown', function(event) {
    if (event.keyCode == 13)
        if (!event.shiftKey) // shift key와 enter 함께 누르면 줄 바꿈이 되도록함
        	$('.chat_btn').click();
});


$(document).ready(function() {

    var ip = $("#ip").val();
    var messagelist = $("#messagelist").val();
    var chr_id = $("#chr_id").val();
    var nick = $("#nickName").val();
    var messageArea = $(".message_area");

    messageArea.html('');
    messageArea.scrollTop = messageArea.scrollHeight;
    
    $(".chat_div").show();
    $(".chat").focus(); /* 텍스트 박스에 focus를 주어 입력할 수 있는 상태로 만들어 줌 */
    
    /* 웹소켓 생성*/
    ws = new WebSocket("ws://"+ ip +":8091/LandPeople/wsChat.do");
 
    /* 소켓이 열렸을 때 사용자가 입장하면 입장 메시지를 화면에 띄워 줄 수있도록 이벤트를 발생하여 핸들러를 호출 */
    ws.onopen = function() {
//	alert("● groupChat.jsp ws.onopen / 소켓이 열렸습니다.");
	ws.send("#$nick_" + nick);
	$(".message_area").append(messagelist);
    };
 
    ws.onmessage = function(event){
	alert("● groupChat.jsp handler에서 처리 후 도착한 데이터 : " + event.data);
        
            alert("크롬이레");
 	   $("#file").val("");
	
  	var msg = event.data; // 이벤트 핸들러에서 처리해서 돌아온 data
 
  	$(".message_area").append(msg);
        viewList(chr_id); // 접속자 목록을 보여줌
        $(".message_area").scrollTop($(".message_area")[0].scrollHeight);

    }

    /* 소켓이 닫혔을 때 퇴장 메시지를 화면에 띄워 줄 수있도록 이벤트를 발생하여 핸들러를 호출 */
    ws.onclose = function(event) {
	alert("● groupChat.jsp ws.close / 웹소켓 닫힘");
	ws.send("#$nick_" + nick);
    }
    
    /* 전송 버튼 눌렀을 때 이벤트 */
    $(".chat_btn").bind("click", function() {
    	var file = document.getElementById('file').files[0];
    
    	/* 파일을 전송할 때 이벤트 */
    	alert("파일이 존재하는가 ? " + file);
    	if (file != undefined) {
            alert("파일 전송 : " + file);
            var frmEle = document.forms[0];
            var formData = new FormData(frmEle);
            formData.append("file", $(".file"));
            $.ajax({
               url : './uploadChatImageFile.do',
               type : 'post',
               data : formData,
               enctype : 'multipart/form-data',
               processData : false,
               contentType : false,
               success : function(result) {
            	   ws.send("file : " + nick + " > " + result);
               },
               error : function(result) {alert("파일 전송 실패");}
            });
        } else {
            var canWrite;
            $.ajax({
                 type : "POST",
                 url : "./chkChatMember.do",
                 data : {chr_id : chr_id},
                 dataType : "json",
                 async : false,
                 success : function(result) {canWrite = result.result;},
                 error : function() {alert("chkChatMember.do 실패");}
            });
        
           if ($(".chat").val().trim() == ''
           	|| $(".chat").val() == '\n') { /*공백이나 개행문자만 입력 했을 시 전송 안되도록 함*/
               alert("● groupChat.jsp / 내용을 입력하세요. ");
               return;
           } else if (canWrite == 'cantChat') {
               alert("● 대화 상대가 없습니다. *채팅 불가*");
               return;
           } else {
               ws.send(nick + " : "+ $(".chat").val());
        	    // content.push(nick+" : "+$(".chat").val()); // 보내는 메시지 content에 저장
        	    // $.ajax({
        	    //   type: "POST",
        	    //   url : "./insertMessage.do",
        	    //   data: {"chc_content" : "<div class = 'sendTxt'><span class ='sender_msg'>['${user}']"+$(".chat").val()+"</span></div><br><br>"}
        	    //   success : function(){
        	    //       alert("성고옹");
        	    //   }
        	    // });
               $(".chat").val('');
               $(".chat").empty();
               $(".chat").focus();
           }
        }
    }); /* 전송 버튼 눌렀을 때 이벤트 */
}); /* End of $(document).ready */

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
        // 		data : { //  (*제거)핸들러에서 데이터를 바로 디비에 저장할 수 있도록 함, 나중에 통째로 저장하고 싶을 때 사용
        // 		    "chc_content" : content.toString()
        // 		},
        });
    }
}

function disconnect() {
	ws.close();
	ws = null;
}

function viewList(grId) { /* 접속자 목록 보여주기 위한 함수*/
    $(".memList").children().remove();
    $.ajax({
       type : "POST",
       url : "./viewChatList.do",
       data : "user=" + $("#nickName"),
       success : function(result) {
	   for (var k in result.list) {
	       if (result.list[k] == grId) {
    			$(".memList").prepend("<img class = 'mem_icon' src = 'img/smile.png' alt = '접속자 아이콘'><p style = 'font-size : 13px;padding : 5px;border-bottom: 0.5px solid #B4B4B4;'>"
    						+ k + "</p>");
	       }
	   }
       }
    });
}	

$(".file_btn").click(function() {
});


document.getElementById("file").onchange = function() {
    if (this.value != "") {
        var extPlan = "JPG, PNG";
        var checkSize = 1024 * 1024 * 5; // 5MB
        if (!checkImg($('#file'), extPlan)
    	    | !checkImgSize($('#file'), checkSize)) {
    	this.value = "";
    	return;
        }
    }
    $(".chat").focus(); // 파일 전송 후 커서를 입력창으로 
};

// 첨부파일 확장자 확인
function checkImg(obj, ext) {
	var check = false;
	var extName = $(obj).val().substring($(obj).val().lastIndexOf(".") + 1)
		.toUpperCase();
	var str = ext.split(",");

	for (var i = 0; i < str.length; i++) {
	    if (extName == $.trim(str[i])) {
		check = true;
		break;
	    } else
		check = false;
	}
	if (!check) {
	    alert(ext + " 파일만 업로드 가능합니다.");
	}
	return check;
}

// 첨부파일 용량 확인
function checkImgSize(obj, size) {
    var check = false;
    if (window.ActiveXObject) {
        //IE용인데 IE8이하는 안됨...
        var fso = new ActiveXObject("Scripting.FileSystemObject");
        //var filepath = document.getElementById(obj).value;
    
        var filepath = obj[0].value;
        var thefile = fso.getFile(filepath);
        sizeinbytes = thefile.size;
    } else {//IE 외
        //sizeinbytes = document.getElementById(obj).files[0].size;
        sizeinbytes = obj[0].files[0].size;
    }
    var fSExt = new Array('Bytes', 'KB', 'MB', 'GB');
    var i = 0;
    var checkSize = size;
    while (checkSize > 900) {
        checkSize /= 1024;
        i++;
    }
    checkSize = (Math.round(checkSize * 100) / 100) + ' ' + fSExt[i];
    var fSize = sizeinbytes;
    if (fSize > size) {
        alert("첨부파일은 " + checkSize + " 이하로 등록가능합니다.");
        check = false;
    } else {
        check = true;
    }
    return check;
}