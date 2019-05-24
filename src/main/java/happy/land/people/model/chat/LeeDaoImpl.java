package happy.land.people.model.chat;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import happy.land.people.dto.ChatContentDto;
import happy.land.people.dto.ChatUserDto;

@Repository
public class LeeDaoImpl implements ILeeDao {
	private Logger logger = LoggerFactory.getLogger(LeeDaoImpl.class);

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<String> chatList_SelectAll() {
		logger.info("● Repository chatList_SelectAll 실행");
		return sqlSession.selectList("lee_test.chatList_SelectAll");
	}

	@Override
	public int chatList_SelectOne(String user_nickname) {
		logger.info("● Repository chatList_SelectOne 실행");
		int result = sqlSession.selectOne("lee_test.chatList_SelectOne", user_nickname);
		return result;
	}

	@Override
	public int chatList_Insert(String user_nickname) {
		logger.info("● Repository chatList_Insert 실행");
		return sqlSession.insert("lee_test.chatList_Insert", user_nickname);
	}

	@Override
	public int chatList_Delete(String user_nickname) {
		// TODO Auto-generated method stub
		return 0;
	}

	/**
	 *  채팅방이 없을 때는 채팅방을 생성하고 있을 때는 out컬럼을 update 하여 볼 수 있게 해주는 메소드
	 */
	@Transactional
	@Override
	public List<ChatContentDto> chatRoom_Make(Map<String, String> map) {
		logger.info("● Service chatRoom_Make 실행");

		logger.info("● Repository chatRoom_Make > chatRoom_Check 실행");
		String chr_id = sqlSession.selectOne("lee_test.chatRoom_Check", map);

		List<ChatContentDto> contentList = new ArrayList<ChatContentDto>();
		
		if (chr_id == null) {			
			logger.info("● Repository chatRoom_Make > chatRoom_Insert 실행");
			int n = sqlSession.insert("lee_test.chatRoom_Insert", map);

			chr_id = map.get("chr_id");
			
			logger.info("● Repository chatRoom_Make > chatRoom_Insert 실행 결과(1 성공) : " + n);
			logger.info("● Repository chatRoom_Make > chatRoom_Insert 실행 후 chr_id : " + map.get("chr_id"));
			
			List<ChatUserDto> lists = new ArrayList<ChatUserDto>();

			// mapper에서 두 번 돌릴 수 있도록 lists에 2개의 dto를 입력하여줌
			ChatUserDto sender = new ChatUserDto(chr_id, map.get("sender"));
			ChatUserDto receiver = new ChatUserDto(chr_id, map.get("receiver"));

			lists.add(sender);
			lists.add(receiver);
			
			logger.info("● Repository chatRoom_Make > chatContent_Insert 실행");
			sqlSession.insert("lee_test.chatContent_Insert", lists);
			
			ChatContentDto dto = new ChatContentDto(chr_id, map.get("sender"), "");
			contentList.add(dto);
			
		} else {
			logger.info("● Repository chatRoom_Make > chatRoom_Show 실행");
			sqlSession.update("lee_test.chatRoom_Show", chr_id);
			
			ChatContentDto dto = new ChatContentDto(chr_id, map.get("sender"));
			
			logger.info("● Repository chatRoom_Make > chatContent_SelectAll 실행");
			contentList = sqlSession.selectList("lee_test.chatContent_SelectAll", dto);
			logger.info("● Repository chatRoom_Make > chatContent_SelectAll 성공");
			
		}
		return contentList;
	}

	@Override
	public int chatContent_InsertMsg(ChatContentDto dto) {
		logger.info("● Repository chatContent_InsertMsg 실행");
		return sqlSession.insert("lee_test.chatContent_InsertMsg", dto);
	}
	
	@Transactional
	@Override
	public String chkChatMember(String chr_id) {
		logger.info("● Repository chkChatMember 실행");
		Map<String, String> map = sqlSession.selectOne("lee_test.chkChatMember", chr_id);

		logger.info("● Repository chkDelflag 실행");
		String str1 = sqlSession.selectOne("lee_test.chkDelflag", map.get("CHR_SENDER"));
		String str2 = sqlSession.selectOne("lee_test.chkDelflag", map.get("CHR_RECEIVER"));

		if (str1.equals("F") && str2.equals("F")) {
			return "canChat";
		} else {
			return "cantChat";
		}
	}
}
