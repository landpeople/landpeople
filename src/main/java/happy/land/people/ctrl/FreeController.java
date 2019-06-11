package happy.land.people.ctrl;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.imgscalr.Scalr;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.util.WebUtils;

import happy.land.people.dto.LPCanvasDto;
import happy.land.people.dto.LPTextDto;
import happy.land.people.model.canvas.ILPCanvasService;
import happy.land.people.model.canvas.ILPTextService;

@Controller
public class FreeController {
	private Logger log = LoggerFactory.getLogger(FreeController.class);
	
	@Autowired
	private  ILPTextService textService;
	
	@Autowired
	private ILPCanvasService canvasService;
	
	@RequestMapping(value="/editor.do", method=RequestMethod.GET)
	public String editorPopUp(String id, Model model) {
		model.addAttribute("id", id);
		return "/canvas/insertFreeCanvasEditor";
	}
	
	@RequestMapping(value="/upload.do", method=RequestMethod.POST)
	public String uploadPage(HttpSession session,String nowPageNo,String selectType){
    	// 페이지 번호 , 캔버스 id  
    	String sketch_id = (String)session.getAttribute("sketch_id");
    	LPCanvasDto dto = new LPCanvasDto("0", sketch_id, "임시 타이틀", selectType, nowPageNo);
    	session.setAttribute("canvas", dto);    	
		return "canvas/insertFreeCanvas_"+(Integer.parseInt(selectType)-1);
	}
	
	@RequestMapping(value="/uploadFile.do", method=RequestMethod.POST, produces="application/text;charset=UTF-8")
	@ResponseBody
	public String upload(MultipartHttpServletRequest mr, String text_no, HttpServletRequest request, Model model) {
		List<MultipartFile> tt = (List<MultipartFile>) mr.getFiles("file");
		
		MultipartFile uploadfile = tt.get(Integer.parseInt(text_no.substring((text_no.length()-1)))-1);
		
		//원래 파일명
		String filename = uploadfile.getOriginalFilename();
		StringBuffer sb = new StringBuffer();
		String realPath = null;
		
		InputStream inputStream = null;
		OutputStream outputStream = null;
		
		try {
			inputStream = uploadfile.getInputStream();
			String path = WebUtils.getRealPath(request.getSession().getServletContext(), "/tempFolder");
			System.out.println("실제 업로드 경로 : "+path);
			
			File folder = new File(WebUtils.getRealPath(request.getSession().getServletContext(), "/tempFolder"));
			
			//폴더 생성
			if(!folder.exists()) {
				folder.mkdirs();
			}
			
			//파일 저장 이름(랜덤 이름 + 확장자)
			String saveName = sb.append(UUID.randomUUID().toString()).
								append(filename.substring(filename.lastIndexOf("."))).toString();
			System.out.println("saveName : "+saveName);
			
			//파일 객체 생성
			File newfile = new File(path+"/"+saveName);
			if(!newfile.exists()) {
				newfile.createNewFile();
			}
			
			//파일 출력
			outputStream = new FileOutputStream(newfile);
			
			int read = 0;
			byte[] b = new byte[(int)uploadfile.getSize()];
			
			while((read=inputStream.read(b))!=-1) {
				outputStream.write(b, 0, read);
			}
			
			//파일 상대 경로
			realPath = request.getContextPath() + "/tempFolder/"+saveName;
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return realPath;
	}
	
	@RequestMapping(value="/insertData.do", method=RequestMethod.POST)
	public String insertData(LPTextDto cdto, HttpSession session, HttpServletRequest request) {
		boolean isc = false;
		
		// 캔버스 생성 
    	LPCanvasDto canvasDto =  (LPCanvasDto)session.getAttribute("canvas"); 
    	int chk = canvasService.canvasInsert(canvasDto);
    	System.out.println("캔버스 dto : "+canvasDto.toString());
    	String canvasID = canvasService.canvasSelectID(canvasDto);
    	canvasDto.setCan_id(canvasID);
    	System.out.println("set canvasid 캔버스 dto : "+canvasDto.toString());
		
		for (LPTextDto dto:cdto.getList()) {
			//썸네일 생성
			if(dto.getImg_spath()!=null && !StringUtils.isBlank(dto.getImg_spath())) {//이미지 DB 저장
				String origianlImgPath = dto.getImg_spath();
				String thumbnailImgPath = makeTumbnail(origianlImgPath, request);
				
				//dto에 썸네일 경로 넣어주기
				dto.setImg_spath(thumbnailImgPath);				
				dto.setCan_id(canvasDto.getCan_id());
				
				//텍스트 null 값 공백으로 치환
				String text_content = StringUtils.defaultString(dto.getText_content());
				dto.setText_content(text_content);
				
				//DB에 저장
				isc = textService.insertImgFile(dto);
			}else if(dto.getText_content()!=null && !StringUtils.isBlank(dto.getText_content())){//텍스트 DB 저장
				dto.setCan_id(canvasDto.getCan_id());
				//이미지 null 값 공백으로 치환
				String img_spath = StringUtils.defaultString(dto.getImg_spath());
				dto.setImg_spath(img_spath);

				// 엔터키 지우기 위한 변수선언
				String resultText = dto.getText_content();					
				// 입력한 내용 중간에 엔터가 있는지 탐색 후 삭제
				resultText = resultText.replaceAll(System.getProperty("line.separator")," ");
				// 엔터키 삭제한 값을 dto에 다시 담음
				dto.setText_content(resultText);				

				//DB에 저장
				isc = textService.insertImgFile(dto);				
			}else if(StringUtils.isBlank(dto.getImg_spath())) {
					dto.setCan_id(canvasDto.getCan_id());
					//이미지에 공백 추가
					dto.setImg_spath("　");
					//공백 추가
					String text_content = "　";
					dto.setText_content(text_content);
					//DB에 저장
					isc = textService.insertImgFile(dto);
			}
		}

		if(isc) {
			 System.out.println("데이터베이스 정보 추가 성공");
		}else {
			System.out.println("데이터베이스 정보 추가 실패.");
		}
		String sketch_id = (String)session.getAttribute("sketch_id");
		
		return "redirect:/detailCanvas.do?sketch_id="+sketch_id;
	}
	
	//썸네일 생성 메소드
	private String makeTumbnail(String originalImgPath, HttpServletRequest request) {
		String thumbnailRealPath = null;
		try {
			
			if(!originalImgPath.contains("S_")) {
				String path = WebUtils.getRealPath(request.getSession().getServletContext(), "/tempFolder"); //원본 이미지 상대 경로
				String originalImgName = originalImgPath.substring(originalImgPath.lastIndexOf("/")+1); //원본 파일 이름(확장자 포함)
				File file = new File(path+"/"+originalImgName);
				
				//원본 이미지 메모리상에 로딩
				BufferedImage originalImg = ImageIO.read(file);
				
				//썸네일 생성 (300*450)
				BufferedImage thumbnailImg = Scalr.resize(originalImg, Scalr.Mode.AUTOMATIC, 300, 450);
				
				//썸네일 업로드 경로
				String thumbnailPath = WebUtils.getRealPath(request.getSession().getServletContext(), "/thumbnailImg"); //썸네일 상대 경로
				
				//썸네일 폴더 생성
				File folder = new File(WebUtils.getRealPath(request.getSession().getServletContext(), "/thumbnailImg"));
				if(!folder.exists()) {
					folder.mkdirs();
				}
				
				//썸네일 이름 
				String thumbnailSaveName = "S_"+originalImgName;
				
				//썸네일 파일 객체 생성
				File thumbnailFile = new File(thumbnailPath +"/"+thumbnailSaveName);
				
				//썸네일 파일 출력
				ImageIO.write(thumbnailImg, originalImgName.substring(originalImgName.lastIndexOf(".")+1), thumbnailFile);
				
				//썸네일 상대 경로
				thumbnailRealPath = request.getContextPath()+"/thumbnailImg/"+thumbnailSaveName;
			
			}else {
				String path = originalImgPath;
				return path;
			}
			
		} catch (IOException e) {
			e.printStackTrace();
		}
				
		return thumbnailRealPath;
	}
	
	//자유 캔버스 수정
    @RequestMapping(value="/updateFreeCanvas.do", method=RequestMethod.POST)
	public String updateData(LPTextDto tDto, HttpSession session, HttpServletRequest request) {
		
		LPCanvasDto cdto = (LPCanvasDto)session.getAttribute("canvas");
		
		//캔버스 id 가져오기
		String can_id = textService.canvasSelectID(cdto);
		System.out.println("can_id : "+can_id);
		int delCnt = 0;
		
		//해당 캔버스 내용 삭제
		if(cdto != null) {
			delCnt = textService.textDelete(cdto.getCan_id());
		}
		
		//수정 내용 재저장
		for(LPTextDto dto:tDto.getList()) {
			if(delCnt>0) {
				
				if(dto.getImg_spath()!=null && !StringUtils.isBlank(dto.getImg_spath())) {
					//썸네일 생성 및 dto에 추가
					String thumbnailPath = makeTumbnail(dto.getImg_spath(), request);
					dto.setImg_spath(thumbnailPath);
					
					//텍스트 값 null로 치환 및 dto에 추가
					String text_content = StringUtils.defaultString(dto.getText_content());
					dto.setText_content(text_content);
					
					//캔버스 id 추가
					dto.setCan_id(can_id);
					
					//DB에 저장
					textService.insertImgFile(dto);
					
				}else if(dto.getText_content()!=null && !StringUtils.isBlank(dto.getText_content())){
					//이미지 경로 null로 치환 및 dto에 추가
					String img_spath = StringUtils.defaultString(dto.getImg_spath());
					dto.setImg_spath(img_spath);
					
					// 엔터키 지우기 위한 변수선언
					String resultText = dto.getText_content();					
					// 입력한 내용 중간에 엔터가 있는지 탐색 후 삭제
					resultText = resultText.replaceAll(System.getProperty("line.separator")," ");
					// 엔터키 삭제한 값을 dto에 다시 담음
					dto.setText_content(resultText);
					
					//캔버스 id 추가
					dto.setCan_id(can_id);
					
					//DB에 저장
					textService.insertImgFile(dto);
					
				}else if(StringUtils.isBlank(dto.getImg_spath())) {
						
						//캔버스 id 추가
						dto.setCan_id(can_id);
						
						//이미지에 공백 추가
						dto.setImg_spath("　");
						//공백 추가
						String text_content = "　";
						dto.setText_content(text_content);
						
						//DB에 저장
						textService.insertImgFile(dto);
				}
				
			}else {
				return "404Error";
			}
		}
		String sketch_id = (String)session.getAttribute("sketch_id");		
		return "redirect:/detailCanvas.do?sketch_id="+sketch_id;
	}
}
