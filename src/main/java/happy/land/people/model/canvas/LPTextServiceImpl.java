package happy.land.people.model.canvas;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import happy.land.people.dto.LPCanvasDto;
import happy.land.people.dto.LPTextDto;

@Service
public class LPTextServiceImpl  implements ILPTextService{


	@Autowired
	private ILPTextDao textDao;

	//자유 캔버스 작성
	@Override
	public boolean insertImgFile(LPTextDto conDto) {

		return textDao.insertImgFile(conDto);
	}

	//자유 캔버스 하나의 정보 조회
	@Override
	public List<LPTextDto> textSelectOne(String can_id) {
		return textDao.textSelectOne(can_id);
	}

	//캔버스 작성
	@Override
	public int canvasInsert(LPCanvasDto canvasDto) {
		return textDao.canvasInsert(canvasDto);
	}

	//생성된 캔버스 ID값 찾기
	@Override
	public String canvasSelectID(LPCanvasDto canvasDto) {
		return textDao.canvasSelectID(canvasDto);
	}

	//자유 캔버스 수정
	@Override
	public int textUpdate(LPTextDto conDto) {
		return textDao.textUpdate(conDto);
	}

	//자유 캔버스 삭제
	@Override
	public int textDelete(String can_id) {
		return textDao.textDelete(can_id);
	}
}



