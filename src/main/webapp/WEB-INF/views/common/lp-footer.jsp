<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Footer -->
<footer class="sticky-footer bg-white">
   <div class="container my-auto">
      <div class="copyright text-center my-auto">
         <span>Copyright &copy; LandPeople 2019</span>
      </div>
   </div>
</footer>
<!-- End of Footer -->

<!-- Scroll to Top Button-->
<a class="scroll-to-top rounded" href="#page-top">
   <i class="fas fa-angle-up"></i>
</a>

<!-- Logout Modal-->
<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
   <div class="modal-dialog" role="document">
      <div class="modal-content">
         <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
            <button class="close" type="button" data-dismiss="modal" aria-label="Close">
               <span aria-hidden="true">×</span>
            </button>
         </div>
         <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
         <div class="modal-footer">
            <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
            <a class="btn btn-primary" href="./logout.do">Logout</a>
         </div>
      </div>
   </div>
</div>

<!-- 스케치북 생성 Modal -->
<div class="modal fade" id="sketchForm" role="dialog">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
            <h5 class="modal-title">스케치북 작성</h5>
            <button type="button" class="close" data-dismiss="modal">&times;</button>
         </div>
         <div class="modal-body">
            <form action="#" role="form" method="post" id="makeSketchBody"></form>
         </div>
         <div class="modal-footer">
            <form action="#" role="form" method="post" id="makeSketchFooter"></form>
         </div>
      </div>
   </div>
</div>
<!-- 여기까지 스케치북 생성 Modal -->

    <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog" style="z-index:4000000">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content" style="width:1000px; height:800px;">
        <div class="modal-header">          
          <h4 class="modal-title" style="text-align: center;">페이지 입력</h4>
        </div>
        <div class="modal-body" style="padding: 30px 30px 30px 30px;">
          <p><img src="./img/days.jpg" class="insertForms" title="1번스타일"></img>
             <img src="./img/free2.png" class="insertForms" title="2번스타일"></img>
             <img src="./img/free2.png" class="insertForms" title="3번스타일"></img><br>
             <img src="./img/free3.png" class="insertForms" title="4번스타일"></img>
             <img src="./img/free4.png" class="insertForms" title="5번스타일"></img>
             <img src="./img/free5.png" class="insertForms" title="6번스타일"></img>
          </p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal" id="closeModal">Close</button>
          <button type="button" class="btn btn-default" id="canvasInsertFrom">ok</button>
        </div>
      </div>
   </div>
 </div>


<!-- Bootstrap core JavaScript-->
<!-- <script src="./js/theme/jquery.min.js"></script> --><!-- 이거하면 다른데서 안 먹음 -->
<script src="./js/theme/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script src="./js/theme/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="./js/theme/sb-admin-2.js"></script>
<script src="./js/chat/chat.js"></script>
<script src="./js/sketch/sketch.js"></script>
<script src="./js/sketch/sketchbook.js"></script>

<script type="text/javascript">
    var pathname = window.location.pathname;

    //   alert(window.location.pathname );
    if (pathname == '/LandPeople/lee.do') {
   var title = 'All themes';
   $('#lp-header-title').text(title);
    }
</script>