package happy.land.people.dto;

public class ChatUserDto {
	private String sender;
	private String receiver;

	public ChatUserDto() {
	}

	public ChatUserDto(String sender, String receiver) {
		super();
		this.sender = sender;
		this.receiver = receiver;
	}

	public String getSender() {
		return sender;
	}

	public void setSender(String sender) {
		this.sender = sender;
	}

	public String getReceiver() {
		return receiver;
	}

	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}
}
