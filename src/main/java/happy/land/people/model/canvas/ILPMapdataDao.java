package happy.land.people.model.canvas;

import java.util.List;

import happy.land.people.dto.LPMapdataDto;

public interface ILPMapdataDao {
	public int mapInsert(LPMapdataDto dto);
	public List<LPMapdataDto> mapSelectType(String type);
}
