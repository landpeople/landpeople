package happy.land.people.model.lee;

import java.util.List;

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
}
