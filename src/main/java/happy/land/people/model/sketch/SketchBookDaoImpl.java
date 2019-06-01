package happy.land.people.model.sketch;

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
	private final String NS = "sketch.";
	
	@Autowired
	private SqlSessionTemplate sqlsession;
	
	
	@Override
	public String sketchSelectWrite(String user_email) {
		System.out.println("스케치북 작성 권한 확인!!!!"+user_email);
		return sqlsession.selectOne(NS+"sketch_WriteChk", user_email);
	}
	
	@Override
	public boolean sketchInsert(LPSketchbookDto dto) {
		logger.info("sketchInsert 스케치북 생성 입력 값 확인 {}", dto);
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
		return sqlsession.selectOne(NS+"scrape_Cnt", user_email);
	}
	
	

	@Override
	public int likeCnt(String sketch_id) {
		System.out.println("스케치북 좋아요 갯수 조회"+sketch_id);
		
		return sqlsession.selectOne(NS+"like_Cnt", sketch_id);
	}

	@Override
	public boolean scrapeUpdateMulti(Map<String, String[]> map) {
		System.out.println("스크랩한 스케치북 다중 취소"+map);
		int n = sqlsession.update(NS+"scrape_UpdateMulti", map);
		System.out.println(n+"스크랩 다중 취소 성공");
		return n>0?true:false;
	}

	@Override
	public List<LPSketchbookDto> sketchSelectMine(Map<String, String> map) {
		System.out.println("페이징 처리된 내가 작성한 스케치북 조회"+map);
		
		return sqlsession.selectList(NS+"sketch_SelectMine", map);
	}

	
	
	
	
	@Override
	public int sketchCntMine(String user_email) {
		System.out.println("페이지 처리를 위한 작성한 스케치북 카운팅"+user_email);
		
		return sqlsession.selectOne(NS+"sketch_CntMine", user_email);
	}
	
	
	@Override
	public LPSketchbookDto sketchSelectOne(LPSketchbookDto dto) {
		System.out.println("작성 스케치북 수정을 위한 스케치북 상세조회"+dto);
		
		return sqlsession.selectOne(NS+"sketch_SelectOne", dto);
	}
	
	
	@Override
	public boolean sketchUpdate(LPSketchbookDto dto) {
		System.out.println("작성 스케치북 정보 수정"+dto);
		int n = sqlsession.update(NS+"sketch_Update",dto);
		System.out.println(n+"작성 스케치북 정보 수정 성공");
		return n>0?true:false;
	}

	@Override
	public boolean sketchRealDeleteMulti(Map<String, String[]> map) {
		System.out.println("작성 스케치북 완전 다중 삭제"+map);
		int n = sqlsession.delete(NS+"sketch_RealDeleteMulti", map);
		System.out.println(n+"작성 스케치북 완전 다중 삭제 성공");
		return n>0?true:false;
	}
	
	
	
	
	
	@Override
	public List<LPSketchbookDto> sketchSelectTheme(Map<String, String> map) {
		System.out.println("페이지 처리된 테마별 스케치북 조회"+map);
		return sqlsession.selectList(NS+"sketch_SelectTheme", map);
	}


	@Override
	public List<LPSketchbookDto> sketchSelectMaxLike(String type) {
		System.out.println("좋아요 카운팅이 가장 높은 스케치북 3개 조회"+type);
		return sqlsession.selectList(NS+"sketch_SelectMaxLike", type);
	}
	

	@Override
	public int sketchCntTheme(String theme) {
		System.out.println("페이징 처리를 위한 스케치북 카운트 조회"+"="+theme);
		return sqlsession.selectOne(NS+"sketch_CntTheme", theme);
		
	}

	@Override
	public String nicknameSelect(String sketch_id) {
		System.out.println("스케치북 작성자 닉네임 조회 = "+sketch_id);
		return sqlsession.selectOne(NS+"nickname_Select", sketch_id);
	}

	



	

	

	


	

	


	


	
	
	
}
