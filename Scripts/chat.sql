-- 채팅 ==========================================================================================================================================			

-- 테이블 재생성을 위해 테이블을 DROP하는 쿼리
DROP TABLE LPCHATLIST;
DROP TABLE LPCHATROOM;
DROP TABLE LPCHATIMAGE;

-- 시퀀스 재생성을 위해 시퀀스를 DROP하는 쿼리
DROP SEQUENCE LPCHATLIST_SEQ;
DROP SEQUENCE LPCHATROOM_SEQ;
DROP SEQUENCE LPCHATIMAGE_SEQ;

-- 테이블 생성
CREATE TABLE LPCHATLIST(CHL_ID VARCHAR2(20), CHL_SENDER VARCHAR2(50), CHL_RECEIVER VARCHAR2(50), CHL_SDEL CHAR(1), CHL_RDEL CHAR(1));
CREATE TABLE LPCHATROOM(CHR_ID VARCHAR2(20), CHL_ID VARCHAR2(20), USER_EMAIL VARCHAR2(50), CHR_CONTENT VARCHAR2(200), CHT_TIME DATE);
CREATE TABLE LPCHATIMAGE(CHI_ID VARCHAR2(20), CHL_ID VARCHAR2(20), USER_EMAIL VARCHAR2(50), CHI_RPATH VARCHAR2(200), CHI_SPATH VARCHAR2(200), FILE_SIZE NUMBER, CHT_TIME DATE);

-- 제약조건 추가
ALTER TABLE LPCHATLIST ADD PRIMARY KEY(CHL_ID);
ALTER TABLE LPCHATROOM ADD FOREIGN KEY(CHL_ID) REFERENCES LPCHATLIST(CHL_ID);
ALTER TABLE LPCHATIMAGE ADD FOREIGN KEY(CHL_ID) REFERENCES LPCHATLIST(CHL_ID);

-- 테이블 시퀀스 생성
CREATE SEQUENCE LPCHATLIST_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE LPCHATROOM_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE LPCHATIMAGE_SEQ START WITH 1 INCREMENT BY 1;

-- 채팅방 테스트 하기 위해서 defalut로 채팅방 몇 개 넣어줌
INSERT INTO LPCHATLIST VALUES(LPCHATLIST_SEQ.NEXTVAL, 'a1@naver.com', 'b1@naver.com', 'F', 'F');
INSERT INTO LPCHATLIST VALUES(LPCHATLIST_SEQ.NEXTVAL, 'a1@naver.com', 'b2@naver.com', 'F', 'F');
INSERT INTO LPCHATLIST VALUES(LPCHATLIST_SEQ.NEXTVAL, 'a2@naver.com', 'b2@naver.com', 'F', 'F');
INSERT INTO LPCHATLIST VALUES(LPCHATLIST_SEQ.NEXTVAL, 'b2@naver.com', 'a3@naver.com', 'F', 'F');

-- 채팅방 목록 확인
SELECT * FROM LPCHATLIST;

-- 1. 채팅방 생성 ==========================================================================================================================================			

-- 1) 기본에 상대방과 채팅방이 있는지 확인

-- 내가 삭제한 경우는  이전 데이터 안 보인채로 나한테 채팅 리스트가 생성됨.
SELECT CHL_ID FROM LPCHATLIST WHERE (CHL_SENDER, CHL_RECEIVER) IN (('a1@naver.com', 'b1@naver.com'),('b1@naver.com','a1@naver.com'));

-- 위와 같은 쿼리
SELECT COUNT(*) FROM LPCHATLIST WHERE CHL_SENDER= 'a1@naver.com' AND  CHL_RECEIVER = 'b1@naver.com' OR CHL_SENDER = 'b1@naver.com' AND CHL_RECEIVER = 'a1@naver.com';

-- 만약에 기존에 만들었던 채팅방이 있다면 나의 채팅 목록에서 보이게 됨 -> 채팅방 상세를 가져옴
UPDATE LPCHATLIST SET CHL_SDEL='F', CHL_RDEL = 'F' WHERE CHL_ID = '1';

-- 기존에 채팅방이 없다면 -> 채팅 리스트에 추가
INSERT INTO LPCHATLIST VALUES(LPCHATLIST_SEQ.NEXTVAL, 'a3@naver.com', 'b4@naver.com', 'F', 'F');

-- 추가한 채팅 리스트 확인
SELECT * FROM LPCHATLIST;

-- ==========================================================================================================================================						

-- 2. 채팅방 삭제(TT이면 다 삭제)
-- 컨트롤러에서 나와 상대의 채팅방이 존재하는 지 확인, 내가 SENDER인지 RECEIVER인지 확인하고 SENDER일 때와 RECEIVER 일 때로 나눠줌
SELECT CHL_ID, CHL_SENDER, CHL_RECEIVER FROM LPCHATLIST WHERE (CHL_SENDER, CHL_RECEIVER) IN (('a1@naver.com', 'b1@naver.com'),('b1@naver.com','a1@naver.com'));
			
-- 만약에 내가 SENDER이면
UPDATE LPCHATLIST SET CHL_RDEL='T' WHERE CHL_ID = '7' ;

-- 만약에 내가 RECEIVER이면
UPDATE LPCHATLIST SET CHL_SDEL='T' WHERE CHL_ID = '7' ;

-- 채팅방 진짜 삭제
DELETE FROM LPCHATLIST WHERE CHL_SDEL = 'T' AND CHL_RDEL ='T' AND CHL_ID = '7';

-- ==========================================================================================================================================			

-- 3. 채팅방 메시지 보내기
INSERT INTO LPCHATROOM VALUES(LPCHATROOM_SEQ.NEXTVAL, '1', 'sender@naver.com', '안녕', SYSDATE);

-- 추가한 채팅방 메시지 확인
SELECT * FROM LPCHATROOM;

-- ==========================================================================================================================================			

--4. 채팅방 이미지 보내기
INSERT INTO LPCHATIMAGE VALUES(LPCHATIMAGE_SEQ.NEXTVAL, '1', 'sender@naver.com', '진짜경로', '상대경로', 1000, SYSDATE);

-- 추가한 채팅방 이미지 확인
SELECT * FROM LPCHATIMAGE;

-- ==========================================================================================================================================			

--5. 채팅방 상세페이지 보기
SELECT CHR_ID, CHI_ID, CHL_ID, USER_EMAIL, CHR_CONTENT, CHI_RPATH, CHI_SPATH, FILE_SIZE, CHT_TIME FROM
	(SELECT CHR_ID, NULL CHI_ID, CHL_ID, USER_EMAIL, CHR_CONTENT, NULL CHI_RPATH, NULL CHI_SPATH, NULL FILE_SIZE, CHT_TIME FROM LPCHATROOM WHERE LPCHATROOM.CHL_ID='1'
		UNION ALL
	SELECT NULL CHR_ID, CHI_ID, CHL_ID, USER_EMAIL, NULL CHR_CONTENT, CHI_RPATH, CHI_SPATH, FILE_SIZE, CHT_TIME FROM LPCHATIMAGE WHERE LPCHATIMAGE.CHL_ID='1')
WHERE USER_EMAIL='sender@naver.com'
ORDER BY CHT_TIME;

-- ==========================================================================================================================================			

--6. 채팅방 리스트 보기(접속한 사용자가 나가지 않은 방)
SELECT * FROM LPCHATLIST WHERE (CHL_SENDER = 'a1@naver.com' AND CHL_SDEL = 'F') OR (CHL_RECEIVER = 'a1@naver.com' AND CHL_RDEL = 'F');

-- ==========================================================================================================================================			

-- 배치로 CHL_RDEL과 CHL_WDEL이 모두 T인 채팅방을 삭제
DELETE FROM LPCHATLIST WHERE CHL_RDEL = 'T' AND CHL_WDEL = 'T';