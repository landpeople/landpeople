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
import javax.servlet.http.HttpServletResponse;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.util.WebUtils;



import happy.land.people.dto.LPCollectDto;
import happy.land.people.dto.LPSketchbookDto;
import happy.land.people.dto.LPUserDto;
import happy.land.people.dto.SketchPagingDto;

import happy.land.people.model.ISketchBookService;

@Controller
public class JungController {

	private Logger logger = LoggerFactory.getLogger(JungController.class);
	
	@Autowired
	private ISketchBookService iSketchBookService;
	
	@ResponseBody
	@RequestMapping(value="/sketchMakeForm.do", method=RequestMethod.GET)
	public Map<String, String> sketchIsWrite(String user_email) {
		
		Map<String, String> map = new HashMap<String, String>();
		// 스케치북 작성권한 확인
		
		String user_iswrite = iSketchBookService.sketchSelectWrite(user_email);
	
		map.put("user_email", user_email);
		map.put("user_iswrite", user_iswrite);
		System.out.println(map);
		
		
		return map;
	}
	
	// 스케치북 작성
	@RequestMapping(value="/writeSketch.do", method=RequestMethod.POST)
	public  String sketchMake(LPSketchbookDto dto) {
		logger.info("sketchBook 생성 {}", dto);
		// 스케치북 생성 (제목, 여행테마, 공유 여부)
		boolean isc = iSketchBookService.sketchInsert(dto);
		System.out.println(isc);		
		return "kim";
	}
	
	
	
	@ResponseBody
	@RequestMapping(value="/LPLike.do",method=RequestMethod.GET)
	public Map<String, String> LikeChange(String user_email, String sketch_id, LPCollectDto dto){
		logger.info("JungController LikeChange 실행");
		
		//스케치북 좋아요 최초 등록 
		boolean isc = iSketchBookService.collectInsert(dto);
		System.out.println(isc+"좋아요  최초 등록~~~~~ 성공");
		logger.info("LikeChange 실행 {}", isc);
		
			
		// 스케치북 좋아요 상태 가져오기
		Map<String, String> map = new HashMap<String, String>();
		map.put("user_email", dto.getUser_email());
		map.put("sketch_id", dto.getSketch_id());
		String like = iSketchBookService.likeSelect(map);		
		
		// 스케치북 좋아요 상태 변경(등록, 취소)
		Map<String,String> result = new HashMap<String,String>();
	
		boolean Lisc = false;
		if(like.equalsIgnoreCase("F")) {
			map.put("like", "T");
			Lisc = iSketchBookService.likeUpdate(map);
			result.put("result", "T");
		}else{
			map.put("like", "F");
			Lisc = iSketchBookService.likeUpdate(map);
			result.put("result", "F");
		}		
				
		System.out.println(Lisc+"!!!!!!!!!!!~~!@!@!@!@!@");
		//logger.info("Controller CancelLike {}", isc);	
				
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="Scrape.do", method=RequestMethod.GET)
	public Map<String, String> scrapeState(String user_email, String sketch_id, LPCollectDto dto ) {
		// 스케치북 스크랩 최초 등록
		boolean isc = iSketchBookService.collectInsert(dto);
		System.out.println(isc+"스크랩 최초 등록~~~~~ 성공");
		logger.info("scrapeState 실행 {}", isc);
		
		// 스케치북 스크랩 상태 확인
		Map<String, String> map = new HashMap<String, String>();
		map.put("user_email", dto.getUser_email());
		map.put("sketch_id", dto.getSketch_id());
		String scrape = iSketchBookService.scrapeSelect(map);
	
		// 스케치북 스크랩 상태 변경(등록, 취소)
		Map<String, String> sresult =new HashMap<String, String>();
	 	
		
		boolean sisc = false;
		if(scrape.equalsIgnoreCase("F")) {
			map.put("scrape", "T");
			sisc = iSketchBookService.scrapeUpdate(map);
			sresult.put("sresult", "T");
		}else {
			map.put("scrape", "F");
			sisc = iSketchBookService.scrapeUpdate(map);
			sresult.put("sresult", "F");
		}
		
		System.out.println(sisc+"!!!!!!!!!!!~~!@!@!@!@!@");
		return sresult;
	}
	
	@RequestMapping(value="/imgupload.do", method=RequestMethod.GET)
	public String imguploading() {
		return null;
	}
	
	
	@RequestMapping(value="ScrapeSelect.do", method=RequestMethod.GET)
	@ResponseBody
	public Map<String, String> scrapeListMine(String user_email, Model model){
		//내 스크랩 목록 보기
	
		Map<String, String> map = new HashMap<String, String>();
		map.put("user_email", user_email);
		List<LPSketchbookDto> lists = iSketchBookService.scrapeSelectMine(map);
		System.out.println(lists);
		
		
		model.addAttribute(lists);
	
		if(lists.size() == 0) {
			System.out.println(lists.size());
			String htmlScrape = "";
			htmlScrape += "<tr>"+
					"<td>스크랩한 스케치북이 없습니다.</td>"+
					"</tr>";
			
			Map<String, String> scrapeResult = new HashMap<String, String>();
			scrapeResult.put("scrapeResult", htmlScrape);
			
			System.out.println(scrapeResult);
			
			return scrapeResult;
		}else {
		model.addAttribute(lists);
		System.out.println(lists.size());
		//System.out.println(lists.get(0).getSketch_title());
		//System.out.println(lists.get(0).getSketch_id());
		String htmlScrape = "";		
		for (int i = 0; i < lists.size(); i++) {
			String sketch_id = lists.get(i).getSketch_id();
		    System.out.println(sketch_id);
			// 좋아요 갯수 조회
			int likeCnt = iSketchBookService.likeCnt(sketch_id);
			System.out.println(likeCnt);
			
			htmlScrape += "<tr>"+
						"<td>"+
						"<input type='checkbox' name='chkVal' value='"+sketch_id+"'></td>"+
						"<td>"+lists.get(i).getSketch_title()+"</td>"+
						"<td>"+lists.get(i).getSketch_spath()+"</td>"+
						"<td>"+likeCnt+"</td>"+
						"</tr>";
		}
		
		Map<String, String> scrapeResult = new HashMap<String, String>();
		scrapeResult.put("scrapeResult", htmlScrape);
		System.out.println(scrapeResult);
		
		return scrapeResult;
		}
		
	}
	
	
	// 스케치북 스크랩 다중 취소 
	@RequestMapping(value="multiScrapeUpdate.do", method=RequestMethod.POST)
	public String scrapeMutilUpdate(String[] chkVal, Model model) {
		logger.info("JungController scrapeMutilUpdate {}", Arrays.toString(chkVal));
		Map<String, String[]>map = new HashMap<String, String[]>();
		String[] user_email = {"128@happy.com"};
		System.out.println(Arrays.toString(user_email));
		map.put("user_email_", user_email);
		map.put("sketch_id_", chkVal);
		
		boolean isc = iSketchBookService.scrapeUpdateMulti(map);
		
		
		
		return "redirect:/jeong.do";
	}
	
	// 작성 스케치북 조회
	@RequestMapping(value="sketchSelMine.do", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, String> sketchSelMine(String user_email) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("user_email", user_email);
		List<LPSketchbookDto> mySketchlists = iSketchBookService.sketchSelectMine(map);
		System.out.println(mySketchlists);
		System.out.println(mySketchlists.size());
		if(mySketchlists.size()==0) {
			String htmlMysketchBook="";
			htmlMysketchBook +="<tr>"+
							"<td>작성한 스케치북이 없습니다.</td>"+
							"</tr>";
			
			Map<String, String> mySketchBook = new HashMap<String, String>();
			mySketchBook.put("mySketchBook", htmlMysketchBook);
			
			System.out.println(mySketchBook);
			
			return mySketchBook;
			
		}else {
			String htmlMysketchBook="";
			for (int i = 0; i < mySketchlists.size(); i++) {
				String sketch_id = mySketchlists.get(i).getSketch_id();
				System.out.println(sketch_id);
				System.out.println(mySketchlists.size()+"내가 작성한 스케치북 갯수!!!!!!!!!!");
				// 좋아요 갯수 조회
				int likeCnt = iSketchBookService.likeCnt(sketch_id);
				System.out.println(likeCnt);
				
				htmlMysketchBook = "<tr>"+
						"<td>"+mySketchlists.get(i).getSketch_title()+"</td>"+
						"<td>"+mySketchlists.get(i).getSketch_spath()+"</td>"+
						"<td>"+likeCnt+"</td>"+
						"<td>"+
						"<a href='#' onclick='sketchBookModify()'><img alt='modi' src='img/sketchBookImg/modifyIcon.png'></a>"+
						"</td>"+
						"</tr>";
			
			System.out.println(htmlMysketchBook);
			}
			Map<String, String> mySketchBook = new HashMap<String, String>();
			mySketchBook.put("mySketchBook", htmlMysketchBook);
			System.out.println(mySketchBook);
			return mySketchBook;
		}
		
	}
	
	//스케치북 수정폼 생성
	@RequestMapping(value="sketchModifyForm.do", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, LPSketchbookDto> sketchModifyForm(String user_email, String sketch_id, LPSketchbookDto dto){
		
		LPSketchbookDto sdto = iSketchBookService.sketchSelectOne(dto);
		System.out.println(sdto);
		Map<String, LPSketchbookDto> map = new HashMap<String, LPSketchbookDto>();
		map.put("sdto", sdto);
	
		return map;
	} 
	
	
	
	
	@RequestMapping(value="/uploadSketchBook.do", method= RequestMethod.POST, produces="application/text;charset=UTF-8")
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


		//썸네일 생성 메소드
		private String makeTumbnail(String originalImgPath, HttpServletRequest request) {
			String thumbnailRealPath = null;
			try {
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
				
			} catch (IOException e) {
				e.printStackTrace();
			}
					
			return thumbnailRealPath;
		}
	
		// 테마별 스케치북 조회
		@RequestMapping(value="/sketchBookTheme.do" ,method = RequestMethod.GET)
		public String sketchBookTheme(String type,HttpServletRequest request) {
			
			int cnt = iSketchBookService.sketchCntTheme(type);			
			SketchPagingDto pagingDto = new SketchPagingDto(9, 1, cnt, 9);
			Map<String,String> map = new HashMap<String,String>();
			map.put("theme", type);
			map.put("first", String.valueOf(pagingDto.getFirstBoardNo()));
			map.put("end", String.valueOf(pagingDto.getEndBoardNo()));			
			List<LPSketchbookDto> sketchBookList= iSketchBookService.sketchSelectTheme(map);
			request.setAttribute("pagingDto", pagingDto);
			request.setAttribute("sketchBook", sketchBookList);
			return "/sketchBook/sketchBookTheme";
		}
		
		// 페이징 처리
		
		@ResponseBody
		@RequestMapping(value="/sketchBookPaging.do" ,method = RequestMethod.GET)
		public Map<String,List<LPSketchbookDto>> sketchBookPaging(String pageNo,String type,Model model) {
			
			int cnt = iSketchBookService.sketchCntTheme(type);
			SketchPagingDto pagingDto = new SketchPagingDto(9, Integer.parseInt(pageNo), cnt, 9);
			Map<String,String> map = new HashMap<String,String>();
			map.put("theme", type);
			map.put("first", String.valueOf(pagingDto.getFirstBoardNo()));
			map.put("end", String.valueOf(pagingDto.getEndBoardNo()));
						
			List<LPSketchbookDto> sketchBookList= iSketchBookService.sketchSelectTheme(map);
			Map<String,List<LPSketchbookDto>> resultMap = new HashMap<String,List<LPSketchbookDto>>();
			resultMap.put("addSketchBook", sketchBookList);		
			
			return resultMap;
		}
}
	

