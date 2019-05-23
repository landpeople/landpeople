package happy.land.people.model.lee;

import java.util.List;
import java.util.Map;

import happy.land.people.dto.ChatContentDto;

public interface ILeeDao {
	
	public List<String> chatList_SelectAll(); //채팅 리스트 테이블의 모든 사용자를 데려옴
	public int chatList_SelectOne(String user_nickname); //채팅 리스트에 추가할지 안할 지 선택하기 위함
	public int chatList_Insert(String user_nickname); // 채팅 가능 리스트 생성
	public int chatList_Delete(String user_nickname); // 채팅 리스트에서 제거
	
	public List<ChatContentDto> chatRoom_Make(Map<String, String> map);
	
	public int chatContent_InsertMsg(ChatContentDto dto);
	
	public String chkChatMember(String chr_id);
}