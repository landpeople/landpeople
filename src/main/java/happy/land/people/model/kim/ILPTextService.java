package happy.land.people.model.kim;

import java.util.List;

import happy.land.people.dto.kim.LPTextDto;

public interface ILPTextService {

	//쿼리 문서 반영 안함
		public boolean insertImgFile(LPTextDto conDto);
		
		//쿼리 문서 반영
		public List<LPTextDto> textSelectOne(String can_id);
}
