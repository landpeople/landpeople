package happy.land.people.model.jang;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import happy.land.people.dto.LPUserDto;

public class ManagerDaoImpl implements IManagerDao {

	private Logger logger = LoggerFactory.getLogger(ManagerDaoImpl.class);
	private final String NS = "jang_test.";
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<Map<String, String>> selectMemberList(LPUserDto dto) {
		return sqlSession.selectList(NS+"selectMemberList", dto);
	}

	@Override
	public Map<String, Integer> selectMemberListCnt(LPUserDto dto) {
		return sqlSession.selectOne(NS+"selectMemberListCnt", dto);
	}

	@Override
	public List<Map<String, String>> selectSketchList(LPUserDto dto) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, Integer> selectSketchListCnt(LPUserDto dto) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean modifyIswrite(String email) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean modifyBlock(String id2) {
		// TODO Auto-generated method stub
		return false;
	}

}
