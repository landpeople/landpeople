package happy.land.people.model.jang;

import java.util.List;
import java.util.Map;

import happy.land.people.dto.LPUserDto;

public interface IManagerService {

	public List<Map<String, String>> selectMemberList(LPUserDto dto);

	public Map<String, Integer> selectMemberListCnt(LPUserDto dto);
	
	public List<Map<String, String>> selectSketchList(LPUserDto dto);
	
	public Map<String, Integer> selectSketchListCnt(LPUserDto dto);
	
	public boolean modifyIswrite(String email);
	
	public boolean modifyBlock(String id2);
	
}
