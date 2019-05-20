package happy.land.people.model;

import java.util.List;
import java.util.Map;

import happy.land.people.dto.LPSketchbookDto;
import happy.land.people.dto.LPCollectDto;

public interface ISketchBookService {
	
	// 스케치북 작성권한 확인
	public String sketchSelectWrite(String user_email);
	
	// 스케치북 생성 
	public boolean sketchInsert(LPSketchbookDto dto);
	
	// 스크랩 및 스크랩 최초 등록
	public boolean collectInsert(LPCollectDto dto);
	
	// 스케치북 스크랩 상태 확인
	public String scrapeSelect(Map<String, String> map);
	
	// 스케치북 스크랩 상태 변경(등록, 취소)
	public boolean scrapeUpdate(Map<String, String> map);

	// 스케치북 좋아요 상태 가져오기
	public String likeSelect(Map<String, String> map);
	
	// 스케치북 좋아요 상태 변경(등록, 취소)
	public boolean likeUpdate(Map<String, String> map);

	// 스크랩한 스케치북 조회(사용자- 마이페이지)
	public List<LPSketchbookDto> scrapeSelectMine(Map<String, String> map);

	// 스크랩한 스케치북 개수 조회
	public int scrapeCnt(String user_email);
	
	// 스케치북 좋아요 개수 조회
	public int likeCnt(String sketch_id);
	
	// 스크랩한 스케치북 다중 취소
	public boolean scrapeMutilUpdate(Map<String, String[]> map);
	
	// 자신이 작성한 스케치북 조회 (사용자- 마이페이지)
	public List<LPSketchbookDto> sketchSelectMine(Map<String, String> map);

	// 작성 스케치북 정보 수정
	public boolean sketchUpdate(LPSketchbookDto dto);

}
