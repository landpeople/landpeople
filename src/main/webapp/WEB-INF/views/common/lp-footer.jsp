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

<!-- Bootstrap core JavaScript-->
<script src="./js/theme/jquery.min.js"></script>
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

    // 	alert(window.location.pathname );
    if (pathname == '/LandPeople/lee.do') {
	var title = 'All themes';
	$('#lp-header-title').text(title);
    }
</script>