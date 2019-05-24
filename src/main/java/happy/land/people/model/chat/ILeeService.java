package happy.land.people.model.chat;

import java.util.List;
import java.util.Map;

import happy.land.people.dto.ChatContentDto;

public interface ILeeService {
	public List<String> chatList_SelectAll();
	public int chatList_SelectOne(String user_nickname);
	public int chatList_Insert(String user_nickname);
	public int chatList_Delete(String user_nickname);
	
	public List<ChatContentDto> chatRoom_Make(Map<String, String> map);
	
	public int chatContent_InsertMsg(ChatContentDto dto);
	
	public String chkChatMember(String chr_id);
}
