package happy.land.people.dto;

import java.io.Serializable;
import java.util.List;

public class LPTextDto implements Serializable{
	private static final long serialVersionUID = 3168732159439235266L;
	
	private String text_id      ;
	private String can_id       ;
	private String text_content ;
	private int text_no         ;	
	private String img_spath    ;
	private List<LPTextDto> list;

	public LPTextDto() {
	
	}

	public LPTextDto(String text_id, String can_id, String text_content, int text_no,
			String img_spath, List<LPTextDto> list) {
		super();
		this.text_id = text_id;
		this.can_id = can_id;
		this.text_content = text_content;
		this.text_no = text_no;
		
		this.img_spath = img_spath;
		this.list = list;
	}



	public List<LPTextDto> getList() {
		return list;
	}
	
	public void setList(List<LPTextDto> list) {
		this.list = list;
	}
	
	public String getText_id() {
		return text_id;
	}

	public void setText_id(String text_id) {
		this.text_id = text_id;
	}

	public String getCan_id() {
		return can_id;
	}

	public void setCan_id(String can_id) {
		this.can_id = can_id;
	}

	public String getText_content() {
		return text_content;
	}

	public void setText_content(String text_content) {
		this.text_content = text_content;
	}

	public int getText_no() {
		return text_no;
	}

	public void setText_no(int text_no) {
		this.text_no = text_no;
	}

	public String getImg_spath() {
		return img_spath;
	}

	public void setImg_spath(String img_spath) {
		this.img_spath = img_spath;
	}
	
	

	@Override
	public String toString() {
		return "Content_DTO [text_id=" + text_id + ", can_id=" + can_id + ", text_content=" + text_content
				+ ", text_no=" + text_no + ", img_spath=" + img_spath + "]";
	}
	
	
}
