package happy.land.people.model.kim;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import happy.land.people.dto.kim.LPDaysDto;


@Repository
public class LPDaysDaoImpl implements ILPDaysDao{

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int daysInsert(LPDaysDto dto) {
		// TODO Auto-generated method stub
		return sqlSession.insert("kim_test.days_Insert", dto);
	}

	@Override
	public List<LPDaysDto> daysSelectAll(String cal_id) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("kim_test.days_SelectAll", cal_id);
	}

}
