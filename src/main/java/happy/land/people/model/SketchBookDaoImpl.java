package happy.land.people.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import happy.land.people.dto.LPSketchbookDto;
import happy.land.people.dto.LPCollectDto;

@Repository
public class SketchBookDaoImpl implements ISketchBookDao {

	private Logger logger = LoggerFactory.getLogger(SketchBookDaoImpl.class);
	private final String NS = "jung_test.";
	
	@Autowired
	private SqlSessionTemplate sqlsession;
	
	
	@Override
	public String sketchSelectWrite(String user_email) {
		System.out.println("스케치북 작성 권한 확인!!!!"+user_email);
		return sqlsession.selectOne(NS+"sketch_WriteChk", user_email);
	}
	
	@Override
	public boolean sketchInsert(LPSketchbookDto dto) {
		System.out.println("스케치북 작성 입력값!!!!"+dto);
		int n = sqlsession.insert(NS+"sketch_Insert", dto);
		System.out.println("스케치북 작성 성공!!!!"+n);
		return n>0?true:false;
	}
	

	@Override
	public boolean collectInsert(LPCollectDto dto) {
		System.out.println("스케치북 스크랩 및 좋아요 최초 등록!!!!"+dto);
		int n = sqlsession.insert(NS+"collect_Insert", dto);
		System.out.println("스케치북 스크랩 및 좋아요 최초 등록!!!!"+n);
		return n>0?true:false;
	}

	@Override
	public String scrapeSelect(Map<String, String> map) {
		System.out.println("스크랩 상태 보기!!!!"+map);
		return sqlsession.selectOne(NS+"scrape_Select", map);
	}
	
	
	@Override
	public boolean scrapeUpdate(Map<String, String> map) {
		//logger.info("msg");
		System.out.println("스크랩 상태 변경값 확인!!!!!"+map);
		int n= sqlsession.update(NS+"scrape_Update", map);
		System.out.println(n);
		return n>0?true:false;
	}

	
	@Override
	public String likeSelect(Map<String, String> map) {
		System.out.println("좋아요 상태 가져오기!!!!!"+map);
		return sqlsession.selectOne(NS+"like_Select", map);
	}
	
	
	
	@Override
	public boolean likeUpdate(Map<String, String> map) {
		//logger.info("msg");
		System.out.println("스케치북 좋아요 상태 변경 값!!!!"+map);
		int n = sqlsession.update(NS+"like_Update", map);
		System.out.println(n);
		return n>0?true:false;
	}

	@Override
	public List<LPSketchbookDto> scrapeSelectMine(Map<String, String> map) {
		System.out.println("내가 스크랩한 스케치북 조회"+map);
		
		return sqlsession.selectList(NS+"scrape_SelectMine", map);
	}
	
	@Override
	public int scrapeCnt(String user_email) {
		System.out.println("스케치북 스크랩 갯수 조회"+user_email);
		return sqlsession.selectOne(NS+"scrape_Cnt"+user_email);
	}
	
	

	@Override
	public int likeCnt(String sketch_id) {
		System.out.println("스케치북 좋아요 갯수 조회"+sketch_id);
		
		return sqlsession.selectOne(NS+"like_Cnt", sketch_id);
	}

	@Override
	public boolean scrapeMutilUpdate(Map<String, String[]> map) {
		System.out.println("스크랩한 스케치북 다중 취소"+map);
		int n = sqlsession.update(NS+"scrape_MutilUpdate", map);
		System.out.println(n+"스크랩 다중 취소 성공");
		return n>0?true:false;
	}

	@Override
	public List<LPSketchbookDto> sketchSelectMine(Map<String, String> map) {
		System.out.println("내가 작성한 스케치북 조회"+map);
		
		return sqlsession.selectList(NS+"sketch_SelectMine", map);
	}

	@Override
	public boolean sketchUpdate(LPSketchbookDto dto) {
		System.out.println("작성 스케치북 정보 수정"+dto);
		int n = sqlsession.update(NS+"sketch_Update",dto);
		System.out.println(n+"작성 스케치북 정보 수정 성공");
		return n>0?true:false;
	}

	

	


	

	


	


	
	
	
}
