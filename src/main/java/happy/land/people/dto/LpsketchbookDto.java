package happy.land.people.dto;

import java.io.Serializable;

public class LpsketchbookDto implements Serializable{

	private static final long serialVersionUID = -385151843111601734L;
	private String sketch_id;
	private String user_email;
	private String sketch_title;
	private String sketch_theme;
	private String sketch_share;
	private String sketch_delflag;
	private String sketch_spath;
	private String sketch_block;
	

	public LpsketchbookDto() {
	}

	
	
	
	public LpsketchbookDto(String user_email, String sketch_title, String sketch_theme) {
		super();
		this.user_email = user_email;
		this.sketch_title = sketch_title;
		this.sketch_theme = sketch_theme;
	}




	public LpsketchbookDto(String sketch_id, String user_email, String sketch_title, String sketch_theme,
			String sketch_share, String sketch_delflag, String sketch_spath, String sketch_block) {
		super();
		this.sketch_id = sketch_id;
		this.user_email = user_email;
		this.sketch_title = sketch_title;
		this.sketch_theme = sketch_theme;
		this.sketch_share = sketch_share;
		this.sketch_delflag = sketch_delflag;
		this.sketch_spath = sketch_spath;
		this.sketch_block = sketch_block;
	}


	public String getSketch_id() {
		return sketch_id;
	}


	public void setSketch_id(String sketch_id) {
		this.sketch_id = sketch_id;
	}


	public String getUser_email() {
		return user_email;
	}


	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}


	public String getSketch_title() {
		return sketch_title;
	}


	public void setSketch_title(String sketch_title) {
		this.sketch_title = sketch_title;
	}


	public String getSketch_theme() {
		return sketch_theme;
	}


	public void setSketch_theme(String sketch_theme) {
		this.sketch_theme = sketch_theme;
	}


	public String getSketch_share() {
		return sketch_share;
	}


	public void setSketch_share(String sketch_share) {
		this.sketch_share = sketch_share;
	}


	public String getSketch_delflag() {
		return sketch_delflag;
	}


	public void setSketch_delflag(String sketch_delflag) {
		this.sketch_delflag = sketch_delflag;
	}


	public String getSketch_spath() {
		return sketch_spath;
	}


	public void setSketch_spath(String sketch_spath) {
		this.sketch_spath = sketch_spath;
	}


	public String getSketch_block() {
		return sketch_block;
	}


	public void setSketch_block(String sketch_block) {
		this.sketch_block = sketch_block;
	}


	@Override
	public String toString() {
		return "LpsketchbookDto [sketch_id=" + sketch_id + ", user_email=" + user_email + ", sketch_title="
				+ sketch_title + ", sketch_theme=" + sketch_theme + ", sketch_share=" + sketch_share
				+ ", sketch_delflag=" + sketch_delflag + ", sketch_spath=" + sketch_spath + ", sketch_block="
				+ sketch_block + "]";
	}
 
	
	
	
	
	
	
}
