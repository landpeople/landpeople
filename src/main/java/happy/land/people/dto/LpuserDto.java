package happy.land.people.dto;

import java.io.Serializable;

public class LpuserDto implements Serializable{

	
	private static final long serialVersionUID = 3539391373232103351L;
	private String user_email;
	private String user_password;
	private String user_nickname;
	private String user_auth;
	private String user_delflag;
	private String user_iswrite;
	
	public LpuserDto() {
	}

	public LpuserDto(String user_iswrite) {
		this.user_iswrite = user_iswrite;
	}

	public String getUser_email() {
		return user_email;
	}

	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}

	public String getUser_password() {
		return user_password;
	}

	public void setUser_password(String user_password) {
		this.user_password = user_password;
	}

	public String getUser_nickname() {
		return user_nickname;
	}

	public void setUser_nickname(String user_nickname) {
		this.user_nickname = user_nickname;
	}

	public String getUser_auth() {
		return user_auth;
	}

	public void setUser_auth(String user_auth) {
		this.user_auth = user_auth;
	}

	public String getUser_delflag() {
		return user_delflag;
	}

	public void setUser_delflag(String user_delflag) {
		this.user_delflag = user_delflag;
	}

	public String getUser_iswrite() {
		return user_iswrite;
	}

	public void setUser_iswrite(String user_iswrite) {
		this.user_iswrite = user_iswrite;
	}

	@Override
	public String toString() {
		return "LpuserDto [user_email=" + user_email + ", user_password=" + user_password + ", user_nickname="
				+ user_nickname + ", user_auth=" + user_auth + ", user_delflag=" + user_delflag + ", user_iswrite="
				+ user_iswrite + "]";
	}

	
	
	
}
