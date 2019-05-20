package happy.land.people.model;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import happy.land.people.dto.LPSketchbookDto;
import happy.land.people.dto.LPCollectDto;

@Service
public class SketchBookServiceImpl implements ISketchBookService {

	private Logger logger = LoggerFactory.getLogger(SketchBookServiceImpl.class);
	
	@Autowired
	private ISketchBookDao iSketchBookDao;
	
	
	@Override
	public String sketchSelectWrite(String user_email) {
		logger.info("service sketchSelectWrite 스케치북 작성 권한 확인 {}", user_email);
		return iSketchBookDao.sketchSelectWrite(user_email);
	}
	
	@Override
	public boolean sketchInsert(LPSketchbookDto dto) {
		logger.info("service sketchInsert 스케치북 생성 실행 {}", dto);
		return iSketchBookDao.sketchInsert(dto);
	}
	
	
	@Override
	public boolean collectInsert(LPCollectDto dto) {
		logger.info("service collectInsert 스크랩 및 좋아요 최초등록 실행 {}", dto);
		return iSketchBookDao.collectInsert(dto);
	}
	
	@Override
	public String scrapeSelect(Map<String, String> map) {
		logger.info("service scrapeSelect 좋아요 현재상태 가져오기 {}", map);
		return iSketchBookDao.scrapeSelect(map);
		
	}
	
	@Override
	public boolean scrapeUpdate(Map<String, String> map) {
		// TODO Auto-generated method stub
		logger.info("service scrapeUpdate 스크랩 상태 변경 실행 {}", map);
		return iSketchBookDao.scrapeUpdate(map);
	}

	@Override
	public boolean likeUpdate(Map<String, String> map) {
		// TODO Auto-generated method stub
		logger.info("service likeUpdate 좋아요 상태 변경 실행 {}", map);
		return iSketchBookDao.likeUpdate(map);
	}

	@Override
	public String likeSelect(Map<String, String> map) {
		
		logger.info("service likeSelect 좋아요 상태 가져오기 실행 {}", map);
		return iSketchBookDao.likeSelect(map);
	}

	@Override
	public List<LPSketchbookDto> scrapeSelectMine(Map<String, String> map) {
		logger.info("service scrapeSelectMine 스크랩한 스케치북 조회 실행 {}", map);
		return iSketchBookDao.scrapeSelectMine(map);
	}

	@Override
	public int scrapeCnt(String user_email) {
		logger.info("service scrapeCnt 스크랩한 스케치북 갯수 조회 실행 {}", user_email);
		return iSketchBookDao.scrapeCnt(user_email);
	}

	
	
	
	@Override
	public int likeCnt(String sketch_id) {
		logger.info("service likeCnt 스케치북 좋아요 갯수 조회 실행 {}", sketch_id);
		
		return iSketchBookDao.likeCnt(sketch_id);
	}

	@Override
	public boolean scrapeMutilUpdate(Map<String, String[]> map) {
		logger.info("service scrapeMutilUpdate 스크랩한 스케치북 다중 취소 실행 {}", map);
		return iSketchBookDao.scrapeMutilUpdate(map);
	}

	@Override
	public List<LPSketchbookDto> sketchSelectMine(Map<String, String> map) {
		logger.info("service sketchSelectMine 작성한 스케치북 조회 실행 {}", map);
		return iSketchBookDao.sketchSelectMine(map);
	}

	@Override
	public boolean sketchUpdate(LPSketchbookDto dto) {
		logger.info("service sketchUpdate 작성한 스케치북 정보 수정 실행 {}", dto);
		return iSketchBookDao.sketchUpdate(dto);
	}

	

	

	



	

}
