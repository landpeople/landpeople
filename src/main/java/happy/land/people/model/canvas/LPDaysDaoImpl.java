package happy.land.people.model.canvas;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import happy.land.people.dto.LPDaysDto;


@Repository
public class LPDaysDaoImpl implements ILPDaysDao{

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int daysInsert(LPDaysDto dto) {
		// TODO Auto-generated method stub
		return sqlSession.insert("days.days_Insert", dto);
	}

	@Override
	public List<LPDaysDto> daysSelectAll(String cal_id) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("days.days_SelectAll", cal_id);
	}

	@Override
	public LPDaysDto daysSelectOne(String days_id) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("days.days_SelectOne",days_id);
	}

	@Override
	public int daysDelete(String cal_id) {
		// TODO Auto-generated method stub
		return sqlSession.delete("days.days_Delete", cal_id);
	}
	
	@Override
	public List<LPDaysDto> canvasDownloadExcel(String id) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("days.canvas_DownloadExcel", id);
	}


}
