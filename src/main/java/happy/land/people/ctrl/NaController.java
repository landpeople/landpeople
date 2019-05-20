package happy.land.people.ctrl;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.util.StringUtil;
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

import happy.land.people.dto.kim.LPCanvasDto;
import happy.land.people.dto.kim.LPTextDto;
import happy.land.people.model.kim.ILPCanvasService;
import happy.land.people.model.kim.ILPTextService;


@Controller
public class NaController {
	private Logger log = LoggerFactory.getLogger(NaController.class);
	
	@Autowired
	private  ILPTextService textService;
	
	@Autowired
	private ILPCanvasService canvasService;
	
	@RequestMapping(value="/upload.do", method=RequestMethod.POST)
	public String uploadPage(HttpSession session,String nowPageNo){
    	// 페이지 번호 , 캔버스 id     	
    	LPCanvasDto dto = new LPCanvasDto("0001", "1", "제목은 대충", "내용도 아무거나", "2", nowPageNo);
    	session.setAttribute("canvas", dto);
		return "na_insertFreeCanvas";
	}
	
	@RequestMapping(value="/uploadFile.do", method=RequestMethod.POST, produces="application/text;charset=UTF-8")
	@ResponseBody
	public String upload(MultipartHttpServletRequest mr, String text_no, HttpServletRequest request, Model model) {
		List<MultipartFile> tt = (List<MultipartFile>) mr.getFiles("file");
		System.out.println("1번 이미지 : "+tt.get(0).getOriginalFilename()); 
		System.out.println("2번 이미지 : "+tt.get(1).getOriginalFilename()); 
		System.out.println("3번 이미지 : "+tt.get(2).getOriginalFilename()); 
		
		MultipartFile uploadfile = tt.get(Integer.parseInt(text_no.substring(3))-1);
		
		//원래 파일명
		String filename = uploadfile.getOriginalFilename();
		StringBuffer sb = new StringBuffer();
		String realPath = null;
		
		InputStream inputStream = null;
		OutputStream outputStream = null;
		
		try {
			inputStream = uploadfile.getInputStream();
			//WebUtils : spring에서 제공하는 객체로 session에 담긴 여러가지 정보를 활용하게 한다.
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
		log.info("dto list 사이즈"+cdto.getList().size());
		
		boolean isc = false;
		
		// 캔버스 생성 부분 
    	LPCanvasDto canvasDto =  (LPCanvasDto)session.getAttribute("canvas");    	
    	int chk = canvasService.canvasInsert(canvasDto);
    	String canvasID = canvasService.canvasSelectID(canvasDto);
    	canvasDto.setCan_id(canvasID);
    	
		
		for (LPTextDto dto:cdto.getList()) {
			System.out.println(dto.toString());
			
			//썸네일 생성
			//컨트롤러로 이동할 예정(request 객체를 DAO에서 못 받아 올 수 있기 때문에 완료 후 수정시 실행)
			if(dto.getImg_spath()!=null) {
				String origianlImgPath = dto.getImg_spath();
				String thumbnailImgPath = makeTumbnail(origianlImgPath, request);
				
				//dto에 썸네일 경로 넣어주기
				dto.setImg_spath(thumbnailImgPath);				
				dto.setCan_id(canvasDto.getCan_id());
				
				//텍스트 null 값 공백으로 치환
				String text_content = StringUtils.defaultString(dto.getText_content());
				dto.setText_content(text_content);
				System.out.println("=====썸네일로 변경된 dto"+dto.toString());
				
				//DB에 저장
				isc = textService.insertImgFile(dto);
			}else {
				dto.setCan_id(canvasDto.getCan_id());
				//이미지 null 값 공백으로 치환
				String img_spath = StringUtils.defaultString(dto.getImg_spath());
				dto.setImg_spath(img_spath);
				// 엔터키 지우기
				String resultText = dto.getText_content();				
				// 엔터 추출
				int cutWord =  10;
				// 마지막에 있는 엔터 먼저 없애고 반복문 실행				
				resultText = resultText.substring(0, resultText.length()-2);	
				// 입력한 내용 중간에 엔터가 있는지 탐색
				/*for(int i = 0 ;i < resultText.length() ; i++) {
					int chkNum = resultText.indexOf(cutWord);	
					if(chkNum == -1)
						break;
					else {
						String StartContent = resultText.substring(0, chkNum);
						String EndContent = resultText.substring(chkNum,resultText.length()-1);
						resultText = StartContent+EndContent;
					}
				}*/
				
				dto.setText_content(resultText);
				System.out.println(resultText);
				//DB에 저장
				isc = textService.insertImgFile(dto);				
			}
		}

		if(isc) {
			// List<LPTextDto> textList = textService.textSelectOne("2");
			// session.setAttribute("textList", textList);		 
			 
			 System.out.println("데이터베이스 정보 추가 성공");
		}else {
			System.out.println("데이터베이스 정보 추가 실패.");
		}
		return "kim";
	}
	
	//썸네일 생성 메소드
	private String makeTumbnail(String originalImgPath, HttpServletRequest request) {
		String thumbnailRealPath = null;
		try {
			
			if(!originalImgPath.contains("S_")) {
				System.out.println("------------------썸네일이 아닌 사진");
				String path = WebUtils.getRealPath(request.getSession().getServletContext(), "/tempFolder"); //원본 이미지 상대 경로
				String originalImgName = originalImgPath.substring(originalImgPath.lastIndexOf("/")+1); //원본 파일 이름(확장자 포함)
				File file = new File(path+"/"+originalImgName);
				
				//원본 이미지 메모리상에 로딩
				BufferedImage originalImg = ImageIO.read(file);
				
				//썸네일 생성 (300*450)
				BufferedImage thumbnailImg = Scalr.resize(originalImg, Scalr.Mode.AUTOMATIC, 300, 450);
				
				//썸네일 업로드 경로
				String thumbnailPath = WebUtils.getRealPath(request.getSession().getServletContext(), "/thumbnailImg"); //썸네일 상대 경로
				System.out.println("===========실제 썸네일 업로드 경로 : "+thumbnailPath);
				
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
				System.out.println("썸네일 상대 경로 : "+thumbnailRealPath);
			
			}else {
				System.out.println("------------------썸네일인 사진");
				String path = request.getContextPath()+"/thumbnailImg/"+originalImgPath;
				System.out.println("변경 되지 않은 썸네일 경로 : "+path);
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
		System.out.println("캔버스 값 : "+cdto.toString());
		System.out.println("화면에서 수정을 위해 받은 값"+tDto.getList().toString());
		
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
				
				if(dto.getImg_spath()!=null) {
					//썸네일 생성 및 dto에 추가
					String thumbnailPath = makeTumbnail(dto.getImg_spath(), request);
					tDto.setImg_spath(thumbnailPath);
					
					//텍스트 값 null로 치환 및 dto에 추가
					String text_content = StringUtils.defaultString(dto.getText_content());
					dto.setText_content(text_content);
					
					//캔버스 id 추가
					dto.setCan_id(can_id);
					
					//DB에 저장
					textService.insertImgFile(dto);
				}else {
					//이미지 경로 null로 치환 및 dto에 추가
					String img_spath = StringUtils.defaultString(dto.getImg_spath());
					dto.setImg_spath(img_spath);
					
					// 엔터키 지우기
					String resultText = dto.getText_content();				
					// 엔터 추출
					int cutWord =  10;
					resultText = resultText.substring(0, resultText.length()-2);	
					dto.setText_content(resultText);
					
					//캔버스 id 추가
					dto.setCan_id(can_id);
					
					//DB에 저장
					textService.insertImgFile(dto);
				}
				
			}else {
				return "404Error";
			}
		}
		return "kim";
	}
}
