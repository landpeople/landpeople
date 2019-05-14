package happy.land.people.model;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class SketchBookDaoImpl implements ISketchBookDao {

	private Logger logger = LoggerFactory.getLogger(SketchBookDaoImpl.class);
	private final String NS = "jung_test.";
	
	@Autowired
	private SqlSessionTemplate sqlsession;
	
	@Override
	public boolean scrapeCancel(Map<String, String> map) {
		//logger.info("msg");
		int n= sqlsession.update(NS+"scrape_Update", map);
		
		return n>0?true:false;
	}

	@Override
	public boolean likeCancel(Map<String, String> map) {
		//logger.info("msg");
		System.out.println("값이 잘 들어왔나요?"+map);
		int n = sqlsession.update(NS+"like_Update", map);
		System.out.println(n);
		return n>0?true:false;
	}

	@Override
	public String selLike(Map<String, String> map) {
		
		
		System.out.println("좋아요 상태 가져와~~"+map);
		return sqlsession.selectOne(NS+"like_Select", map);
	}

	
	
	
}
