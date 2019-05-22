package happy.land.people.model.lee;

import java.util.List;
import java.util.Map;

import happy.land.people.dto.LPChatContentDto;

public interface ILeeService {
	public List<String> chatList_SelectAll();
	
	
	public void chatRoom_Make(Map<String,String> map);
	

	//채팅 리스트에 추가할지 안할 지 선택하기 위함
	public int chatList_SelectOne(String user_nickname);
	
	// 세션에 있는 사용자 정보를 채팅 리스트에 입력
	public int chatList_Insert(String user_nickname);
	
	// 채팅방 생성
	public String chatRoom_Select(Map<String,String> map);
	public int chatRoom_UpdateOut(String chr_id);
	public int chatRoom_Insert(Map<String,String> map);
	
	
	public int chatContent_Insert(List<LPChatContentDto> dto);
	
	
	// 채팅 메시지 저장
	public int chatRoom_UpdateContent(Map<String, String> map);
	
	// 기존의 채팅방 내역 가져오기
	public String chatRoom_SelectContent(String chr_id);
	
	public String chkChatMember(String chr_id);
}
