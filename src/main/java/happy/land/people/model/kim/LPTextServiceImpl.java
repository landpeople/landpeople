package happy.land.people.model.kim;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import happy.land.people.dto.kim.LPTextDto;

@Service
public class LPTextServiceImpl  implements ILPTextService{
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private ILPTextDao textDao;
		
	@Override
	public boolean insertImgFile(LPTextDto conDto) {
		
		return textDao.insertImgFile(conDto);
	}

	@Override
	public List<LPTextDto> textSelectOne(String can_id) {
		return textDao.textSelectOne(can_id);
	}

}
