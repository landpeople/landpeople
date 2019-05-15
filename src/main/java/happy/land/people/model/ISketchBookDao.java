package happy.land.people.model;

import java.util.Map;

import happy.land.people.dto.LpcollectDto;

public interface ISketchBookDao {

	public boolean collectInsert(LpcollectDto dto);
	public String selScrape(Map<String, String> map);
	public boolean scrapeChange(Map<String, String>map);
	public boolean likeCancel(Map<String, String>map);
	public String selLike(Map<String, String> map);
	
}
