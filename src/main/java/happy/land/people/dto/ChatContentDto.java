package happy.land.people.dto;

public class ChatContentDto {

	private String chc_id;
	private String chr_id;
	private String user_nickname;
	private String chc_message;
	private String chc_out;
	private String regdate;

	public ChatContentDto() {
	}

	public ChatContentDto(String chr_id, String user_nickname) {
		super();
		this.chr_id = chr_id;
		this.user_nickname = user_nickname;
	}
	
	public ChatContentDto(String chr_id, String user_nickname, String chc_message) {
		super();
		this.chr_id = chr_id;
		this.user_nickname = user_nickname;
		this.chc_message = chc_message;
	}

	public String getChc_id() {
		return chc_id;
	}

	public void setChc_id(String chc_id) {
		this.chc_id = chc_id;
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

	public String getChc_message() {
		return chc_message;
	}

	public void setChc_message(String chc_message) {
		this.chc_message = chc_message;
	}

	public String getChc_out() {
		return chc_out;
	}

	public void setChc_out(String chc_out) {
		this.chc_out = chc_out;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
}
