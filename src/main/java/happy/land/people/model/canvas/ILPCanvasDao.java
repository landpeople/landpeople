package happy.land.people.model.canvas;

import java.util.List;
import java.util.Map;

import happy.land.people.dto.LPCanvasDto;
import happy.land.people.dto.LPDaysDto;

public interface ILPCanvasDao {
	public int canvasCnt(String id);	
	
	public List<LPCanvasDto> canvasSelectType(String id);
		
	public int canvasInsert(LPCanvasDto dto);
	
	public int canvasIncreasePage(Map<String,String> map);
	
	public int canvasDecreasePage(Map<String,String> map);
	
	public String canvasSelectID(LPCanvasDto dto);	
	
	public LPCanvasDto canvasSelectOne(String id);
	
	public int canvasDelete(String can_id);	
	
	public int canvasUpdate(Map<String,String> map);
}
