package happy.land.people.model;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import happy.land.people.dto.LpcollectDto;

@Service
public class SketchBookServiceImpl implements ISketchBookService {

	private Logger logger = LoggerFactory.getLogger(SketchBookServiceImpl.class);
	
	@Autowired
	private ISketchBookDao iSketchBookDao;
	
	
	@Override
	public boolean collectInsert(LpcollectDto dto) {
		logger.info("service collectInsert 좋아요 최초등록 실행");
		return iSketchBookDao.collectInsert(dto);
	}
	
	@Override
	public String selScrape(Map<String, String> map) {
		logger.info("service selScrape 좋아요 현재상태 가져오기");
		return iSketchBookDao.selScrape(map);
		
	}
	
	@Override
	public boolean scrapeChange(Map<String, String> map) {
		// TODO Auto-generated method stub
		logger.info("service scrapeChange 실행");
		return iSketchBookDao.scrapeChange(map);
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
