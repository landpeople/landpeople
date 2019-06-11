package happy.land.people.ctrl;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.imgscalr.Scalr;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ServletConfigAware;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.util.WebUtils;

import happy.land.people.dto.ChatContentDto;
import happy.land.people.dto.ChatImageFileDto;
import happy.land.people.dto.JsonUtil;
import happy.land.people.dto.LPUserDto;
import happy.land.people.model.chat.IChatService;
import happy.land.people.model.manager.IManagerService;

@Controller
public class ChatController implements ServletConfigAware {

	@Autowired
	IChatService chatService;
	
	@Autowired
	IManagerService managerService;

	/**
	 * 채팅에 관련된 정보를 담기 위해 Application 객체 생성
	 */
	private ServletContext servletContext;

	// 8. log처리를 위한 logger객체 생성
	Logger logger = LoggerFactory.getLogger(ChatController.class);

	@RequestMapping(value="/myChatroom.do", method=RequestMethod.GET)
	public String myChatroom(HttpServletResponse response, String sender, String receiver) throws IOException {
		logger.info("Controller myChatroom");
		
		if (sender != null) {
			response.setCharacterEncoding("UTF-8");
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			out.println("<script>window.open('socketOpen.do?sender="+sender+"&receiver="+receiver+"','new','width=600, height=700'); </script>");
			return null;
		}
		
		return "manager/chatList";
	}
	
	public String createUUID() {
		return UUID.randomUUID().toString();
	}

	@Override
	public void setServletConfig(ServletConfig servletConfig) {
		servletContext = servletConfig.getServletContext();
	}

	// 사이드바에 채팅 접속자 리스트 출력
	@RequestMapping(value = "/chatList.do", method = RequestMethod.GET)
	public String chatList(Model model) {
		List<String> users = chatService.chatList_SelectAll();
		System.out.println("● ChatController chatList.do / 접속 회원 리스트 : " + users);
		model.addAttribute("users", users); // 채팅 리스트 페이지에 띄워줄 회원 리스트를 가지고 이동
		return "/chat/chatList";
	}

	// WebSocket 채팅 접속했을 때
	@RequestMapping(value = "/socketOpen.do", method = RequestMethod.GET)
	public String socketOpen(HttpSession session, Model model, String sender, String receiver) {

		System.out.println("● ChatController socketOpen.do / 현 세션의 사용자 닉네임 user: " + sender);

		Map<String, String> map = new HashMap<String, String>();
		map.put("sender", sender);
		map.put("receiver", receiver);

		/** 다오를 통해서 나랑 상대방의 채팅방이 기존에 있는지 확인하면서 존재여부에 따라 처리하는 메소드 */
		List<ChatContentDto> contentList = chatService.chatRoom_Make(map);

		String chr_id = contentList.get(0).getChr_id();

		session.setAttribute("test", "● Chat setAttribute TEST");
		session.setAttribute("chr_id", chr_id); // setAttribute 하면 handler에서 이 내용을 가지고 활용 가능
		session.setAttribute("user", sender); // 현재 나의 닉네임이 보내는 사람이므로 현재 나의 session을 등록하여줌
		session.setAttribute("receiver", receiver);

		String messageList = "";

		for (int i = 2; i < contentList.size(); i++) {
			messageList += contentList.get(i).getChc_message();
		}

		messageList = messageList.replaceAll("null", "");
		System.out.println("● ChatController socketOpen.do > messageList" + messageList);

		model.addAttribute("messageList", messageList); // 접속과 동시에 화면에 이전 대화내용을 모두 가져감

		/** 채팅 리스트 띄워주기 */
		logger.info("● ChatController socketOpen.do / 채팅방 리스트를 띄워주기 위해 리스트 담기 시작");
//		String mem_id = (String) session.getAttribute("user");
		logger.info("● ChatController socketOpen.do / 유저 닉네임 : " + sender);
		logger.info("● ChatController socketOpen.do / 채팅방 아이디 : " + chr_id);
		HashMap<String, String> chatList = (HashMap<String, String>) servletContext.getAttribute("chatList");
		
		if (chatList == null) {
			chatList = new HashMap<String, String>();
			chatList.put(sender, chr_id);
			servletContext.setAttribute("chatList", chatList);
		} else {
			chatList.put(sender, chr_id);
			servletContext.setAttribute("chatList", chatList);
		}
		logger.info("● ChatController socketOpen.do / 소켓 화면 이동하여 리스트 값 전달");

		return "/chat/groupChat";
	}

	// WebSocket 채팅 종료했을 때
	@RequestMapping(value = "/socketOut.do", method = { RequestMethod.GET, RequestMethod.POST })
	public void socketOut(HttpSession session, String chc_content) {

//		System.out.println("● ChatController socketOut.do DB에 저장할 chc_content : " + chc_content);

		String chr_id = (String) session.getAttribute("chr_id");
		String user = (String) session.getAttribute("user");

		System.out.println("● ChatController socketOut.do / chr_id : " + chr_id);
		System.out.println("● ChatController socketOut.do / chr_id : " + user);

//		ChatContentDto dto = new ChatContentDto(chr_id, user, chc_content); // (제거 예정 )핸들러에서 처리 하므로 제거

//		int n = service.chatContent_InsertMsg(dto);

		/** 채팅 리스트 제거하기 */
		HashMap<String, String> chatList = (HashMap<String, String>) servletContext.getAttribute("chatList");
		System.out.println("● ChatController socketOut.do / 기존 접속 회원 리스트:" + chatList);
		if (chatList != null) {
			System.out.println("● ChatController socketOut.do / 멤버리스트에서 나간사람 세션 제거 :" + chatList);
			chatList.remove(user);
		}
		System.out.println("● ChatController socketOut.do / 갱신 후 접속 회원 리스트:" + chatList);
		servletContext.setAttribute("chatList", chatList);
	}

	//
//	@RequestMapping(value = "/insertMessage.do", method = RequestMethod.POST)
//	@ResponseBody
//	public void insertMessage(HttpSession session, String chc_content) {
//		System.out.println("● ChatController socketOut.do DB에 저장할 chc_content : " + chc_content);
//
//		String chr_id = (String) session.getAttribute("chr_id");
//		String user = (String) session.getAttribute("user");
//
//		System.out.println("● ChatController socketOut.do / chr_id : " + chr_id);
//		System.out.println("● ChatController socketOut.do / chr_id : " + user);
//
//		ChatContentDto dto = new ChatContentDto(chr_id, user, chc_content);
//
//		int n = service.chatContent_InsertMsg(dto);
//	}

	// 채팅 접속자 리스트 출력
	@RequestMapping(value = "/viewChatList.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Map<String, String>> viewChatList() {
		Map<String, Map<String, String>> map = new HashMap<String, Map<String, String>>();
		Map<String, String> chatList = (HashMap<String, String>) servletContext.getAttribute("chatList");
		System.out.println("● ChatController viewChatList.do : " + chatList);
		map.put("list", chatList);

		return map;
	}

	@RequestMapping(value = "/chkChatMember.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> chkChatMember(String chr_id) {
		String str = chatService.chkChatMember(chr_id);
		Map<String, String> map = new HashMap<String, String>();
		map.put("result", str);
		return map;
	}

	@RequestMapping(value = "/uploadChatImageFile.do", method = RequestMethod.POST, produces = "application/text; charset-utf-8;")
	@ResponseBody
	// 바이너리로 파일 전송이 안돼서 파일을 db에 저장 후 경로를 화면에 보내주고 ws.send 해서 경로만 보내주는 형태로 구현 진행
	public String fileUpload(HttpServletRequest request, MultipartHttpServletRequest multi_req, HttpSession session) throws IOException {

		logger.info("● ChatController uploadChatImageFile.do 실행");
		MultipartFile uploadfile = (MultipartFile) multi_req.getFile("file");

		String chr_id = (String) session.getAttribute("chr_id");

		logger.info("● ChatController uploadChatImageFile.do / chr_id : " + chr_id);

		// 원래 파일명
		String filename = uploadfile.getOriginalFilename();
		StringBuffer sb = new StringBuffer();
		String realPath = null;
		String thumbnailRealPath = null;

		InputStream inputStream = null;
		OutputStream outputStream = null;

		try {
			inputStream = uploadfile.getInputStream();
			// WebUtils : spring에서 제공하는 객체로 session에 담긴 여러가지 정보를 활용하게 한다.
			String path = WebUtils.getRealPath(request.getSession().getServletContext(), "/chatTemp");
			System.out.println("실제 업로드 경로 : " + path);

			File folder = new File(WebUtils.getRealPath(request.getSession().getServletContext(), "/chatTemp"));

			// 폴더 생성
			if (!folder.exists()) {
				folder.mkdirs();
			}

			// 파일 저장 이름(랜덤 이름 + 확장자)
			String saveName = sb.append(UUID.randomUUID().toString()).append(filename.substring(filename.lastIndexOf("."))).toString();
			System.out.println("saveName : " + saveName);

			// 파일 객체 생성
			File newfile = new File(path + "/" + saveName);
			if (!newfile.exists()) {
				newfile.createNewFile();
			}

			// 파일 출력
			outputStream = new FileOutputStream(newfile);

			int read = 0;
			byte[] b = new byte[(int) uploadfile.getSize()];

			while ((read = inputStream.read(b)) != -1) {
				outputStream.write(b, 0, read);
			}

			// 파일 상대 경로
			realPath = request.getContextPath() + "/chatTemp/" + saveName;

			thumbnailRealPath = makeTumbnail(realPath, request);

		} catch (IOException e) {
			e.printStackTrace();
		}

		return thumbnailRealPath;
	}

	// 썸네일 생성 메소드
	private String makeTumbnail(String originalImgPath, HttpServletRequest request) {
		String thumbnailRealPath = null;
		System.out.println("● ChatController makeTumbnail() 실행");
		try {
			if (!originalImgPath.contains("S_")) {
				String path = WebUtils.getRealPath(request.getSession().getServletContext(), "/chatTemp"); // 원본 이미지 상대 경로
				String originalImgName = originalImgPath.substring(originalImgPath.lastIndexOf("/") + 1); // 원본 파일 이름(확장자 포함)
				File file = new File(path + "/" + originalImgName);

				// 원본 이미지 메모리상에 로딩
				BufferedImage originalImg = ImageIO.read(file);

				int width = originalImg.getWidth();
				int height = originalImg.getHeight();

				BufferedImage thumbnailImg;
				
				// 썸네일 생성 (300*450)
				if (width > 300 || height > 300 && width > height) {
					System.out.println("가로가 더 크다아아아아아아아");
					thumbnailImg = Scalr.resize(originalImg, Scalr.Mode.AUTOMATIC, 450, 300);
				} else if(width > 300 || height > 300 && width == height) {
					thumbnailImg = Scalr.resize(originalImg, Scalr.Mode.AUTOMATIC, 300, 300);
				} else if (width > 300 || height > 300 && width < height){
					thumbnailImg = Scalr.resize(originalImg, Scalr.Mode.AUTOMATIC, 300, 450);
				} else {
					System.out.println("그냥 오리지널 이미지다아ㅏ아ㅏ아앙아");
					thumbnailImg = originalImg;	
				}

				// 썸네일 업로드 경로
				String thumbnailPath = WebUtils.getRealPath(request.getSession().getServletContext(), "/chatThumbnail"); // 썸네일 상대 경로
				System.out.println("● ChatController makeTumbnail() / thumbnail real path : " + thumbnailPath);

				// 썸네일 폴더 생성
				File folder = new File(WebUtils.getRealPath(request.getSession().getServletContext(), "/chatThumbnail"));
				if (!folder.exists()) {
					folder.mkdirs();
				}

				// 썸네일 이름
				String thumbnailSaveName = "S_" + originalImgName;

				// 썸네일 파일 객체 생성
				File thumbnailFile = new File(thumbnailPath + "/" + thumbnailSaveName);

				// 썸네일 파일 출력
				ImageIO.write(thumbnailImg, originalImgName.substring(originalImgName.lastIndexOf(".") + 1), thumbnailFile);

				// 썸네일 상대 경로
				thumbnailRealPath = request.getContextPath() + "/chatThumbnail/" + thumbnailSaveName;
				System.out.println("● ChatController makeTumbnail() / thumbnail relative path : " + thumbnailRealPath);
			} else {
				String path = request.getContextPath() + "/chatThumbnail/" + originalImgPath;
				return path;
			}

		} catch (IOException e) {
			e.printStackTrace();
		}

		return thumbnailRealPath;
	}
	
	// 채팅방 목록 조회
	@RequestMapping(value="/selectChatList.do")
	public void selectChatList(HttpServletRequest request, HttpServletResponse response, HttpSession session, String title,
			@ModelAttribute LPUserDto lDto, ModelMap model) {
		logger.info("Controller selectChatList");
		response.setCharacterEncoding("UTF-8");
		LPUserDto logdto = (LPUserDto) session.getAttribute("ldto");
		String id = logdto.getUser_nickname();
		
		PrintWriter out = null;

		System.out.println(title);
		
		String serviceImplYn = request.getParameter("param");
        System.out.println(serviceImplYn);
        String input = request.getParameter("param2");
        System.out.println(input);
		
        Map<String, Object> castMap = new HashMap<String, Object>();
        Map<String, Object> castMap2 = new HashMap<String, Object>();
        
        castMap = JsonUtil.JsonToMap(serviceImplYn); // quotZero json을 맵으로 변환시킨다.
        castMap2 = JsonUtil.JsonToMap(input); // quotZero json을 맵으로 변환시킨다.

        lDto.setServiceImplYn((String) castMap.get("serviceImplYn"));
        lDto.setInput((String) castMap2.get("input"));
                
        List<List<Map<String, String>>> jqGridList = chatService.selectChr(lDto, id);
        Map<String, Integer> jqGridListCnt = chatService.selectChrListCnt(lDto, id);
	        HashMap<String, Object> resMap = new HashMap<String, Object>();
	        
	        // 복잡한 구조의 list안의 list인 jqGridList를 그냥 List로 바꿔줌
	        List<Map<String, String>> listst = new ArrayList<Map<String, String>>();
	        for (int i = 0; i < jqGridList.size(); i++) {
	        	listst.add(jqGridList.get(i).get(0));
			}
	        
	        // 페이징
	        resMap.put("records", jqGridListCnt.get("TOTALTOTCNT"));
	        resMap.put("rows", listst);
	        resMap.put("page", request.getParameter("page"));
	        System.out.println("page from request "+request.getParameter("page"));
	        resMap.put("total", jqGridListCnt.get("TOTALPAGE"));
	        
	        System.out.println("resMap 입니다! : "+resMap);
	                
	        try {
				out = response.getWriter();
			} catch (IOException e) {
				e.printStackTrace();
			}
	                
	        out.write(JsonUtil.HashMapToJson(resMap).toString());
	}
	
	// 채팅방 삭제
	@RequestMapping(value="/deleteChatroom.do", method=RequestMethod.GET)
	public String deleteChatroom(HttpSession session, HttpServletRequest request) {
		logger.info("Controller deleteChatroom");
		String chrId = (String) request.getParameter("chksVal");
		System.out.println("chrId = "+chrId);
		String[] chrIds = chrId.split(",");
		
		LPUserDto ldto = (LPUserDto) session.getAttribute("ldto");
		String id = ldto.getUser_nickname();
		
		for (int i = 0; i < chrIds.length; i++) {
			chatService.deleteChatroom(chrIds[i], id);
			System.out.println(chrIds[i]+"번 채팅방 삭제 쿼리 실행!");
		}
		
		return "forward:/myChatroom.do";
	}
	
	@RequestMapping(value="/detailChatroom.do", method=RequestMethod.GET)
	public String detailChatroom(HttpSession session, HttpServletResponse response, String chrId) {
		logger.info("Controller detailChatroom {}", chrId);
		String sender = "";
		String receiver = "";
		
		LPUserDto ldto = (LPUserDto) session.getAttribute("ldto");
		String user = ldto.getUser_nickname();
		
		Map<String, String> map = managerService.detailChatroom(chrId);
		if (map.get("CHR_SENDER").equals(user)) {
			sender = user;
			receiver = map.get("CHR_RECEIVER");
		}else {
			sender = map.get("CHR_SENDER");
			receiver = user;
		}
		 
		return "forward:/myChatroom.do?sender="+sender+"&receiver="+receiver;
	}
}