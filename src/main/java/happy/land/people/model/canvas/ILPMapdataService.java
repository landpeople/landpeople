package happy.land.people.model.canvas;

import java.util.List;

import happy.land.people.dto.LPMapdataDto;

public interface ILPMapdataService {
	public int mapInsert(String[] result);
	public List<LPMapdataDto> mapSelectType(String type);
}
