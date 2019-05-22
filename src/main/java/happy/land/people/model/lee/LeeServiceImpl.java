package happy.land.people.model.lee;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import happy.land.people.dto.ChatUserDto;
import happy.land.people.dto.ChatUserNickDto;

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
	public String chatRoom_Make(List<ChatUserDto> dto) {
		logger.info("● Service chatRoom_Make 실행");
		
		String chr_id = dao.chatRoom_Check(dto);
		
		if(chr_id == null) {
			chr_id = dao.chatRoom_Insert(dto);
			
			ChatUserNickDto nDto = new ChatUserNickDto(chr_id, dto.get)
			
		}else {
			
		}
		
//		public int chatRoom_Show(String chr_id);
//		public String chatRoom_Insert(List<ChatUserDto> dto);
//		public int chatContent_Insert(List<ChatUserNickDto> dto);
		return chr_id;
	}

}