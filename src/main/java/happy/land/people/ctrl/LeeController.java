package happy.land.people.ctrl;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ServletConfigAware;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import happy.land.people.dto.LPChatContentDto;
import happy.land.people.model.lee.ILeeService;

@Controller
public class LeeController implements ServletConfigAware {

	@Autowired
	ILeeService service;

	/**
	 * 채팅에 관련된 정보를 담기 위해 Application 객체 생성
	 */
	private ServletContext servletContext;
	
//	@Resource(name="uploadPath")
	String uploadPath;

	// 8. log처리를 위한 logger객체 생성
	Logger logger = LoggerFactory.getLogger(LeeController.class);

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
		List<String> users = service.chatList_SelectAll();
		System.out.println("● LeeController chatList.do / 접속 회원 리스트 : " + users);
		model.addAttribute("users", users); // 채팅 리스트 페이지에 띄워줄 회원 리스트를 가지고 이동
		return "/chat/chatList";
	}

	// WebSocket 채팅 접속했을 때
	@RequestMapping(value = "/socketOpen.do", method = RequestMethod.GET)
	public String socketOpen(HttpSession session, Model model, String sender, String receiver) {

		System.out.println("● LeeController socketOpen.do / 현 세션의 사용자 닉네임 user: " + sender);

		Map<String, String> map = new HashMap<String, String>();
		map.put("sender", sender);
		map.put("receiver", receiver);
		// 여기서 테이블의 다오를 통해서 나랑 상대방의 채팅방이 기존에 있는지 확인해줌
		
		
		
		
		
		
		
		
//		List<LPChatContentDto> lists = new ArrayList<LPChatContentDto>();
//		LPChatContentDto dto1 = new LPChatContentDto(chr_id, sender);
//		LPChatContentDto dto2 = new LPChatContentDto(chr_id, receiver);
//		
//		
//		
//		
//		
//		
//		
//		String chr_id = service.chatRoom_Select(map);
//
//		if (chr_id == null) {
//			int n = service.chatRoom_Insert(map); // 채팅방 생성
//			chr_id = service.chatRoom_Select(map); // 채팅방 아이디 가져오기
//
//			lists.add(dto1);
//			lists.add(dto2);
//			service.chatContent_Insert(lists);
//			System.out.println("● LeeController socketOpen.do / 채팅방 생성(1은 성공) : " + n);
//			session.setAttribute("chr_id", chr_id); // setAttribute 하면 handler에서 이 내용을 가지고 철 가능
//			session.setAttribute("user", sender);
//		} else {
//			int n = service.chatRoom_UpdateOut(chr_id);
//			System.out.println("● LeeController socketOpen.do / 채팅방 보이기(1은 성공) : " + n);
//			session.setAttribute("chr_id", chr_id);
//			session.setAttribute("user", sender);
////			String chr_content = service.chatRoom_SelectContent(chr_id);
////			System.out.println(chr_content);
//			model.addAttribute("msg","<div class = 'sendTxt'><span class ='sender_img'>안녕</span><br><br></div>");
//		}

		/* 채팅 리스트 띄워주기 */
		String mem_id = (String) session.getAttribute("user");
		logger.info("● LeeController socketOpen.do / 유저 닉네임 : " + mem_id);
//		logger.info("● LeeController socketOpen.do / 채팅방 아이디 : " + chr_id);
		HashMap<String, String> chatList = (HashMap<String, String>) servletContext.getAttribute("chatList");
		if (chatList == null) {
			chatList = new HashMap<String, String>();
//			chatList.put(mem_id, chr_id);
			servletContext.setAttribute("chatList", chatList);
		} else {
//			chatList.put(mem_id, chr_id);
			servletContext.setAttribute("chatList", chatList);
		}
		logger.info("socketOpen 소켓 화면 이동 2)리스트 값 전달");

//		System.out.println("● LeeController socketOpen.do / 채팅방이 존재여부(채팅방 아이디): " + chr_id);
		session.setAttribute("user", sender);

		return "/chat/groupChat";
	}

	// WebSocket 채팅 종료했을 때
	@RequestMapping(value = "/socketOut.do", method = { RequestMethod.GET, RequestMethod.POST })
	public void socketOut(HttpSession session, String chc_content) {

		System.out.println("● LeeController socketOut.do DB에 저장할 chc_content : " + chc_content);
		
		Map<String, String> map = new HashMap<String, String>();
		String chr_id = (String)session.getAttribute("chr_id");
		map.put("chr_id", chr_id);
		System.out.println("● LeeController socketOut.do / chr_id : " + chr_id);
		map.put("chr_content", chc_content);
//		int n = service.chatRoom_UpdateContent(map);
//		System.out.println("잘 들어갔나 ? :" + ( n > 0 ? true : false) );
		String mem_id = (String) session.getAttribute("user");
		HashMap<String, String> chatList = (HashMap<String, String>) servletContext.getAttribute("chatList");
		System.out.println("● LeeController socketOut.do / 기존 접속 회원 리스트:" + chatList);
		if (chatList != null) {
			System.out.println("● LeeController socketOut.do / 멤버리스트에서 나간사람 세션 제거 :" + chatList);
			chatList.remove(mem_id);
		}
		System.out.println("● LeeController socketOut.do / 갱신 후 접속 회원 리스트:" + chatList);
		servletContext.setAttribute("chatList", chatList);
	}

	// 채팅 접속자 리스트 출력
	@RequestMapping(value = "/viewChatList.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Map<String, String>> viewChatList() {
		Map<String, Map<String, String>> map = new HashMap<String, Map<String, String>>();
		Map<String, String> chatList = (HashMap<String, String>) servletContext.getAttribute("chatList");
		System.out.println("● LeeController viewChatList.do : " + chatList);
		map.put("list", chatList);

		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/chkChatMember.do", method = RequestMethod.POST)
	public Map<String, String> chkChatMember(String chr_id) {
		String str = service.chkChatMember(chr_id);
//		System.out.println(str+"************************************==");
		Map<String, String> map = new HashMap<String, String>();
		map.put("result", str);
		return map;
	}
	
	@RequestMapping(value="/regiFile.do", method=RequestMethod.POST, produces="application/text; charset-utf-8;")
	@ResponseBody
	public String fileUpload(happy.land.people.dto.FileDto dto,  MultipartHttpServletRequest mtsRequest, String chat_seq) throws IOException {
		logger.info("file Upload Controller");
		boolean isc = false;
		Iterator<String> itr = mtsRequest.getFileNames();
		System.out.println("파일이름 : " + itr);
		String originalName = null;
		while(itr.hasNext()) {
			MultipartFile file = mtsRequest.getFile(itr.next());
			originalName = file.getOriginalFilename();
			String savedName = "";
			System.out.println("Orginal Name : " + originalName);
			// 이름이 겹치지 않기위해 랜덤 생성
			UUID uuid = UUID.randomUUID();
			savedName = uuid.toString()+"_"+originalName;
			File dir = new File(uploadPath);
			File target = new File(uploadPath, savedName);
			// 폴더가 없다면 폴더를 생성
			if(!dir.exists()) {
				dir.mkdirs();
			}
			
			// 파일을 서버에 저장
			FileCopyUtils.copy(file.getBytes(), target);
			
			// argument로 받아온 dto에 파일 이름이 들어가 있지 않아서 직접 set
			dto.setFile_rname(originalName);
			dto.setFile_tname(savedName);
//			isc = service.uploadFile(dto);
			System.out.println("파일업로드 성공 : " + isc);
		}
		return uploadPath + "\\" + originalName;
	}
	
}
