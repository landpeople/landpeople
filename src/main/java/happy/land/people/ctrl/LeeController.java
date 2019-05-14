package happy.land.people.ctrl;

import java.util.HashMap;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ServletConfigAware;

import happy.land.people.model.lee.ILeeService;

@Controller
public class LeeController implements ServletConfigAware {

	@Autowired
	ILeeService service;
	
	/**
	 * 채팅에 관련된 정보를 담기 위해 Application 객체 생성
	 */
	private ServletContext servletContext;
	// 8. log처리를 위한 logger객체 생성
	Logger logger = LoggerFactory.getLogger(LeeController.class);

	public String createUUID() {
		return UUID.randomUUID().toString();
	}

	@Override
	public void setServletConfig(ServletConfig servletConfig) {
		servletContext = servletConfig.getServletContext();
	}

	// WebSocket 채팅 접속했을 때
	@RequestMapping(value = "/socketOpen.do", method = RequestMethod.GET)
	public String socketOpen(HttpSession session, Model model, String mem, String user) {

		System.out.println("● LeeController String 현 세션의 사용자 닉네임 user: " + user);
		
		// 여기서 테이블의 다오를 통해서 나랑 상대방의 채팅방이 기존에 있는지 확인해줌
		logger.info("socketOpen 소켓 화면 이동 1) 리스트에 접속자 값 넣기");
		
//		session.setAttribute("mem_id", mem);
//		session.setAttribute("gr_id", gr);
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("user", user);
		map.put("mem_id", mem);
		
		String chr_id = service.chatRoom_Select(map);

		System.out.println("채팅방이 존재하나요? " + chr_id);
		
		HashMap<String, String> chatList = (HashMap<String, String>) servletContext.getAttribute("chatList");// 전해준 attrbute가 없어. 그냥  null임
		System.out.println(chatList);
		if(chr_id == null) {
			int n = service.chatRoom_Insert(map);
			System.out.println("채팅방을 만들었다!" + n);
			chr_id = service.chatRoom_Select(map);
			chatList = new HashMap<String, String>();
			chatList.put(user, chr_id);	
			servletContext.setAttribute("chatList", chatList);
		}else {
			int n = service.chatRoom_UpdateOut(chr_id);
			System.out.println("채팅방을 보이게 했다!" + n);
			chatList = new HashMap<String, String>();
			chatList.put(user, chr_id);
			servletContext.setAttribute("chatList", chatList);
		}
		

//		String mem_id = (String) session.getAttribute("mem_id");
//		String gr_id = (String) session.getAttribute("gr_id");
//		logger.info(mem_id + "::" + gr_id);
//		HashMap<String, String> chatList = (HashMap<String, String>) servletContext.getAttribute("chatList");// 전해준 attrbute가 없어. 그냥  null임
//		System.out.println("chatList가 널인지 아닌지 확인하자" + chatList); // 그냥 때려박은건지 확인
//		if (chatList == null) {
//			chatList = new HashMap<String, String>();
//			chatList.put(mem_id, gr_id);
//			servletContext.setAttribute("chatList", chatList);
//		} else {
//			chatList.put(mem_id, gr_id);
//			servletContext.setAttribute("chatList", chatList);
//		}
		logger.info("socketOpen 소켓 화면 이동 2)리스트 값 전달");

		return "/chat/groupChat";
	}

	// WebSocket 채팅 종료했을 때
	@RequestMapping(value = "/socketOut.do", method = { RequestMethod.GET, RequestMethod.POST })
	public void socketOut(HttpSession session) {
		logger.info("socketOut 소켓에서 나오기");
		String mem_id = (String) session.getAttribute("mem_id");
		HashMap<String, String> chatList = (HashMap<String, String>) servletContext.getAttribute("chatList");
		System.out.println("기존 접속 회원 리스트:" + chatList);
		if (chatList != null) {
			chatList.remove(mem_id);
		}
		System.out.println("갱신 후 접속 회원 리스트:" + chatList);
		servletContext.setAttribute("chatList", chatList);

	}

	// 채팅 접속자 리스트 출력
	@RequestMapping(value = "/viewChatList.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Map<String, String>> viewChatList() {
		Map<String, Map<String, String>> map = new HashMap<String, Map<String, String>>();
		Map<String, String> chatList = (HashMap<String, String>) servletContext.getAttribute("chatList");
		System.out.println("채팅 접속자 리스트아다아아아아아ㅏㅇ아:" + chatList);
		map.put("list", chatList);
		return map;
	}
	
	// 채팅 접속자 리스트 출력
	@RequestMapping(value = "/chatList.do", method = RequestMethod.GET)
	public String chatList(Model model) {
		List<String> nicknames = service.chatList_SelectAll();
		System.out.println("● 접속 회원 리스트 : " + nicknames);
		model.addAttribute("nicknames", nicknames);
		return "/chat/chatList";
	}
}
