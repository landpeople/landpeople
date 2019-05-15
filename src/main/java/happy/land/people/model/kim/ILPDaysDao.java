package happy.land.people.model.kim;

import java.util.List;

import happy.land.people.dto.kim.LPDaysDto;

public interface ILPDaysDao {
	public int daysInsert(LPDaysDto dto);
	
	public List<LPDaysDto> daysSelectAll(String cal_id);
}
