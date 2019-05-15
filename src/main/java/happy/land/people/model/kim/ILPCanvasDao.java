package happy.land.people.model.kim;

import java.util.List;

import happy.land.people.dto.kim.LPCanvasDto;
import happy.land.people.dto.kim.LPDaysDto;

public interface ILPCanvasDao {
	public int canvasCnt(String id);
	
	public List<LPCanvasDto> canvasSelectType(String id);
		
	public int canvasInsert(LPCanvasDto dto);
	
	public String canvasSelectID(LPCanvasDto dto);
	
	public List<LPDaysDto> canvasDownloadExcel(String id);
}
