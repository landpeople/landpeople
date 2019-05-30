package happy.land.people.socket;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Map;
import java.util.WeakHashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import happy.land.people.dto.ChatContentDto;
import happy.land.people.model.chat.IChatService;

@Component(value = "wsChat.do")
public class MySocketHandler extends TextWebSocketHandler {

	Logger logger = LoggerFactory.getLogger(MySocketHandler.class);

	private ArrayList<WebSocketSession> list; // webSocket session값을 담은 리스트

	@Autowired
	IChatService service; // 받은 메시지를 바로바로 데이터 베이스에 저장하기 위해 dao 객체를 불러옴

	public MySocketHandler() {
		list = new ArrayList<WebSocketSession>();
	}

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		logger.info("● MySocketHandler afterConnectionEstablished() 실행");
		super.afterConnectionEstablished(session);
		
		 /* 전체 접속자 리스트에 새로운 접속자 추가 */
		list.add(session);
		/*  현 세션에 들어온 사용자의 수 */
		System.out.println("● MySocketHandler afterConnectionEstablished / client session cnt : " + list.size());
		/*  지금 들어온 세션의 고유 아이디  */
		System.out.println("● MySocketHandler afterConnectionEstablished / session connected : " + session.getId());
	}

	@Override
	public void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		logger.info("● MySocketHandler handleTextMessage() 실행");
		String msg = message.getPayload();
		String txt = "";

		/* WebsocketSession의 session값을 httpSesssion값으로 변경 */
		Map<String, Object> mySession = session.getHandshakeAttributes(); 
		String myGrSession = (String) mySession.get("chr_id"); // 접속자의 채팅방 아이디
		String myMemSession = (String) mySession.get("user"); // 접속자 아이디
		String test = (String) mySession.get("test");
		System.err.println("● MySocketHandler 접속자 my chr_id : " + myGrSession);
		System.err.println("● MySocketHandler 접속자 my user : " + myMemSession);
		System.err.println(test);

		if (msg != null && !msg.equals("")) { // 메시지가 null이 아닐 때 처리,
			if (msg.indexOf("#$nick_") > -1) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 HH시 mm분");
				String now = sdf.format(new Date());
				for (WebSocketSession s : list) {
					Map<String, Object> sessionMap = s.getHandshakeAttributes();
					String otherGrSession = (String) sessionMap.get("chr_id"); // 같은 그룹끼리 묶어 주는 거 같은데??
					String otherMemSession = (String) sessionMap.get("user");

					System.out.println("● MySocketHandler 접속자 other chr_id : " + myGrSession);
					System.out.println("● MySocketHandler 접속자 other nickname : " + otherMemSession);

					txt = "<div class = 'noticeTxt'><font color='red' size='1px'>" + myMemSession + " 님이 입장했습니다 (" + now + ")</font><br/></br></div>";
					if (myGrSession.equals(otherGrSession)) { // 같은 그룹 소속일 때 대화가 가능하도록 처리
						System.out.println("● MySocketHandler handleTextMessage() 접속 했을 때 메시지 처리 :" + txt);
						ChatContentDto dto = new ChatContentDto(otherGrSession, otherMemSession, txt);
//						int n = service.chatContent_InsertMsg(dto);
						s.sendMessage(new TextMessage(txt));
					}
				}
			} else if (msg.indexOf(myMemSession) == 0) {
				String msg2 = msg.substring(0, msg.indexOf(":")).trim(); // 소켓이 열린 상태에서 메시지 주고받을 수 있도록
				for (WebSocketSession s : list) {
					Map<String, Object> sessionMap = s.getHandshakeAttributes();
					String otherGrSession = (String) sessionMap.get("chr_id");
					String otherMemSession = (String) sessionMap.get("user");
					if (myGrSession.equals(otherGrSession)) {
						if (msg2.equals(myMemSession)) { // 나의 메시지
							String newMsg = "<div class = 'sendTxt'><span class ='sender_msg'>[" + otherMemSession + "]" + msg.replace(msg.substring(0, msg.trim().indexOf(":") + 1), "") + "</span></div><br><br>";
							System.out.println("● MySocketHandler handleTextMessage() newMsg :" + newMsg);

//							"<div class = 'sendTxt'><span class ='sender_msg'>"+msg + "</span></div><br><br>"
							txt = newMsg;
						} else { // 상대가 메시지 보냈을 때,
							String part1 = msg.substring(0, msg.trim().indexOf(":")).trim();
							String part2 = "<div class = 'receiveTxt'><span class = 'receiver_msg'>[" + part1 + "]" + msg.substring(msg.trim().indexOf(":") + 1) + "</span></div><br><br>";
							System.out.println("● MySocketHandler handleTextMessage() part2 :" + part2);

//							"<div class = 'receiveTxt'><span class = 'receiver_msg'>" + msg + "</span></div><br><br>"
							txt = part2;
						}

						System.out.println("● MySocketHandler handleTextMessage() > service.chatConttent_InsertMsg text :" + txt);
						ChatContentDto dto = new ChatContentDto(otherGrSession, otherMemSession, txt);
						int n = service.chatContent_InsertMsg(dto);
						s.sendMessage(new TextMessage(txt));
					}
				}
			} else {
				System.out.println("● MySocketHandler handleTextMessage() > 파일 handle 실행");
				String msg2 = msg.substring(msg.indexOf(":") + 1, msg.indexOf(">")).trim(); // 파일까지 자르고
				String location = msg.substring(msg.indexOf("/chatThumbnail") + 1).trim(); // 파일까지 자르고
				System.out.println("★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ 파일이군.. 파일이다...msg2 : " + msg2);
				System.out.println("★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ ★ 파일이군.. 파일이다...location : " + location);
				for (WebSocketSession s : list) {
					Map<String, Object> sessionMap = s.getHandshakeAttributes();
					String otherGrSession = (String) sessionMap.get("chr_id");
					String otherMemSession = (String) sessionMap.get("user");
					if (myGrSession.equals(otherGrSession)) {
						if (msg2.equals(myMemSession)) { // 나의 메시지
							String newMsg = "<div class = 'sendTxt' class ='contain_img'><img class = 'sender_img'"
											+ " src='./" + location
											+ "'></div></div><br><br>";
							System.out.println("● MySocketHandler handleTextMessage() newMsg :" + newMsg);
							txt = newMsg;
						} else { // 상대가 메시지 보냈을 때,
							String part1 = msg.substring(0, msg.trim().indexOf(":")).trim();

							String part2 = "<div class = 'receiveTxt' class ='contain_img'><img class = 'receiver_img'"
											+ " src='./" + location
											+ "'/></div><br><br>";
							System.out.println("● MySocketHandler handleTextMessage() part2 :" + part2);
							txt = part2;
						}
						System.out.println("● MySocketHandler handleTextMessage() > service.chatConttent_InsertMsg text :" + txt);
						ChatContentDto dto = new ChatContentDto(otherGrSession, otherMemSession, txt);
						int n = service.chatContent_InsertMsg(dto);
						s.sendMessage(new TextMessage(txt));
					}
				}

			}
		}
	}

//	@Override
//	protected void handleBinaryMessage(WebSocketSession session, BinaryMessage message) {

//	Map<WebSocketSession, FileUploadInFlight> sessionToFileMap = new WeakHashMap<WebSocketSession, FileUploadInFlight>();

//		logger.info("● MySocketHandler handleBinaryMessage() 실행");
//
//		ByteBuffer payload = message.getPayload();
//		FileUploadInFlight inflightUpload = sessionToFileMap.get(session);
//		if (inflightUpload == null) {
//			throw new IllegalStateException("This is not expected");
//		}
//		try {
//			inflightUpload.append(payload);
//
//			if (message.isLast()) {
//				Path basePath = Paths.get(".", "uploads", UUID.randomUUID().toString());
//				Files.createDirectories(basePath);
//				FileChannel channel = new FileOutputStream(Paths.get(basePath.toString(), inflightUpload.name).toFile(),
//						false).getChannel();
//				channel.write(ByteBuffer.wrap(inflightUpload.bos.toByteArray()));
//				channel.close();
//				session.sendMessage(new TextMessage("upload " + inflightUpload.name));
//				session.close();
//				sessionToFileMap.remove(session);
//			}
//
//		} catch (IOException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//
//		String response = "Upload Chunk: size " + payload.array().length;
//		System.out.println(response);
//
//	}
//
//	static class FileUploadInFlight {
//		String name;
//		String uniqueUploadId;
//		ByteArrayOutputStream bos = new ByteArrayOutputStream();
//
//		/**
//		 * Fragile constructor - beware not prod ready
//		 * 
//		 * @param session
//		 */
//		FileUploadInFlight(WebSocketSession session) {
//			String query = session.getUri().getQuery();
//			String uploadSessionIdBase64 = query.split("=")[1];
//			String uploadSessionId = new String(Base64Utils.decodeUrlSafe(uploadSessionIdBase64.getBytes()));
//			System.out.println(uploadSessionId);
//			List<String> sessionIdentifiers = Splitter.on("\\").splitToList(uploadSessionId);
//			String uniqueUploadId = session.getRemoteAddress().toString() + sessionIdentifiers.get(0);
//			String fileName = sessionIdentifiers.get(1);
//			this.name = fileName;
//			this.uniqueUploadId = uniqueUploadId;
//		}
//
//		public void append(ByteBuffer byteBuffer) throws IOException {
//			bos.write(byteBuffer.array());
//		}
//	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		logger.info("● MySocketHandler afterConnectionClosed() 실행");

		super.afterConnectionClosed(session, status);
		Map<String, Object> mySession = session.getHandshakeAttributes();
		String myGrSession = (String) mySession.get("chr_id");
		String myMemSession = (String) mySession.get("user");
		String receiver = (String) mySession.get("receiver");
		System.out.println("● MySocketHandler afterConnectionClosed() / receiver :" + receiver);

		System.out.println("● MySocketHandler afterConnectionClosed() / myGrSession 채팅 종료 : " + myGrSession);
		System.out.println("● MySocketHandler afterConnectionClosed() / myMemSession 채팅 종료 : " + myMemSession);

		list.remove(session);

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 HH시 mm분");
		String now = sdf.format(new Date());
		for (WebSocketSession a : list) {
			Map<String, Object> sessionMap = a.getHandshakeAttributes();
			String otherGrSession = (String) sessionMap.get("chr_id");

			String txt = "<div class = 'noticeTxt'><font color='blue' size='1px'>" + myMemSession + "님이 퇴장했습니다 (" + now + ")</font><br/></br></div>";
			System.out.println("● MySocketHandler handleTextMessage() > service.chatContent_InsertMsg text :" + txt);
			ChatContentDto dto = new ChatContentDto(otherGrSession, receiver, txt); // 일단 마이 세션에 넣어주는데 상대방 창에 나와야함.
			if (myGrSession.equals(otherGrSession)) {
				int n = service.chatContent_InsertMsg(dto);
				a.sendMessage(new TextMessage(txt));
			}
		}
	}
}