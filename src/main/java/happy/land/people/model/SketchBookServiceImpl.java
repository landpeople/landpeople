package happy.land.people.model;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SketchBookServiceImpl implements ISketchBookService {

	private Logger logger = LoggerFactory.getLogger(SketchBookServiceImpl.class);
	
	@Autowired
	private ISketchBookDao iSketchBookDao;
	
	
	@Override
	public boolean scrapeCancel(Map<String, String> map) {
		// TODO Auto-generated method stub
		logger.info("service scrapeCancel 실행");
		return iSketchBookDao.scrapeCancel(map);
	}

	@Override
	public boolean likeCancel(Map<String, String> map) {
		// TODO Auto-generated method stub
		logger.info("service likeCancel 실행");
		return iSketchBookDao.likeCancel(map);
	}

	@Override
	public String selLike(Map<String, String> map) {
		
		logger.info("service likeCancel 실행");
		return iSketchBookDao.selLike(map);
	}

}
