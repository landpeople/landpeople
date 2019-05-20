package happy.land.people.model.lee;

import java.util.List;
import java.util.Map;

public interface ILeeDao {
	public List<String> chatList_SelectAll();
	
	// 채팅 가능 리스트 생성
	public int chatList_Insert(String user_nickname);
	
	// 채팅 리스트에서 제거
	public int chatList_Delete(String user_nickname);
	
	// 채팅방 생성
	public String chatRoom_Select(Map<String,String> map);
	public int chatRoom_UpdateOut(String chr_id);
	public int chatRoom_Insert(Map<String,String> map);
	
	// 채팅 메시지 저장
	public int chatRoom_UpdateContent(Map<String, String> map);
	
	// 기존의 채팅방 내역 가져오기
	public String chatRoom_SelectContent(String chr_id);

	
	public String chkChatMember(String chr_id);
}