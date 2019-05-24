package happy.land.people.model.lee;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import happy.land.people.dto.ChatContentDto;

@Service
public class LeeServiceImpl implements ILeeService {

	private Logger logger = LoggerFactory.getLogger(LeeServiceImpl.class);

	@Autowired
	private ILeeDao dao;
	
	@Override
	public List<String> chatList_SelectAll() {
		logger.info("● Service chatList_SelectAll 실행");
		return dao.chatList_SelectAll();
	}
	
	@Override
	public int chatList_SelectOne(String user_nickname) {
		logger.info("● Service chatList_SelectOne 실행");
		return dao.chatList_SelectOne(user_nickname);
	}
	
	@Override
	public int chatList_Insert(String user_nickname) {
		logger.info("● Service chatList_Insert 실행");
		return dao.chatList_Insert(user_nickname);
	}

	@Override
	public int chatList_Delete(String user_nickname) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<ChatContentDto> chatRoom_Make(Map<String, String> map) {
		logger.info("● Service chatRoom_Make 실행");
		return dao.chatRoom_Make(map);
	}
	
	@Override
	public String chkChatMember(String chr_id) {
		logger.info("● Service chkChatMember 실행");
		return dao.chkChatMember(chr_id);
	}

	@Override
	public int chatContent_InsertMsg(ChatContentDto dto) {
		logger.info("● Service chatContent_InsertMsg 실행");
		return dao.chatContent_InsertMsg(dto);
	}
}