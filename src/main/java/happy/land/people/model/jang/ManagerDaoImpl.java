package happy.land.people.model.jang;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Repository;

import happy.land.people.dto.LPSketchbookDto;
import happy.land.people.dto.LPUserDto;

@Repository
public class ManagerDaoImpl implements IManagerDao {

	private Logger logger = LoggerFactory.getLogger(ManagerDaoImpl.class);
	private final String NS = "jang_test.";
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	// 회원 목록 조회
	@Override
	public List<Map<String, String>> selectMemberList(LPUserDto dto) {
		return sqlSession.selectList(NS+"selectMemberList", dto);
	}

	// 회원 목록 개수
	@Override
	public Map<String, Integer> selectMemberListCnt(LPUserDto dto) {
		return sqlSession.selectOne(NS+"selectMemberListCnt", dto);
	}

	@Override
	public List<Map<String, String>> selectSketchList(LPSketchbookDto lsDto) {
		return sqlSession.selectList(NS+"selectSketchList", lsDto);
	}

	@Override
	public Map<String, Integer> selectSketchListCnt(LPSketchbookDto lsDto) {
		return sqlSession.selectOne(NS+"selectSketchListCnt", lsDto);
	}

	// 회원 작성권한 수정
	@Override
	public boolean modifyIswrite(String email) {
		String str = sqlSession.selectOne(NS+"selectIswrite", email);
		logger.info("회원 작성권한 수정 50%! modifyIswrite {}", str);
		Map<String, String> map = new HashMap<String, String>();
		map.put("Iswrite", str);
		map.put("email", email);
		
		int n = sqlSession.update(NS+"modifyIswrite", map);
		logger.info("회원 작성권한 수정 완료! modifyIswrite {}", n);
		return n>0 ? true:false;
	}

	// 스케치북 공개/비공개 수정
	@Override
	public boolean modifyBlock(String id) {
		String str = sqlSession.selectOne(NS+"selectBlock", id);
		logger.info("스케치북 공개/비공개 수정 50%! modifyIswrite {}", str);
		Map<String, String> map = new HashMap<String, String>();
		map.put("block", str);
		map.put("id", id);
		
		int n = sqlSession.update(NS+"modifyBlock", map);
		logger.info("스케치북 공개/비공개 수정 완료! modifyIswrite {}", n);
		return n>0 ? true:false;
	}
	
	@Override
	public List<List<Map<String, String>>> selectChr(String id) {
		logger.info("ManagerDaoImpl selectChr");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<List<Map<String, String>>> resultLists = new ArrayList<List<Map<String, String>>>();
		List<Map<String, String>> lists = sqlSession.selectList(NS+"selectChr", id);
		System.out.println("*********lists = "+lists);
			for (int i = 0; i < lists.size(); i++) {
				if (lists.get(i).get("CHR_SENDER").equals(id)) { // SENDER가 나인 방의 채팅 상대, 최근 메시지, 날짜 조회
					Map<String, String> map = new HashMap<String, String>();
					map.put("id", id);
					map.put("chr_id", lists.get(i).get("CHR_ID"));
					resultMap.put("result"+i, sqlSession.selectList(NS+"selectChrListR", map));
					resultLists.add(sqlSession.selectList(NS+"selectChrListR", map));
//					System.out.println(resultMap+"**********"+i);
				} 
				else if(lists.get(i).get("CHR_RECEIVER").equals(id)) { // RECEIVER가 나인 방의 채팅 상대, 최근 메시지, 날짜 조회
					Map<String, String> map = new HashMap<String, String>();
					map.put("id", id);
					map.put("chr_id", lists.get(i).get("CHR_ID"));
					resultMap.put("result"+i, sqlSession.selectList(NS+"selectChrListS", map));
					resultLists.add(sqlSession.selectList(NS+"selectChrListS", map));
//					System.out.println(resultMap+"**********"+i);
				}
			}
//			resultLists.add(resultMap);
			System.out.println(resultLists.get(0).get(0).get("CHR_RECEIVER"));
			System.out.println(resultLists);
			return resultLists;
	}

	@Override
	public boolean deleteChatroom(String chrId, String id) {
		// 선택된 채팅방의 SENDER를 조회
		logger.info("ManagerDaoImpl selectSender 20%");
		String sender = sqlSession.selectOne(NS+"selectSender", chrId);
		
		// SENDER랑 내 아이디랑 같으면 SOUT을 T로 변경 아니면 ROUT을 T로 변경
		logger.info("ManagerDaoImpl modifyChrout 40%");
		Map<String, String> mapModify = new HashMap<String, String>();
		mapModify.put("sender", sender);
		mapModify.put("nickname", id);
		mapModify.put("chrId", chrId);
		sqlSession.update(NS+"modifyChrout", mapModify);
		
		// 나간 사람의 채팅들 CHC_OUT을 T로 변경
		logger.info("ManagerDaoImpl modifyChcout 60%");
		sqlSession.update(NS+"modifyChcout", mapModify);
		
		// 선택된 채팅방의 SOUT, ROUT을 조회
		logger.info("ManagerDaoImpl selectChrout 80%");
		List<Map<String, String>> listSelect = sqlSession.selectList(NS+"selectChrout", chrId);
		
		int n = 0;
		// 선택된 채팅방의 SOUT, ROUT이 둘 다 T면 해당 채팅방을 삭제
		if (listSelect.get(0).get("CHR_ROUT").equals("T") && listSelect.get(0).get("CHR_SOUT").equals("T")) { // SOUT, ROUT이 둘 다 T면 실행
			logger.info("ManagerDaoImpl deleteChatroom 100%");
			n = sqlSession.delete(NS+"deleteChatroom", chrId);
		}
		System.out.println(n>0 ? "채팅방이 삭제되었습니다.":"삭제할 채팅방이 없습니다.");
		return false;
	}
	
	

}
