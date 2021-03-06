package happy.land.people.ctrl;

import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.springframework.beans.factory.annotation.Autowired;

import happy.land.people.dto.LPUserDto;
import happy.land.people.model.chat.IChatService;

public class SessionListener implements HttpSessionListener {
	
	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
	
	@Autowired
	IChatService service;
		
	@Override
	public void sessionCreated(HttpSessionEvent arg0) {
		// 세션 생성시 호출
		HttpSession session = arg0.getSession();
		
		LPUserDto str = (LPUserDto)session.getAttribute("ldto"); // 만료되지 않은 세션
		
		System.out.println("기존 세션: " + str);
		String time = formatter.format(session.getCreationTime());
		String id = session.getId();
		System.out.println(time + " 에 생성된 세션 : " + id);
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent arg0) {
		// 세션 만료시 호출
		HttpSession session = arg0.getSession();
		
		LPUserDto str = (LPUserDto)session.getAttribute("ldto"); // 만료되지 않은 세션
		
		service.chatList_Delete(str);
		
		System.out.println("만료되지 않은 세션 : " + str);
		long last_time = session.getLastAccessedTime();
		long now_time = System.currentTimeMillis();
		String id = session.getId();
		System.out.println(formatter.format(now_time - last_time) + " ms 만에 세션이 죽음 : " + id);
	}
}
