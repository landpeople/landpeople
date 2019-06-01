// 스케치북 작성 모달
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
									+ "<input type='radio' id='solotheme' name='sketch_theme' value='나홀로'><label for='solotheme'>나홀로여행</label>"
									+ "<input type='radio' id='coupletheme' name='sketch_theme' value='연인과함께'><label for='coupletheme'>연인과함께</label>"
									+ "<input type='radio' id='friendtheme' name='sketch_theme' value='친구와함께'><label for='friendtheme'>친구와함께</label>"
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

									"<div class='form-group'>"+
									"<label>스케치북 커버이미지</label>"+
										"<div id='moSketchBookCover'>"+
												"<div id='modalIMG1' style='background-image :url(img/profile.jpg)'>"+
												"<input type='hidden' name='sketch_spath' class='img_spath0'>"+
														"<label for='C_IMG1'><img src='./img/folder.png'></label>"+
														"<input id='C_IMG1' class='file'  name='file' type='file' multiple='multiple' style='display: none;'>"+
	 													
												"</div>"+
	 											
										"</div>"+
									"</div>"+

									"<div class='modal-footer'>"
									+ "<input class='btn btn-success' type='button' value='작성완료 ' onclick='sketchInsert()'>"
									+ "<button type='button' class='btn btn-default' data-dismiss='modal'>닫기</button>"
									+ "</div>";

							$("#makeSketchBook").html(htmlModal);
							
														
							$("input[id=C_IMG1]").change(function(){
								var imgClass = $(this).attr("id");
								subImgClass = imgClass.substring(imgClass.indexOf('_')+1);
								if(extension($("input[id="+imgClass+"]").val())){
									fileUpload(subImgClass);
								}
							});
								
		
							
						}
					},
					error : function() {
						alert("실패");
					}
				});
	}

	//확장자 확인 (업로드할 수 있는 확장자일시 true)
	function extension(file){
		var reg = /gif|jpg|png|jpeg/i;
		if(reg.test(file)){
			return true;
		}else{
			alert("잘못된 확장자입니다.\n★jpg/png/gif★ 파일만 업로드 가능합니다.");
			return false;
		}
	}
	
	
	
	
	// 스케치북 작성 모달 value를 DB에 저장
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
	
	
	
	
	
	
	function fileUpload(subImgClass) {
		var frmEle = document.forms[0];
		var formData = new FormData(frmEle);
		
			/* formData.append("text_no",subImgClass); */

		//파일 업로드 확장자 확인
		// 		var file = form.file; 여기 부분이 아직 불확실
		// 		var fileExt = file.substring(file.lastIndex(".")+1);
		// 		var reg = /gif|jpg|png|jpeg/i;
		// 		if(reg.test(fileExt)==false){
		// 			alert("이미지는 gifm jpg, png 파일만 올릴 수 있습니다.");

		// 			return;
		// 		}

		//파일 사이즈 확인

		//파일 업로드 확장자 및 사이즈 확인을 메소드로 만들어서 true가 되면 아작스 실행

	$.ajax({
			url : './uploadSketchBook.do',
			type : 'post',
			data : formData,
			enctype : 'multipart/form-data',
			processData : false,
			contentType : false,
			success : function(result) {
				alert("아작스 결과"+result);
						$("div[id=modalIMG1]").css("background-image", "url('" + result+ "')");
						var img_spath = $("input[class=img_spath0]");
						img_spath.val(result);
			},error : function(){
				alert("실패");
			}
		});
	}
	
	
	// 테마별, 작성 스케치북 조회 무한스크롤 후 캔버스 조회 페이지로 이동
	function goCanvas(sketch_id) {
		//alert(sketch_id);
		location.href="./kim.do?sketch_id="+sketch_id;
	}	
	
	
	
	