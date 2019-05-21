package happy.land.people.model.lee;

import java.util.List;
import java.util.Map;

public interface ILeeDao {
	
	//채팅 리스트 테이블의 모든 사용자를 데려옴
	public List<String> chatList_SelectAll();
	
	
	//채팅 리스트에 추가할지 안할 지 선택하기 위함
	public int chatList_SelectOne(String user_nickname);
	// 채팅 가능 리스트 생성
	public int chatList_Insert(String user_nickname);
	// 채팅 리스트에서 제거
	public int chatList_Delete(String user_nickname);
	
	/** 채팅방 생성 */
	// 1. 기존에 상대방과 채팅방이 있는지 확인
	public String chatRoom_Select(Map<String,String> map);
	
	// 2.1 만약에 기존에 만들었던 채팅방이 있다면 나의 채팅 목록에서 보이게 만들어줌
	public int chatRoom_UpdateOut(String chr_id);
	
	// 2.2 기존에 채팅방이 없다면 -> 채팅 리스트에 추가 
	public int chatRoom_Insert(Map<String,String> map);
	/** 채팅방 생성 */
	
	
	// 채팅 메시지 저장
	public int chatRoom_UpdateContent(Map<String, String> map);
	
	// 기존의 채팅방 내역 가져오기
	public String chatRoom_SelectContent(String chr_id);

	
	public String chkChatMember(String chr_id);
}