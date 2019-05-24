function sketchBookMake(user) {
		var user_email = user;
		//	alert();
		ajaxSketchMake(user_email);
	}

	var ajaxSketchMake = function(user_email) {
		//alert(user_email);

		$.ajax({
					url : "sketchMakeForm.do",
					type : "get",
					data : {"user_email" : user_email},
					dataType : "json",
					success : function(map) {

						if (map.user_iswrite == "F" || map.user_iswrite == null)
							alert("작성권한이 없습니다.");
						else {
							alert(map.user_iswrite);
							alert(map.user_email);
							$("#sketchForm").modal();
							var htmlModal = "<input type='hidden' name='user_email' value='"+map.user_email+"'>"
									+

									"<div class='form-group'>"
									+ "<label>스케치북 제목</label>"
									+ "<div class='modal-input'>"
									+ "<input type='text' class='form-control' id='sketchtitle' name='sketch_title' style='width : 400px;' required='required'></div>"
									+ "</div>"
									+

									"<div class='form-group'>"
									+ "<label>스케치북 테마</label>"
									+ "<div class='themeradio'>"
									+ "<input type='radio' id='familytheme' name='sketch_theme' value='가족여행'><label for='familytheme'>가족여행</label>"
									+ "<input type='radio' id='solotheme' name='sketch_theme' value='나홀로여행'><label for='solotheme'>나홀로여행</label>"
									+ "<input type='radio' id='coupletheme' name='sketch_theme' value='연인과 함께'><label for='coupletheme'>연인과 함께</label>"
									+ "<input type='radio' id='friendtheme' name='sketch_theme' value='친구와 함께'><label for='friendtheme'>친구와 함께</label>"
									+ "</div>"
									+ "</div>"
									+
									
									"<div class='form-group'>"
									+ "<label>스케치북 공유여부</label>"
									+ "<div class='themeradio'>"
									+ "<input type='radio' id='sketchShareY' name='sketch_share' value='Y'><label for='sketchShareY'>Y</label>"
									+ "<input type='radio' id='sketchShareN' name='sketch_share' value='N'><label for='sketchShareN'>N</label>"
									+"</div>"
									+ "</div>"
									+

									"<div class='form-group'>"
									+ "<label>스케치북 커버이미지</label>"
									+ "<input type='text' class='form-control' id='cover' name='sketch_spath' style='width : 400px;'>"
									+ "</div>"
									+

									"<div class='modal-footer'>"
									+ "<input class='btn btn-success' type='button' value='작성완료 ' onclick='sketchInsert()'>"
									+ "<button type='button' class='btn btn-default' data-dismiss='modal'>닫기</button>"
									+ "</div>";

							$("#makeSketchBook").html(htmlModal);
						}
					},
					error : function() {
						alert("실패");
					}
				});
	}

	function sketchInsert() {
		var sketch = document.getElementById("makeSketchBook");
		var sketch_theme = $("input[name=sketch_theme]:checked").val();
		var sketch_share = $("input[name=sketch_share]:checked").val();
		sketch.action = "./writeSketch.do";
		var title = $("#sketchtitle").val();
		var theme = $("input[name=sketch_theme]:checked").length;
		var share = $("input[name=sketch_share]:checked").length;

		if (title == "") {
			alert("스케치북 제목을 확인해주세요");
		} else if(theme == 0 || share == 0 ){
			alert("스케치북 타입 혹은 공유 여부를 선택해주세요");	
		} else if (title.length >= 20) {
			alert("스케치북의 제목이 너무 깁니다.");
			$("#sketchtitle").val("");
		} else {
			sketch.submit();
			alert("스케치북 작성완료");
		}
	}