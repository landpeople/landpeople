package happy.land.people.model;

import java.util.Map;

public interface ISketchBookService {

	public boolean scrapeCancel(Map<String, String> map);
	public boolean likeCancel(Map<String, String> map);
	public String selLike(Map<String, String> map);
}
