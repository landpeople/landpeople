package happy.land.people.model.kim;

import java.util.List;

import happy.land.people.dto.kim.LPCanvasDto;
import happy.land.people.dto.kim.LPTextDto;

public interface ILPTextService {

	//캔버스 작성
	public int canvasInsert(LPCanvasDto canvasDto);
	
	//생성된 캔버스 ID값 찾기
	public String canvasSelectID(LPCanvasDto canvasDto);
		
	//자유 캔버스 작성
	public boolean insertImgFile(LPTextDto conDto);
		
	//자유 캔버스 수정
	public int textUpdate(LPTextDto conDto);
		
	//자유 캔버스 하나의 정보 조회
	public List<LPTextDto> textSelectOne(String can_id);
		
	//자유 캔버스 삭제
	public int textDelete(String can_id);
	
	//자유 캔버스 수정용 insert
	public int textUpdateInsert(LPTextDto conDto);
}
