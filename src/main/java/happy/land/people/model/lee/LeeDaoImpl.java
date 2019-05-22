package happy.land.people.model.lee;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import happy.land.people.dto.ChatUserDto;
import happy.land.people.dto.ChatUserNickDto;

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
		return sqlSession.selectOne("lee_test.chatList_Insert", user_nickname);
	}

	@Override
	public int chatList_Delete(String user_nickname) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public String chatRoom_Check(List<ChatUserDto> dto) {
		logger.info("● Repository chatRoom_Check 실행");
		return sqlSession.selectOne("lee_test.chatRoom_Check", dto);
	}

	@Override
	public int chatRoom_Show(String chr_id) {
		logger.info("● Repository chatRoom_Show 실행");
		return sqlSession.update("lee_test.chatRoom_Show", chr_id);
	}

	@Override
	public String chatRoom_Insert(List<ChatUserDto> dto) {
		logger.info("● Repository chatRoom_Insert 실행");
		return sqlSession.selectOne("lee_test.chatRoom_Insert", dto);
	}

	@Override
	public int chatContent_Insert(List<ChatUserNickDto> dto) {
		logger.info("● Repository chatContent_Insert 실행");
		return sqlSession.insert("lee_test.chatContent_Insert", dto);
	}



//	@Override
//	public String chkChatMember(String chr_id) {
//		logger.info("● Repository chkChatMember 실행");
//		Map<String, String> map = sqlSession.selectOne("lee_test.chkChatMember", chr_id);
////		System.out.println(map.get("CHR_SENDER"));
////		System.out.println(map.get("CHR_RECEIVER"));
//		
//		logger.info("● Repository chkDelflag 실행");
//		String str1 = sqlSession.selectOne("lee_test.chkDelflag", map.get("CHR_SENDER"));
//		String str2 = sqlSession.selectOne("lee_test.chkDelflag", map.get("CHR_RECEIVER"));
////		System.out.println("str1 = "+str1+"str2 = "+str2+"********************");
//		
//		if (str1.equals("F") && str2.equals("F")) {
//			return "canChat";
//		} else {
//			return "cantChat";
//		}
//	}
//

}
