-- 임시 저장소 ==========================================================================================================================================			
DELETE FROM LPCHATLIST WHERE USER_NICKNAME NOT IN ('lee','kim');


-- 세션이 필요해서 테스트용으로 만들어 쓰는 테이블
DROP TABLE LPUSER;

CREATE TABLE LPUSER(
	USER_EMAIL VARCHAR2(50) NOT NULL,
	USER_PASSWORD VARCHAR2(100) NOT NULL,
	USER_NICKNAME VARCHAR2(20) NOT NULL,
	USER_AUTH CHAR(1),
	USER_DELFLAG CHAR(1) DEFAULT 'F',
	USER_EMAILCHK CHAR(1),
	USER_EMAILKEY VARCHAR2(300),
	USER_ISWRITE CHAR(1) DEFAULT 'T'
);

-- 채팅 ==========================================================================================================================================			
-- 테이블 재생성을 위해 테이블을 DROP하는 쿼리
DROP TABLE LPCHATLIST;
DROP TABLE LPCHATROOM;
DROP TABLE LPCHATCONTENT;
DROP TABLE LPCHATIMAGE;

-- 시퀀스 재생성을 위해 시퀀스를 DROP하는 쿼리
DROP SEQUENCE LPCHATROOM_SEQ;
DROP SEQUENCE LPCHATCONTENT_SEQ;
DROP SEQUENCE LPCHATIMAGE_SEQ;

-- 테이블 생성
-- 접속한 사용자의 닉네임을 저장하는 테이블, 세션이 종료되면 세션에 없는 사용자는 테이블에서 제거함
CREATE TABLE LPCHATLIST(USER_NICKNAME VARCHAR2(20));
-- 사용자간의 채팅방을 저장하는 테이블, 채팅방 상세페이지에서 채팅방 나가기를 선택하면 CHR_OUT 컬럼이 T로 바뀌며 채팅방 전체조회 페이지에서 조회되지 않음 
CREATE TABLE LPCHATROOM(CHR_ID VARCHAR2(20), CHR_SENDER VARCHAR2(20), CHR_RECEIVER VARCHAR2(50), CHR_SOUT CHAR(1), CHR_ROUT CHAR(1));
-- 채팅방의 메시지를 저장하는 테이블, 화면에서 새로운 메시지가 발생하면 리스트에 저장하고 있다가 채팅방을 종료시에 한 ROW를 생성하며 INSERT됨, 만일 CHR_OUT을 하면 CHC_OUT도 함께 보이지 않도록 되어짐
-- 내가 SENDER인지 RECEVER인지 판단이 필요할 듯함 
CREATE TABLE LPCHATCONTENT(CHC_ID VARCHAR2(20), CHR_ID VARCHAR2(20), USER_NICKNAME VARCHAR2(20), CHC_MESSAGE VARCHAR2(4000), CHC_OUT CHAR(1), CHC_REGDATE DATE);
-- 채팅방에서 주고 받은 이미지를 저장하는 테이블
CREATE TABLE LPCHATIMAGE(CHI_ID VARCHAR2(20), CHI_RPATH VARCHAR2(200), CHI_SPATH VARCHAR2(200), FILE_SIZE NUMBER);

-- 테이블 시퀀스 생성
CREATE SEQUENCE LPCHATROOM_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE LPCHATCONTENT_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE LPCHATIMAGE_SEQ START WITH 1 INCREMENT BY 1;

-- 시퀀스 반환 함수 생성
CREATE FUNCTION GET_CONTENT_SEQ RETURN NUMBER IS
BEGIN RETURN LPCHATCONTENT_SEQ.NEXTVAL; END;

-- 1. 세션에 접속한 사용자 리스트 출력 =================================================================================================
-- @ chatList_Insert
INSERT INTO LPCHATLIST VALUES(#{user_nickname});

-- 1. 채팅방 생성 ==========================================================================================================================================			
-- @ String chatRoom_Make(Map<String, String> map)

-- 1. 기존에 상대방과 채팅방이 있는지 확인
-- @ String chatRoom_Check(Map<String, String> map) - sender, receiver
SELECT CHR_ID FROM LPCHATROOM WHERE (CHR_SENDER, CHR_RECEIVER) IN ((#{sender}, #{receiver}),(#{receiver}, #{sender}));

-- 2.1 만약에 기존에 만들었던 채팅방이 있다면 나의 채팅 목록에서 보이게 만들어줌
-- @ int chatRoom_Show(String chr_id) 
UPDATE LPCHATROOM SET CHR_SOUT='F', CHL_ROUT = 'F' WHERE CHR_ID = #{chr_id};

-- 2.1.1 채팅 메시지 가져오기
-- @ List<ChatContentDto> chatContent_SelectAll(ChatContentDto dto) - chr_id, user_nickname
SELECT CHC_ID, CHR_ID, USER_NICKNAME, CHC_MESSAGE, CHC_OUT, CHC_REGDATE FROM LPCHATCONTENT WHERE CHR_ID = #{chr_id} AND USER_NICKNAME = #{user_nickname} AND CHC_OUT = 'F';

-- 2.2 기존에 채팅방이 없다면 -> 채팅 리스트에 추가하면서, 채팅방 대화내용 저장 공간을 만들어줌
-- @ String chatRoom_Insert(Map<String, String> map)
INSERT INTO LPCHATROOM VALUES(LPCHATROOM_SEQ.NEXTVAL, #{sender},  #{receiver}, 'F', 'F')
SELECT @@IDENTITY AS CHR_ID

-- 2.2.1 채팅방을 만들면서 대화내용 저장공간도 함께 만들어줌, SENDER와 RECEIVER 각각 하나씩
-- @ int chatContent_Insert(List<ChatUserDto> dto)
INSERT INTO LPCHATCONTENT VALUES(LPCHATCONTENT_SEQ.NEXTVAL, #{chr_id}, #{user_nickname}, '', 'F', SYSDATE);

-- 2. 채팅 메시지 저장하기 ==========================================================================================================================================

-- @ int chatContent_InsertMsg(ChatContentDto dto)
INSERT INTO LPCHATCONTENT VALUES(LPCHATCONTENT_SEQ.NEXTVAL, #{chr_id}, #{user_nickname}, #{chc_message}, 'F', SYSDATE);



-- ==========================================================================================================================================
-- 2. 채팅방 삭제(TT이면 다 삭제)
-- 내가 SENDER인지 RECEIVER인지 확인하고 SENDER일 때와 RECEIVER인지 확인 위함
SELECT CHL_ID, CHL_SENDER, CHL_RECEIVER FROM LPCHATLIST WHERE (CHL_SENDER, CHL_RECEIVER) IN (('a1@naver.com', 'b1@naver.com'),('b1@naver.com','a1@naver.com'));
			
-- 만약에 내가 SENDER이면
UPDATE LPCHATLIST SET CHL_SDEL='T' WHERE CHL_ID = '7' ;

-- 만약에 내가 RECEIVER이면
UPDATE LPCHATLIST SET CHL_RDEL='T' WHERE CHL_ID = '7' ;

-- 채팅방 진짜 삭제
DELETE FROM LPCHATLIST WHERE CHL_SDEL = 'T' AND CHL_RDEL ='T' AND CHL_ID = '7';
-- ==========================================================================================================================================			

--4. 채팅방 이미지 보내기
INSERT INTO LPCHATIMAGE VALUES(LPCHATIMAGE_SEQ.NEXTVAL, '21', 'a1@naver.com', '진짜경로', '상대경로', 1000, 'F', SYSDATE);

-- 추가한 채팅방 이미지 확인
SELECT * FROM LPCHATIMAGE;
-- ==========================================================================================================================================			
--5. 채팅방 상세페이지 보기
SELECT CHR_ID, CHI_ID, CHL_ID, USER_EMAIL, CHR_CONTENT, CHI_RPATH, CHI_SPATH, FILE_SIZE, CHT_READFLAG, CHT_TIME FROM
	(SELECT CHR_ID, NULL CHI_ID, CHL_ID, USER_EMAIL, CHR_CONTENT, NULL CHI_RPATH, NULL CHI_SPATH, NULL FILE_SIZE, CHT_READFLAG, CHT_TIME FROM LPCHATROOM WHERE LPCHATROOM.CHL_ID='1'
		UNION ALL
	SELECT NULL CHR_ID, CHI_ID, CHL_ID, USER_EMAIL, NULL CHR_CONTENT, CHI_RPATH, CHI_SPATH, FILE_SIZE, CHT_READFLAG, CHT_TIME FROM LPCHATIMAGE WHERE LPCHATIMAGE.CHL_ID='1')
ORDER BY CHT_TIME;

UPDATE LPCHATROOM SET CHT_READFLAG = 'T' WHERE CHL_ID = '1' AND USER_EMAIL != 'a1@gmail.com';
UPDATE LPCHATIMAGE SET CHT_READFLAG = 'T' WHERE CHL_ID = '1' AND USER_EMAIL != 'a1@gmail.com';
-- ==========================================================================================================================================	
--6. 채팅방 리스트 보기(접속한 사용자가 나가지 않은 방, 필요한 정보는 내가 보내는 사람인지 받는 사람인지 그리고 마지막 메시지와 시간)
SELECT CHL_ID, CHL_SENDER, CHL_RECEIVER FROM LPCHATLIST WHERE (CHL_SENDER = 'a1@naver.com' AND CHL_SDEL = 'F') OR (CHL_RECEIVER = 'a1@naver.com' AND CHL_RDEL = 'F');

-- 마지막 메시지와 시간 만약에 CHR_ID와 CHI_ID가 NULL 인지 아닌지에 따라서 뿌려줌
SELECT RN, CHR_ID, CHI_ID, CHL_ID, CHR_CONTENT, CHT_TIME FROM
 (SELECT ROW_NUMBER() OVER (ORDER BY CHT_TIME DESC) RN, CHR_ID, CHI_ID, CHL_ID, CHR_CONTENT, CHT_TIME FROM
	(SELECT CHR_ID, NULL CHI_ID, CHL_ID, CHR_CONTENT, CHT_TIME FROM LPCHATROOM WHERE LPCHATROOM.CHL_ID='1'
		UNION ALL
	SELECT NULL CHR_ID, CHI_ID, CHL_ID, NULL CHR_CONTENT, CHT_TIME FROM LPCHATIMAGE WHERE LPCHATIMAGE.CHL_ID='1')
) WHERE RN = '1';
-- ==========================================================================================================================================			
-- 7. 채팅방 안 읽은 메시지 갯수 세기
SELECT COUNT(*) FROM
	(SELECT CHT_READFLAG FROM LPCHATROOM WHERE LPCHATROOM.CHL_ID='1'
		UNION ALL
	SELECT CHT_READFLAG FROM LPCHATIMAGE WHERE LPCHATIMAGE.CHL_ID='1')
WHERE CHT_READFLAG = 'F';

--  배치로 CHL_RDEL과 CHL_WDEL이 모두 T인 채팅방을 삭제
DELETE FROM LPCHATLIST WHERE CHL_RDEL = 'T' AND CHL_WDEL = 'T';