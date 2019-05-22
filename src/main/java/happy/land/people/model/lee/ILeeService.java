package happy.land.people.model.lee;

import java.util.List;

import happy.land.people.dto.ChatUserDto;

public interface ILeeService {
	
	public List<String> chatList_SelectAll();
	public int chatList_SelectOne(String user_nickname);
	public int chatList_Insert(String user_nickname);
	public int chatList_Delete(String user_nickname);
	
	public String chatRoom_Make(List<ChatUserDto> dto);
}
