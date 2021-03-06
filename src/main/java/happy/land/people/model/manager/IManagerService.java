package happy.land.people.model.manager;

import java.util.List;
import java.util.Map;

import happy.land.people.dto.LPSketchbookDto;
import happy.land.people.dto.LPUserDto;

public interface IManagerService {

	public List<Map<String, String>> selectMemberList(LPUserDto dto);

	public Map<String, Integer> selectMemberListCnt(LPUserDto dto);
	
	public List<Map<String, String>> selectSketchList(LPSketchbookDto lsDto);
	
	public Map<String, Integer> selectSketchListCnt(LPSketchbookDto lsDto);
	
	public boolean modifyIswrite(String email);
	
	public boolean modifyBlock(String id);
	
	public Map<String, String> detailChatroom(String chrId);
}
