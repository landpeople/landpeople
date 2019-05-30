package happy.land.people.model.sketch;

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
	public boolean scrapeUpdateMulti(Map<String, String[]> map) {
		logger.info("service scrapeUpdateMulti 스크랩한 스케치북 다중 취소 실행 {}", map);
		return iSketchBookDao.scrapeUpdateMulti(map);
	}

	@Override
	public List<LPSketchbookDto> sketchSelectMine(Map<String, String> map) {
		logger.info("service sketchSelectMine 페이징 처리된 작성한 스케치북 조회 실행 {}", map);
		return iSketchBookDao.sketchSelectMine(map);
	}

	@Override
	public int sketchCntMine(String user_email) {
		logger.info("service sketchCntMine 페이지 처리를 위한 작성 스케치북 카운트 조회 {}", user_email);
		return iSketchBookDao.sketchCntMine(user_email);
	}
	
	
	
	@Override
	public LPSketchbookDto sketchSelectOne(LPSketchbookDto dto) {
		logger.info("service sketchSelectOne 작성 스케치북 상세 조회 실행 {}", dto);
		return iSketchBookDao.sketchSelectOne(dto);
	}
	
	
	@Override
	public boolean sketchUpdate(LPSketchbookDto dto) {
		logger.info("service sketchUpdate 작성한 스케치북 정보 수정 실행 {}", dto);
		return iSketchBookDao.sketchUpdate(dto);
	}

	@Override
	public boolean sketchRealDeleteMulti(Map<String, String[]> map) {
		logger.info("service sketchRealDeleteMulti 작성한 스케치북 완전 다중 삭제 실행 {}", map);
		return iSketchBookDao.sketchRealDeleteMulti(map);
	}
	
	
	@Override
	public List<LPSketchbookDto> sketchSelectTheme(Map<String, String> map) {
		logger.info("service sketchSelectTheme 페이지 처리된 스케치북 테마별 조회 실행 {}", map);
		return iSketchBookDao.sketchSelectTheme(map);
	}

	
	@Override
	public List<LPSketchbookDto> sketchSelectMaxLike(String type) {
		logger.info("service sketchSelectMaxLike 좋아요 카운팅이 가장 높은 스케치북 3개 조회 실행 {}", type);
		return iSketchBookDao.sketchSelectMaxLike(type);
	}
	
	
	@Override
	public int sketchCntTheme(String theme) {
		logger.info("service sketchCntTheme 페이징 처리를 위한 스케치북 카운트 조회 {}", theme);
		return iSketchBookDao.sketchCntTheme(theme);
	}

	@Override
	public String selectNickname(String sketch_id) {
		logger.info("service selectNickname 스케치북 작성자 닉네임 조회 {}", sketch_id);
		return iSketchBookDao.selectNickname(sketch_id);
	}



	
	

	

	

	

	



	

}
