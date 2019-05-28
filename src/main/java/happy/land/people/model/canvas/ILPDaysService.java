package happy.land.people.model.canvas;

import java.text.ParseException;
import java.util.List;
import java.util.Map;

import happy.land.people.dto.LPCanvasDto;
import happy.land.people.dto.LPDaysDto;

public interface ILPDaysService {
	public int daysInsert(Map<String,Object> val,LPCanvasDto canvasDto) throws ParseException;
	
	public List<LPDaysDto> daysSelectAll(String cal_id);
	
	public LPDaysDto daysSelectOne(String days_id);
	
	public int daysDelete(String cal_id);
	
	public int daysUpdate(Map<String,Object> val,String can_id) throws ParseException;	
}
