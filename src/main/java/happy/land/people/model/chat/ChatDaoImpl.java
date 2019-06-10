package happy.land.people.model.chat;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import happy.land.people.dto.ChatContentDto;
import happy.land.people.dto.ChatUserDto;
import happy.land.people.dto.LPUserDto;

@Repository
public class ChatDaoImpl implements IChatDao {
	private Logger logger = LoggerFactory.getLogger(ChatDaoImpl.class);

	@Autowired
	private SqlSessionTemplate sqlSession;
	private HttpSession session;
	private final String NS = "chat.";

	@Override
	public List<String> chatList_SelectAll() {
		logger.info("● Repository chatList_SelectAll 실행");
		return sqlSession.selectList(NS + "chatList_SelectAll");
	}

	@Override
	public int chatList_SelectOne(String user_nickname) {
		logger.info("● Repository chatList_SelectOne 실행");
		int result = sqlSession.selectOne(NS + "chatList_SelectOne", user_nickname);
		return result;
	}

	@Override
	public int chatList_Insert(String user_nickname) {
		logger.info("● Repository chatList_Insert 실행");
		return sqlSession.insert(NS + "chatList_Insert", user_nickname);
	}

	@Override
	public int chatList_Delete(String user_nickname) {
		// TODO Auto-generated method stub
		return 0;
	}

	/**
	 * 채팅방이 없을 때는 채팅방을 생성하고 있을 때는 out컬럼을 update 하여 볼 수 있게 해주는 메소드
	 */
	@Transactional
	@Override
	public List<ChatContentDto> chatRoom_Make(Map<String, String> map) {
		logger.info("● Service chatRoom_Make 실행");

		logger.info("● Repository chatRoom_Make > chatRoom_Check 실행");
		String chr_id = sqlSession.selectOne(NS + "chatRoom_Check", map);

		List<ChatContentDto> contentList = new ArrayList<ChatContentDto>();

		if (chr_id == null) {
			logger.info("● Repository chatRoom_Make > chatRoom_Insert 실행");
			int n = sqlSession.insert(NS + "chatRoom_Insert", map);

			chr_id = map.get("chr_id");

			logger.info("● Repository chatRoom_Make > chatRoom_Insert 실행 결과(1 성공) : " + n);
			logger.info("● Repository chatRoom_Make > chatRoom_Insert 실행 후 chr_id : " + map.get("chr_id"));

			List<ChatUserDto> lists = new ArrayList<ChatUserDto>();

			// mapper에서 두 번 돌릴 수 있도록 lists에 2개의 dto를 입력하여줌
			ChatUserDto sender = new ChatUserDto(chr_id, map.get("sender"));
			ChatUserDto receiver = new ChatUserDto(chr_id, map.get("receiver"));

			lists.add(sender);
			lists.add(receiver);

			logger.info("● Repository chatRoom_Make > chatContent_Insert 실행");
			sqlSession.insert(NS + "chatContent_Insert", lists);

			ChatContentDto dto = new ChatContentDto(chr_id, map.get("sender"), "");
			contentList.add(dto);

		} else {
			logger.info("● Repository chatRoom_Make > chatRoom_Show 실행");
			sqlSession.update(NS + "chatRoom_Show", chr_id);

			ChatContentDto dto = new ChatContentDto(chr_id, map.get("sender"));

			logger.info("● Repository chatRoom_Make > chatContent_SelectAll 실행");
			contentList = sqlSession.selectList(NS + "chatContent_SelectAll", dto);
			logger.info("● Repository chatRoom_Make > chatContent_SelectAll 성공");

		}
		return contentList;
	}

	@Override
	public int chatContent_InsertMsg(ChatContentDto dto) {
		logger.info("● Repository chatContent_InsertMsg 실행");
		return sqlSession.insert(NS + "chatContent_InsertMsg", dto);
	}

	@Transactional
	@Override
	public String chkChatMember(String chr_id) {
		logger.info("● Repository chkChatMember 실행");
		Map<String, String> map = sqlSession.selectOne(NS + "chkChatMember", chr_id);

		logger.info("● Repository chkDelflag 실행");
		String str1 = sqlSession.selectOne(NS + "chkDelflag", map.get("CHR_SENDER"));
		String str2 = sqlSession.selectOne(NS + "chkDelflag", map.get("CHR_RECEIVER"));

		if (str1.equals("F") && str2.equals("F")) {
			return "canChat";
		} else {
			return "cantChat";
		}
	}
	
	@Override
	public List<List<Map<String, String>>> selectChr(LPUserDto dto, String id) {
		logger.info("● Repository selectChr");
		List<List<Map<String, String>>> resultLists = new ArrayList<List<Map<String, String>>>();
		List<Map<String, String>> lists = sqlSession.selectList(NS+"selectChr", id);
			for (int i = 0; i < lists.size(); i++) {
				if (lists.get(i).get("CHR_SENDER").equals(id)) { // SENDER가 나인 방의 채팅 상대, 최근 메시지, 날짜 조회
					logger.info("● Repository selectChrListR");
					Map<String, String> map = new HashMap<String, String>();
					map.put("id", id);
					map.put("chr_id", lists.get(i).get("CHR_ID"));
					map.put("rows", dto.getRows());
					map.put("input", dto.getInput());
					map.put("page", dto.getPage());
					resultLists.add(sqlSession.selectList(NS+"selectChrListR", map));
				} 
				else if(lists.get(i).get("CHR_RECEIVER").equals(id)) { // RECEIVER가 나인 방의 채팅 상대, 최근 메시지, 날짜 조회
					logger.info("● Repository selectChrListS");
					Map<String, String> map = new HashMap<String, String>();
					map.put("id", id);
					map.put("chr_id", lists.get(i).get("CHR_ID"));
					map.put("rows", dto.getRows());
					map.put("input", dto.getInput());
					map.put("page", dto.getPage());
					resultLists.add(sqlSession.selectList(NS+"selectChrListS", map));
				}
			}
			// resultLists에 값이 없는 빈 방을 삭제 함
			for (int i = 0; i < resultLists.size(); i++) {
//				System.out.println(i+" : "+resultLists.get(i)+" == "+resultLists.get(i).isEmpty());
				if (resultLists.get(i).isEmpty()) {
					resultLists.remove(i);
					i--;
				}
			}
			
			// CHC_CONTENT의 태그들을 지워주고 내용만 잘라 줌 
			for (int i = 0; i < resultLists.size(); i++) {
				logger.info("● Repository CHC_CONTENT.substring");
				if(resultLists.get(i).get(0).get("CHC_MESSAGE") != null && resultLists.get(i).get(0).get("CHC_MESSAGE").contains("sender_msg")) {
					System.out.println("****** "+i+" 메시지 일 때");
					int start = resultLists.get(i).get(0).get("CHC_MESSAGE").indexOf("]")+1;
					int last = resultLists.get(i).get(0).get("CHC_MESSAGE").lastIndexOf("</span>");
					resultLists.get(i).get(0).replace("CHC_MESSAGE", resultLists.get(i).get(0).get("CHC_MESSAGE").substring(start, last));
				}else if (resultLists.get(i).get(0).get("CHC_MESSAGE") != null && resultLists.get(i).get(0).get("CHC_MESSAGE").contains("contain_img")) {
					System.out.println("****** "+i+" 사진 일 때");
					resultLists.get(i).get(0).replace("CHC_MESSAGE", "[사진]") ;
				}else {
					System.out.println("****** "+i+" NULL 일 때");
					resultLists.get(i).get(0).put("CHC_MESSAGE", "[메시지가 없습니다.]");
				}
			}
			return resultLists;
	}
	
	@Override
	public Map<String, Integer> selectChrListCnt(LPUserDto dto, String id) {
		logger.info("● Repository selectChrListCnt");
		Map<String, String> map = new HashMap<String, String>();
		map.put("rows", dto.getRows());
		map.put("id", id);
		return sqlSession.selectOne(NS+"selectChrListCnt", map);
	}

	@Override
	public boolean deleteChatroom(String chrId, String id) {
		// 선택된 채팅방의 SENDER를 조회
		logger.info("● Repository selectSender 20%");
		String sender = sqlSession.selectOne(NS+"selectSender", chrId);
		
		// SENDER랑 내 아이디랑 같으면 SOUT을 T로 변경 아니면 ROUT을 T로 변경
		logger.info("● Repository modifyChrout 40%");
		Map<String, String> mapModify = new HashMap<String, String>();
		mapModify.put("sender", sender);
		mapModify.put("nickname", id);
		mapModify.put("chrId", chrId);
		sqlSession.update(NS+"modifyChrout", mapModify);
		
		// 나간 사람의 채팅들 CHC_OUT을 T로 변경
		logger.info("● Repository modifyChcout 60%");
		sqlSession.update(NS+"modifyChcout", mapModify);
		
		// 선택된 채팅방의 SOUT, ROUT을 조회
		logger.info("● Repository selectChrout 80%");
		List<Map<String, String>> listSelect = sqlSession.selectList(NS+"selectChrout", chrId);
		
		int n = 0;
		// 선택된 채팅방의 SOUT, ROUT이 둘 다 T면 해당 채팅방을 삭제
		if (listSelect.get(0).get("CHR_ROUT").equals("T") && listSelect.get(0).get("CHR_SOUT").equals("T")) { // SOUT, ROUT이 둘 다 T면 실행
			logger.info("● Repository deleteChatroom 100%");
			n = sqlSession.delete(NS+"deleteChatroom", chrId);
		}
		System.out.println(n>0 ? "채팅방이 삭제되었습니다.":"삭제할 채팅방이 없습니다.");
		return false;
	}

	
}
