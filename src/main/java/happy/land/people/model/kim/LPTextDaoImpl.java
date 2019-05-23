package happy.land.people.model.kim;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import happy.land.people.dto.kim.LPCanvasDto;
import happy.land.people.dto.kim.LPTextDto;

@Repository
public class LPTextDaoImpl implements ILPTextDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	//자유 캔버스 작성
	@Override
	public boolean insertImgFile(LPTextDto conDto) {
		int cnt = 0;
		cnt = sqlSession.insert("na_test.text_Insert", conDto);
		return cnt>0?true:false;
	}

	//자유 캔버스 하나의 정보 조회
	@Override
	public List<LPTextDto> textSelectOne(String can_id) {
		List<LPTextDto> cList = null;
		cList = sqlSession.selectList("na_test.text_SelectOne", can_id);
		return cList;
	}	
	
	//캔버스 작성
	@Override
	public int canvasInsert(LPCanvasDto canvasDto) {
		return sqlSession.insert("na_test.canvas_Insert", canvasDto);
	}

	//생성된 캔버스 ID값 찾기
	@Override
	public String canvasSelectID(LPCanvasDto canvasDto) {
		return sqlSession.selectOne("na_test.canvas_SelectID", canvasDto);
	}

	//자유 캔버스 수정
	@Override
	public int textUpdate(LPTextDto conDto) {
		return sqlSession.update("na_test.text_Update", conDto);
	}

	//자유 캔버스 삭제
	@Override
	public int textDelete(String can_id) {
		return sqlSession.delete("na_test.free_Delete", can_id);
	}
	
	//자유 캔버스 수정용 insert
	@Override
	public int textUpdateInsert(LPTextDto conDto) {
		return sqlSession.insert("na_test.text_UpdateInsert", conDto);
	}
}
