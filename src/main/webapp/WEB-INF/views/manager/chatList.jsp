<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
<link rel="shortcut icon" href="./img/favicon.ico" type="image/x-icon">
<link rel="icon" href="./css/theme/sb-admin-2.css" type="image/x-icon">

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="LandPeople">

<title>제주도 여행 일정 공유 커뮤니티 | 육지사람</title>

<!-- Custom fonts for this template-->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

<link rel="stylesheet" type="text/css" href="./css/sweetalert.css">

<!-- Custom styles for this template-->
<link href="./css/theme/sb-admin-2.css" rel="stylesheet">
<link href="./css/theme/lp-template.css" rel="stylesheet">
<link href="./css/sketch/modal.css" rel="stylesheet">

</head>

<script src="./js/jquery-3.3.1.js"></script>
<script type="text/javascript">
   function allSel(bool) {
      var chks = document.getElementsByName("chk");
      for (var i = 0; i < chks.length; i++) {
         chks[i].checked = bool;
      }
   }
   
   function mutidel(){
         var chksVal = [];
         $('input:checkbox[name="chk"]:checked').each(function () {
            chksVal.push($(this).val());
         });
            location.href="./deleteChatroom.do?chksVal="+chksVal;
      }
</script>

<body id="page-top" class="scroll">

   <!-- Page Wrapper -->
   <div id="wrapper">
      <%@include file="../common/lp-sidebar.jsp"%>

      <!-- Content Wrapper -->
      <div id="content-wrapper" class="d-flex flex-column">
         <!-- flex 레이아웃 content와 푸터 정렬 -->

         <!-- Main Content -->
         <div id="content" style="display: flex; flex-direction: column;">

            <!-- LandPeople Content Area -->
            <div class="lp-container">
               <div class="lp-other-content shadow-lg">
               <table>
                  <button onclick="mutidel()" >채팅방 나가기</button>
                  <tr>
                     <th><input type="checkbox" onclick="allSel(this.checked)"></th><th>상대방</th><th>최근메시지</th><th>날짜</th>
                  </tr>
                  <c:forEach var="list" items="${resultLists}" varStatus="status" >
                     <tr>
                        <td><input type="checkbox" name="chk" value="${list.get(0).get('CHR_ID')}"></td>
                        <td>${list.get(0).get("CHR_RECEIVER")}</td>
                        <td>${list.get(0).get("CHC_MESSAGE")}</td>
                        <td>${list.get(0).get("CHC_REGDATE")}</td>
                     </tr>
                  </c:forEach>
               </table>
               
               
               </div>
            </div>
            <!--End of Page LandPeople Content Area -->
            <%@include file="../common/lp-footer.jsp"%>
            <!-- End of Page Wrapper -->
         </div>
      </div>
   </div>
</body>
</html>



