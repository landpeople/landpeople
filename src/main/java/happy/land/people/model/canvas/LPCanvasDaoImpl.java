package happy.land.people.model.canvas;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import happy.land.people.dto.LPCanvasDto;
import happy.land.people.dto.LPDaysDto;

@Repository
public class LPCanvasDaoImpl implements ILPCanvasDao{

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int canvasCnt(String id) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("canvas.canvas_Cnt", id);
	}

	@Override
	public List<LPCanvasDto> canvasSelectType(String id) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("canvas.canvas_SelectType", id);
	}	

	@Override	
	public int canvasInsert(LPCanvasDto dto) {
		// TODO Auto-generated method stub		
		return sqlSession.insert("canvas.canvas_Insert", dto);
	}
	
	@Override
	public int canvasIncreasePage(Map<String,String> map)
	{
		return sqlSession.update("canvas.canvas_IncreasePage", map);
	}

	@Override
	public String canvasSelectID(LPCanvasDto dto) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("canvas.canvas_SelectID", dto);
	}


	@Override
	public LPCanvasDto canvasSelectOne(String id) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("canvas.canvas_SelectOne", id);
	}

	@Override
	public int canvasDelete(String can_id) {
		// TODO Auto-generated method stub		
		return sqlSession.delete("canvas.canvas_Delete", can_id);
	}
	
	@Override
	public int canvasDecreasePage(Map<String,String> map) 
	{
		return sqlSession.update("canvas.canvas_DecreasePage", map);
	}
	
	@Override
	public int canvasUpdate(Map<String,String> map)
	{		 
		return sqlSession.update("canvas.canvas_Update", map);
	}
	
}
