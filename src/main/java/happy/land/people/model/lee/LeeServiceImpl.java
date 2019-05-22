package happy.land.people.model.lee;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import happy.land.people.dto.LPChatContentDto;

@Service
public class LeeServiceImpl implements ILeeService {

	private Logger logger = LoggerFactory.getLogger(LeeServiceImpl.class);

	@Autowired
	private ILeeDao dao;
	

	@Override
	public void chatRoom_Make(Map<String, String> map) {
		String chr_id = dao.chatRoom_Select(map);
		
		if(chr_id == null) {
			chr_id = dao.chatRoom_Insert(map.get()); // 채팅방 생성

		}else {
			int n = dao.chatRoom_UpdateOut(chr_id);
		}
		
		
		
		
	}

	
	
	
	@Override
	public int chatList_Insert(String user_nickname) {
		logger.info("● Service chatList_Insert 실행");
		return dao.chatList_Insert(user_nickname);
	}

	@Override
	public int chatList_SelectOne(String user_nickname) {
		logger.info("● Service chatList_SelectOne 실행");
		return dao.chatList_SelectOne(user_nickname);
	}
	
	@Override
	public List<String> chatList_SelectAll() {
		logger.info("● Service chatList_SelectAll 실행");
		return dao.chatList_SelectAll();
	}

	@Override
	public String chatRoom_Select(Map<String, String> map) {
		logger.info("● Service chatRoom_Select 실행");
		return dao.chatRoom_Select(map);
	}

	
	public int chatContent_Insert(List<LPChatContentDto> dto) {
		logger.info("● Service chatContent_Insert 실행");
		return dao.chatContent_Insert(dto);
	}
	
	
	
	@Override
	public int chatRoom_UpdateOut(String chr_id) {
		logger.info("● Service chatRoom_UpdateOut 실행");
		return dao.chatRoom_UpdateOut(chr_id);
	}

	@Override
	public int chatRoom_Insert(Map<String, String> map) {
		logger.info("● Service chatRoom_Insert 실행");
		return dao.chatRoom_Insert(map);
	}

	@Override
	public String chkChatMember(String chr_id) {
		logger.info("● Service chkChatMember 실행");
		return dao.chkChatMember(chr_id);
	}

	@Override
	public int chatRoom_UpdateContent(Map<String, String> map) {
		logger.info("● Service chatRoom_UpdateContent 실행");
		return dao.chatRoom_UpdateContent(map);
	}

	@Override
	public String chatRoom_SelectContent(String chr_id) {
		logger.info("● Service chatRoom_SelectContent 실행");
		return dao.chatRoom_SelectContent(chr_id);
	}
}