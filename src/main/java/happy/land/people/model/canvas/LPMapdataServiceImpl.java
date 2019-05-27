package happy.land.people.model.canvas;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import happy.land.people.dto.LPMapdataDto;

@Service
public class LPMapdataServiceImpl implements ILPMapdataService{

	@Autowired
	private ILPMapdataDao mapDao;
	
	public LPMapdataServiceImpl() {		
	}
	
	@Override
	public int mapInsert(String[] result) {
		int cnt = 0;
		for(int i = 1; i < result.length; i++) {
			String[] value = result[i].split("/");    	
			LPMapdataDto mapDto = new LPMapdataDto(value[0], value[1], value[2], value[3], value[4]," ");        
			cnt += mapDao.mapInsert(mapDto);
		}
		return cnt;
	}

	@Override
	public List<LPMapdataDto> mapSelectType(String type) {
		// TODO Auto-generated method stub
		return mapDao.mapSelectType(type);
	}

}
