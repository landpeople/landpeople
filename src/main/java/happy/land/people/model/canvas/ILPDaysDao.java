package happy.land.people.model.canvas;

import java.util.List;

import happy.land.people.dto.LPDaysDto;

public interface ILPDaysDao {
	public int daysInsert(LPDaysDto dto);
	
	public List<LPDaysDto> daysSelectAll(String cal_id);
	
	public LPDaysDto daysSelectOne(String days_id);
	
	public int daysDelete(String cal_id);
	
	public List<LPDaysDto> canvasDownloadExcel(String id);
}
