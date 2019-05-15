package happy.land.people.model.kim;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import happy.land.people.dto.kim.LPDaysDto;

@Service
public class LPDaysServiceImpl implements ILPDaysService{

	@Autowired
	private LPDaysDaoImpl daysDao;
	
	@Override
	public int daysInsert(LPDaysDto dto) {
		// TODO Auto-generated method stub
		return daysDao.daysInsert(dto);
	}

	@Override
	public List<LPDaysDto> daysSelectAll(String cal_id) {
		// TODO Auto-generated method stub
		return daysDao.daysSelectAll(cal_id);
	}

}
