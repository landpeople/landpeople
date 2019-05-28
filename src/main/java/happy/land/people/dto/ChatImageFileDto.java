package happy.land.people.dto;

import java.io.Serializable;

public class ChatImageFileDto implements Serializable {

	/**
	 * 채팅 이미지 저장에 사용되는 DTO
	 */
	private String chi_id;
	private String chr_id;
	private String chi_rpath;
	private String chi_spath;
	private String file_size;
	
	public ChatImageFileDto() {
	}
	
	public String getChi_id() {
		return chi_id;
	}
	public void setChi_id(String chi_id) {
		this.chi_id = chi_id;
	}
	public String getChr_id() {
		return chr_id;
	}
	public void setChr_id(String chr_id) {
		this.chr_id = chr_id;
	}
	public String getChi_rpath() {
		return chi_rpath;
	}
	public void setChi_rpath(String chi_rpath) {
		this.chi_rpath = chi_rpath;
	}
	public String getChi_spath() {
		return chi_spath;
	}
	public void setChi_spath(String chi_spath) {
		this.chi_spath = chi_spath;
	}
	public String getFile_size() {
		return file_size;
	}
	public void setFile_size(String file_size) {
		this.file_size = file_size;
	}
	
}
