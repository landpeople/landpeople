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
import happy.land.people.dto.SketchPagingDto;
import happy.land.people.model.sketch.ISketchBookService;

@Controller
public class SketchController {

	private Logger logger = LoggerFactory.getLogger(SketchController.class);
	
	@Autowired
	private ISketchBookService iSketchBookService;
	
	// 스케치북 작성권한 확인
	@RequestMapping(value="/sketchMakeForm.do", method=RequestMethod.GET)
	@ResponseBody
	public Map<String, String> sketchIsWrite(String user_email) {
		
		Map<String, String> map = new HashMap<String, String>();
		
		
		String user_iswrite = iSketchBookService.sketchSelectWrite(user_email);
	
		map.put("user_email", user_email);
		map.put("user_iswrite", user_iswrite);
		System.out.println(map);
		
		
		return map;
	}
	
	// 스케치북 작성
	@RequestMapping(value="/writeSketch.do", method=RequestMethod.POST)
	public  String makeSketch(LPSketchbookDto dto, HttpServletRequest request, Model model) {
		logger.info("sketchBook 생성 {}", dto);
		// 스케치북 생성 (제목, 여행테마, 공유 여부, 커버이미지)
		
		
		System.out.println(dto.getSketch_spath());
		if(dto.getSketch_spath()==null||dto.getSketch_spath()=="") {
			
			dto.setSketch_spath("./img/sketch/제주배경.jpg");
			boolean isc = iSketchBookService.sketchInsert(dto);
			System.out.println(isc);	
		}else {
			String s_path= makeTumbnail(dto.getSketch_spath(), request);
			System.out.println("dto에 담기는 s_path 이미지 경로 = "+dto.getSketch_spath());
			dto.setSketch_spath(s_path);
			boolean isc = iSketchBookService.sketchInsert(dto);
			System.out.println(isc);
		}
		
		return "redirect:/detailCanvas.do?sketch_id=" + dto.getSketch_id();
	}
	
	
	// 스케치북 커버이미지 업로드
	@RequestMapping(value="/uploadSketchBook.do", method= RequestMethod.POST, produces="application/text;charset=UTF-8")
	@ResponseBody
	public String upload(MultipartHttpServletRequest mr, HttpServletRequest request, Model model) {
		List<MultipartFile> tt = (List<MultipartFile>) mr.getFiles("file");
		System.out.println("1번 이미지 : "+tt.get(0).getOriginalFilename()); 

			
		MultipartFile uploadfile = tt.get(0);
			
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
	
	
	
	
	@RequestMapping(value="/LPLike.do",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, String> LikeChange(String user_email, String sketch_id, LPCollectDto dto){
	
		
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
				
		System.out.println("좋아요 상태 변경 성공 = "+Lisc);
		
				
		return result;
	}
	
	// 스케치북 스크랩
	@RequestMapping(value="Scrape.do", method=RequestMethod.GET)
	@ResponseBody
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
		
		System.out.println("스크랩 상태 변경 성공 = "+sisc);
		return sresult;
	}
	
	//내 스크랩 목록 보기
	@RequestMapping(value="SelectScrapeSketch.do", method=RequestMethod.GET)
	public String scrapeListMine(String user_email, Model model){
		
		System.out.println("스크랩한 유저 이메일 ="+user_email);
		// 페이지 처리를 위한 스크랩한 스케치북 카운트 조회
		int cnt = iSketchBookService.scrapeCnt(user_email);
		// 스크랩한 스케치북 페이징 처리
		SketchPagingDto pagingDto = new SketchPagingDto(9, 1, cnt, 9);
		Map<String, String> map = new HashMap<String, String>();
		map.put("user_email", user_email);
		map.put("first", String.valueOf(pagingDto.getFirstBoardNo()));
		map.put("last", String.valueOf(pagingDto.getEndBoardNo()));		
		// 스크랩한 스케치북 조회
		List<LPSketchbookDto> myScrapeList = iSketchBookService.scrapeSelectMine(map);
		System.out.println(myScrapeList);
		model.addAttribute(myScrapeList);

		// 스케치북 id에 따른 카운트 저장할 변수 
		Map<String,Integer> sketchLike = new HashMap<String,Integer>();
		Map<String, String> sketchNickname = new HashMap<String, String>();
		for (int i = 0; i < myScrapeList.size(); i++) {
					
			// 스케치북 id 
			String sketch_id = myScrapeList.get(i).getSketch_id();
			// 스케치북 좋아요 갯수 조회
			int likeCnt = iSketchBookService.likeCnt(sketch_id);
			sketchLike.put(sketch_id, likeCnt);
			// 스케치북 작성자 닉네임 조회
			String nickname = iSketchBookService.nicknameSelect(sketch_id);
			sketchNickname.put(sketch_id, nickname);
					
			}
		
		System.out.println("스크랩한 스케치북 조회 좋아요 카운팅  = "+sketchLike);
		System.out.println("스크랩한 스케치북 닉네임 조회 = "+sketchNickname);
		model.addAttribute("pagingDto", pagingDto);
		model.addAttribute("myScrapeList", myScrapeList);
		model.addAttribute("sketchLike", sketchLike);
		model.addAttribute("scrapeSketchNickname", sketchNickname);
		
		return "/sketch/selectScrapSketch";
	}
	
	
	
	// 스크랩한 스케치북 페이징 처리
	@RequestMapping(value="scrapeSketchBookPaging.do", method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> scrapeSketchPaging(String user_email, String pageNo, Model model){
		
		// 페이지 처리를 위한 스크랩한 스케치북 카운트 조회
		int cnt = iSketchBookService.scrapeCnt(user_email);
		// 스크랩한 스케치북 페이징 처리
		SketchPagingDto pagingDto = new SketchPagingDto(9, Integer.parseInt(pageNo), cnt, 9);
		Map<String, String> map = new HashMap<String, String>();
		map.put("user_email", user_email);
		map.put("first", String.valueOf(pagingDto.getFirstBoardNo()));
		map.put("last", String.valueOf(pagingDto.getEndBoardNo()));		
		// 스크랩한 스케치북 조회
		List<LPSketchbookDto> myScrapeListPaging = iSketchBookService.scrapeSelectMine(map);
		System.out.println(myScrapeListPaging);
		

		// 스케치북 id에 따른 카운트 저장할 변수 
		Map<String,Integer> sketchLike = new HashMap<String,Integer>();
		Map<String, String> sketchNickname = new HashMap<String, String>();
		for (int i = 0; i < myScrapeListPaging.size(); i++) {
					
			// 스케치북 id 
			String sketch_id = myScrapeListPaging.get(i).getSketch_id();
			// 스케치북 좋아요 갯수 조회
			int likeCnt = iSketchBookService.likeCnt(sketch_id);
			sketchLike.put(sketch_id, likeCnt);
			// 스케치북 작성자 닉네임 조회
			String nickname = iSketchBookService.nicknameSelect(sketch_id);
			sketchNickname.put(sketch_id, nickname);
					
			}
		
		System.out.println("무한스크롤 처리된 스크랩한 스케치북 조회 좋아요 카운트 = "+sketchLike);
		System.out.println("무한스크롤 처리된 스크랩한 스케치북 닉네임 조회 = "+sketchNickname);
		Map<String,Object> resultMap = new HashMap<String,Object>();
		resultMap.put("addScrapeSketchBook", myScrapeListPaging);		
		resultMap.put("likeScrape", sketchLike);
		resultMap.put("scrapeSketchNickname", sketchNickname);
		
		return resultMap;
		
	}
	
	
	// 스케치북 스크랩 다중 취소 
	@RequestMapping(value="multiScrapeUpdate.do", method=RequestMethod.POST)
	public String scrapeMutilUpdate(String[] chkVal, HttpSession sesseion, Model model) {
		
		logger.info("JungController scrapeMutilUpdate {}", Arrays.toString(chkVal));
		Map<String, String[]>map = new HashMap<String, String[]>();
		LPUserDto ldto = (LPUserDto) sesseion.getAttribute("ldto");
		String email = ldto.getUser_email();
		System.out.println(email+"스크랩 취소할 유저 이메일 확인!!!!!!!");
		String[] user_email = {email};
		System.out.println(Arrays.toString(user_email));
		map.put("user_email_", user_email);
		map.put("sketch_id_", chkVal);
		
		boolean isc = iSketchBookService.scrapeMultiUpdate(map);
		
		return "redirect:/Scrape.do";
	}
	
	
	
	// 작성 스케치북 조회
	@RequestMapping(value="sketchSelMine.do", method=RequestMethod.GET)
	public String selectMySketch(String user_email, Model model) {
		
		System.out.println(user_email);
		// 페이지 처리를 위한 작성 스케치북 카운트 조회
		int cnt = iSketchBookService.sketchCntMine(user_email);
		// 작성 스케치북 페이징 처리
		SketchPagingDto pagingDto = new SketchPagingDto(9, 1, cnt, 9);
		Map<String,String> map = new HashMap<String,String>();
		map.put("user_email", user_email);
		map.put("first", String.valueOf(pagingDto.getFirstBoardNo()));
		map.put("last", String.valueOf(pagingDto.getEndBoardNo()));	
		List<LPSketchbookDto> mySketchBookList = iSketchBookService.sketchSelectMine(map);
		
		// 스케치북 id에 따른 카운트 저장할 변수 
		Map<String,Integer> sketchLike = new HashMap<String,Integer>();
		Map<String, String> sketchNickname = new HashMap<String, String>();
		for (int i = 0; i < mySketchBookList.size(); i++) {
			
			// 스케치북 id 
			String sketch_id = mySketchBookList.get(i).getSketch_id();
			// 스케치북 좋아요 갯수 조회
			int likeCnt = iSketchBookService.likeCnt(sketch_id);
			sketchLike.put(sketch_id, likeCnt);
			// 스케치북 작성자 닉네임 조회
			String nickname = iSketchBookService.nicknameSelect(sketch_id);
			sketchNickname.put(sketch_id, nickname);
			
		}
		
		
		System.out.println("작성 스케치북 조회 좋아요 카운팅  = "+sketchLike);
		System.out.println("작성 스케치북 닉네임 조회 = "+sketchNickname);
		model.addAttribute("pagingDto", pagingDto);
		model.addAttribute("mySketchBookLists", mySketchBookList);
		model.addAttribute("sketchLike", sketchLike);
		model.addAttribute("mySketchNickname",sketchNickname);
		
		return "/sketch/selectMySketch";
		
		
		
	}
	
	// 작성 스케치북 페이징 처리
	@RequestMapping(value="/mysketchBookPaging.do" ,method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> mysketchBookPaging(String user_email, String pageNo,String type,Model model) {
		
		// 페이지 처리를 위한 작성 스케치북 카운트 조회
		int cnt = iSketchBookService.sketchCntMine(user_email);
		// 작성 스케치북 페이징 처리
		SketchPagingDto pagingDto = new SketchPagingDto(9, Integer.parseInt(pageNo), cnt, 9);
		Map<String,String> map = new HashMap<String,String>();
		map.put("user_email", user_email);
		map.put("first", String.valueOf(pagingDto.getFirstBoardNo()));
		map.put("last", String.valueOf(pagingDto.getEndBoardNo()));
		List<LPSketchbookDto> MySketchBookListPaging= iSketchBookService.sketchSelectMine(map);
					
		// 스케치북 id에 따른 카운트 저장할 변수 
		Map<String,Integer> sketchLikes = new HashMap<String,Integer>();
		Map<String, String> sketchNickname = new HashMap<String, String>();
		for (int i = 0; i < MySketchBookListPaging.size(); i++) {
			
			// 스케치북 id 
			String sketch_id = MySketchBookListPaging.get(i).getSketch_id();
			// 스케치북 좋아요 갯수 조회
			int likeCnt = iSketchBookService.likeCnt(sketch_id);
			sketchLikes.put(sketch_id, likeCnt);
			// 스케치북 작성자 닉네임 조회
			String nickname = iSketchBookService.nicknameSelect(sketch_id);
			sketchNickname.put(sketch_id, nickname);
				
		}
		
		System.out.println("무한스크롤 처리된 작성 스케치북 조회 좋아요 카운트 = "+sketchLikes);
		System.out.println("무한스크롤 처리된 작성 스케치북 닉네임 조회 = "+sketchNickname);
		Map<String,Object> resultMap = new HashMap<String,Object>();
		resultMap.put("addMySketchBook", MySketchBookListPaging);		
		resultMap.put("likeMine", sketchLikes);
		resultMap.put("mySketchNicknames", sketchNickname);
		return resultMap;
	}
	
	
	
	// 스케치북 수정폼 생성
	@RequestMapping(value="sketchModifyForm.do", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, LPSketchbookDto> sketchModifyForm(String user_email, String sketch_id, LPSketchbookDto dto){
		// 수정할 스케치북 하나 선택
		LPSketchbookDto sdto = iSketchBookService.sketchSelectOne(dto);
		System.out.println(sdto);
		Map<String, LPSketchbookDto> map = new HashMap<String, LPSketchbookDto>();
		map.put("sdto", sdto);
		System.out.println(sdto.getUser_email());
		
		return map;
	} 
	
	// 작성 스케치북 수정
	@RequestMapping(value="modifySketch.do", method=RequestMethod.POST)
	public String modifySketchBook(LPSketchbookDto dto) {
		logger.info("JungController modifySketchBook {}", dto);
		System.out.println("수정할 이미지 경로 = "+dto.getSketch_spath().substring(dto.getSketch_spath().indexOf("/LandPeople")));
		String s_path = dto.getSketch_spath().substring(dto.getSketch_spath().indexOf("/LandPeople"));
		dto.setSketch_spath(s_path);
		
		boolean isc = iSketchBookService.sketchUpdate(dto);
	
		System.out.println(isc);
		return "redirect:/sketchSelMine.do";
	}
	
	
	// 작성 스케치북 삭제
	@RequestMapping(value="sketchMultiDelete.do", method=RequestMethod.POST)
	public String multiDeleteSketch(String[] chkVal, Model model) {
		logger.info("JungController multiDeleteSketch {}", Arrays.toString(chkVal));
		Map<String, String[]>map = new HashMap<String, String[]>();	
	
		map.put("sketch_id_", chkVal);		
		boolean isc = iSketchBookService.sketchMultiDelete(map);
		
		return "redirect:/sketchSelMine.do";
	}
	
	
	// 테마별 스케치북 조회
	@RequestMapping(value="/sketchBookTheme.do" ,method = RequestMethod.GET)
	public String selectThemeSketch(String type,HttpServletRequest request) {
		
		// 좋아요 카운팅이 가장 높은 스케치북 3개 조회
			List<LPSketchbookDto> maxLikeSketchBook = iSketchBookService.sketchSelectMaxLike(type);
			System.out.println("좋아요 카운팅이 가장 높은 스케치북 3개 조회  = "+maxLikeSketchBook);	
				
			// 스케치북 id에 따른 카운트 저장할 변수 
			Map<String,Integer> maxLike = new HashMap<String,Integer>();
			Map<String, String> likeSketchNickname = new HashMap<String, String>();
			for (int i = 0; i < maxLikeSketchBook.size(); i++) {
					
				// 스케치북 id
				String sketch_id = maxLikeSketchBook.get(i).getSketch_id();
				// 스케치북 좋아요 갯수 조회
				int likeCnt = iSketchBookService.likeCnt(sketch_id);
				maxLike.put(sketch_id, likeCnt);
				// 스케치북 작성자 닉네임 조회
				String nickname = iSketchBookService.nicknameSelect(sketch_id);
				likeSketchNickname.put(sketch_id, nickname);	
			}
				
			System.out.println("좋아요 카운트가 가장 높은 스케치북 작성자 닉네임 조회 = "+likeSketchNickname);
			System.out.println("좋아요 카운트가 가장 높은 스케치북 좋아요 카운팅 = "+maxLike);
		
				
		// 페이지 처리를 위한 테마별 스케치북 카운트 조회
		int cnt = iSketchBookService.sketchCntTheme(type);			
		System.out.println("선택한 테마의 종류 = "+type);
		// 테마별 스케치북 페이징 처리
		SketchPagingDto pagingDto = new SketchPagingDto(9, 1, cnt, 6);
		Map<String,String> map = new HashMap<String,String>();
		map.put("theme", type);
		map.put("first", String.valueOf(pagingDto.getFirstBoardNo()));
		map.put("last", String.valueOf(pagingDto.getEndBoardNo()));			
		// 테마별 스케치북 조회 
		List<LPSketchbookDto> themeSketchBookList= iSketchBookService.sketchSelectTheme(map);
		
		// 스케치북 id에 따른 카운트 저장할 변수 
		
			Map<String,Integer> sketchLike = new HashMap<String,Integer>();
			Map<String, String> sketchNickname = new HashMap<String, String>();
			for (int i = 0; i < themeSketchBookList.size(); i++) {
				
				// 스케치북 id
				String sketch_id = themeSketchBookList.get(i).getSketch_id();
				// 스케치북 좋아요 갯수 조회
				int likeCnt = iSketchBookService.likeCnt(sketch_id);
				sketchLike.put(sketch_id, likeCnt);
				// 스케치북 작성자 닉네임 조회
				String nickname = iSketchBookService.nicknameSelect(sketch_id);
				sketchNickname.put(sketch_id, nickname);
			
			}
			
				
		System.out.println("테마별 스케치북 조회 좋아요 카운팅  = "+sketchLike);
		System.out.println("테마별 스케치북 조회 닉네임 조회 = "+sketchNickname);	
		
		
		
		request.setAttribute("maxLikeSketchBook", maxLikeSketchBook);
		request.setAttribute("maxLike", maxLike);
		request.setAttribute("likeSketchNickname", likeSketchNickname);
		request.setAttribute("pagingDto", pagingDto);
		request.setAttribute("sketchBook", themeSketchBookList);
		request.setAttribute("sketchLike", sketchLike);
		request.setAttribute("sketchNickname", sketchNickname);
		request.setAttribute("type", type);
		
		return "/sketch/selectThemeSketch";
	}
		
	
	// 테마별 스케치북 조회 페이징 처리
	@RequestMapping(value="/sketchBookPaging.do" ,method = RequestMethod.GET)
	@ResponseBody
	public Map<String,Object> themeSketchBookPaging(String pageNo,String type,Model model) {
			
		int cnt = iSketchBookService.sketchCntTheme(type);
		System.out.println("화면에 뿌려줄 테마별 스케치북의 총 갯수 = "+cnt);
		SketchPagingDto pagingDto = new SketchPagingDto(9, Integer.parseInt(pageNo), cnt, 6);
		Map<String,String> map = new HashMap<String,String>();
		map.put("theme", type);
		map.put("first", String.valueOf(pagingDto.getFirstBoardNo()));
		map.put("last", String.valueOf(pagingDto.getEndBoardNo()));
		
		List<LPSketchbookDto> themeSketchBookListPaging= iSketchBookService.sketchSelectTheme(map);

		// 스케치북 id에 따른 카운트 저장할 변수 
		
		Map<String,Integer> sketchLikes = new HashMap<String,Integer>();
		Map<String, String> sketchNickname = new HashMap<String, String>();
		for (int i = 0; i < themeSketchBookListPaging.size(); i++) {
			
			// 스케치북 id 
			String sketch_id = themeSketchBookListPaging.get(i).getSketch_id();
			// 스케치북 좋아요 갯수 조회
			int likeCnt = iSketchBookService.likeCnt(sketch_id);
			sketchLikes.put(sketch_id, likeCnt);
			// 스케치북 작성자 닉네임 조회
			String nickname = iSketchBookService.nicknameSelect(sketch_id);
			sketchNickname.put(sketch_id, nickname);
		
		}
		
		System.out.println("무한스크롤 처리된 테마별 스케치북 조회 좋아요 카운트 = "+sketchLikes);
		System.out.println("무한스크롤 처리된 테마별 스케치북 닉네임 조회 = "+sketchNickname);
		
		
		Map<String,Object> resultMap = new HashMap<String,Object>();
		resultMap.put("addSketchBook", themeSketchBookListPaging);	
		resultMap.put("likeTheme", sketchLikes);
		resultMap.put("sketchNicknames", sketchNickname);
		
		
		
		return resultMap;
	}

	
	
	
	
}
	

