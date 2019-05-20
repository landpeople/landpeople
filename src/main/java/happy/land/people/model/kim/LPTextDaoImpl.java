package happy.land.people.model.kim;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import happy.land.people.dto.kim.LPTextDto;

@Repository
public class LPTextDaoImpl implements ILPTextDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public boolean insertImgFile(LPTextDto conDto) {
		int cnt = 0;
		cnt = sqlSession.insert("na_test.text_Insert", conDto);
		return cnt>0?true:false;
	}

	@Override
	public List<LPTextDto> textSelectOne(String can_id) {
		List<LPTextDto> cList = null;
		cList = sqlSession.selectList("na_test.text_SelectOne", can_id);
		return cList;
	}	
}
