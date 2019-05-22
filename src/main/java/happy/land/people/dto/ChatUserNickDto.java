package happy.land.people.dto;

public class ChatUserNickDto {

	private String chr_id;
	private String user_nickname;

	public ChatUserNickDto() {
	}

	public ChatUserNickDto(String chr_id, String user_nickname) {
		super();
		this.chr_id = chr_id;
		this.user_nickname = user_nickname;
	}

	public String getChr_id() {
		return chr_id;
	}

	public void setChr_id(String chr_id) {
		this.chr_id = chr_id;
	}

	public String getUser_nickname() {
		return user_nickname;
	}

	public void setUser_nickname(String user_nickname) {
		this.user_nickname = user_nickname;
	}
}
