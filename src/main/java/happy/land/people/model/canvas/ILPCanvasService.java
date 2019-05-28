package happy.land.people.model.canvas;

import java.util.List;
import java.util.Map;

import happy.land.people.dto.LPCanvasDto;
import happy.land.people.dto.LPDaysDto;

public interface ILPCanvasService {
	public int canvasCnt(String id);
	
	public List<LPCanvasDto> canvasSelectType(String id);
	
	public int canvasInsert(LPCanvasDto dto);
	
	public String canvasSelectID(LPCanvasDto dto);
	
	public List<LPDaysDto> canvasDownloadExcel(String id);
	
	public LPCanvasDto canvasSelectOne(String id);
	
	public int canvasDelete(Map<String,String> map);
}
