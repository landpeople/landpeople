package happy.land.people.model.lee;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;

import happy.land.people.dto.TestDto;

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
	public String chatRoom_Select(Map<String, String> map) {
		logger.info("● Repository chatList_SelectAll 실행");
		return sqlSession.selectOne("lee_test.chatRoom_Select", map);
	}

	@Override
	public int chatRoom_UpdateOut(String chr_id) {
		logger.info("● Repository chatList_SelectAll 실행");
		return sqlSession.update("lee_test.chatRoom_UpdateOut", chr_id);
	}

	@Override
	public int chatRoom_Insert(Map<String, String> map) {
		logger.info("● Repository chatRoom_Insert 실행");
		return sqlSession.insert("lee_test.chatRoom_Insert", map);
	}
}
