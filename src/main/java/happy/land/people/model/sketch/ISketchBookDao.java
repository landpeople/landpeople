package happy.land.people.model.sketch;

import java.util.List;
import java.util.Map;

import happy.land.people.dto.LPSketchbookDto;
import happy.land.people.dto.LPCollectDto;


public interface ISketchBookDao {
	
	// 스케치북 작성권한 확인
	public String sketchSelectWrite(String user_email);
	
	// 스케치북 생성 
	public boolean sketchInsert(LPSketchbookDto dto);
	
	// 스크랩 및 좋아요  최초 등록
	public boolean collectInsert(LPCollectDto dto);
	
	// 스케치북 스크랩 상태 확인
	public String scrapeSelect(Map<String, String> map);
	
	// 스케치북 스크랩 상태 변경(등록, 취소)
	public boolean scrapeUpdate(Map<String, String>map);
	
	// 스케치북 좋아요 상태 가져오기
	public String likeSelect(Map<String, String> map);
	
	// 스케치북 좋아요 상태 변경(등록, 취소)
	public boolean likeUpdate(Map<String, String>map);
	
	// 스크랩한 스케치북 조회(사용자- 마이페이지)
	public List<LPSketchbookDto> scrapeSelectMine(Map<String, String> map);
	
	// 스크랩한 스케치북 개수 조회
	public int scrapeCnt(String user_email);
	
	// 스케치북 좋아요 개수 조회
	public int likeCnt(String sketch_id);
	
	// 스크랩한 스케치북 다중 취소
	public boolean scrapeUpdateMulti(Map<String, String[]> map);
	
	// 페이징 처리된 자신이 작성한 스케치북 조회 (사용자- 마이페이지)
	public List<LPSketchbookDto> sketchSelectMine(Map<String, String> map);
	
	// 페이징 처리를 위한 자신이 작성한 스케치북 카운트 조회
	public int sketchCntMine(String user_email);
	
	// 작성 스케치북 상세조회(사용자- 마이페이지 정보 수정을 위한 상세 조회)
	public LPSketchbookDto sketchSelectOne(LPSketchbookDto dto);
	
	// 작성 스케치북 정보 수정
	public boolean sketchUpdate(LPSketchbookDto dto);
	
	// 작성 스케치북 완전 다중 삭제
	public boolean sketchRealDeleteMulti(Map<String, String[]> map);
	
	// 페이징 처리된 테마별 스케치북 조회
	public List<LPSketchbookDto> sketchSelectTheme(Map<String,String> map);
	
	// 좋아요 카운팅이 가장 높은 3개 순으로  페이징 처리된 테마별 스케치북 조회 
	public List<LPSketchbookDto> sketchSelectLikeTheme(Map<String, String> map);
	
	// 페이징 처리를 위한 스케치북 카운트 조회
	public int sketchCntTheme(String theme);

	// 스케치북 작성자 닉네임 조회
	public String selectNickname(String sketch_id);
	
}
