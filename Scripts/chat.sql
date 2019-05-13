-- 채팅 ==========================================================================================================================================			
-- 테이블 재생성을 위해 테이블을 DROP하는 쿼리
DROP TABLE LPCHATLIST;
DROP TABLE LPCHATROOM;
DROP TABLE LPCHATIMAGE;

-- 시퀀스 재생성을 위해 시퀀스를 DROP하는 쿼리
DROP SEQUENCE LPCHATROOM_SEQ;
DROP SEQUENCE LPCHATIMAGE_SEQ;

-- 테이블 생성
CREATE TABLE LPCHATLIST(USER_NICKNAME VARCHAR2(20));
CREATE TABLE LPCHATROOM(CHR_ID VARCHAR2(20), CHL_ID VARCHAR2(20), USER_EMAIL VARCHAR2(50), CHR_CONTENT VARCHAR2(200), CHT_READFLAG CHAR(1), CHT_TIME DATE);
CREATE TABLE LPCHATIMAGE(CHI_ID VARCHAR2(20), CHL_ID VARCHAR2(20), USER_EMAIL VARCHAR2(50), CHI_RPATH VARCHAR2(200), CHI_SPATH VARCHAR2(200), FILE_SIZE NUMBER, CHT_READFLAG CHAR(1), CHT_TIME DATE);

-- 제약조건 추가
ALTER TABLE LPCHATLIST ADD PRIMARY KEY(USER_NICKNAME);
ALTER TABLE LPCHATROOM ADD FOREIGN KEY(CHL_ID) REFERENCES LPCHATLIST(CHL_ID) ON DELETE CASCADE; -- FK가 삭제되면 해당 컬럼도 함께 삭제함
ALTER TABLE LPCHATIMAGE ADD FOREIGN KEY(CHL_ID) REFERENCES LPCHATLIST(CHL_ID) ON DELETE CASCADE;

-- 테이블 시퀀스 생성
CREATE SEQUENCE LPCHATLIST_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE LPCHATROOM_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE LPCHATIMAGE_SEQ START WITH 1 INCREMENT BY 1;

-- 세션에 접속중인 상대방들과만 채팅할 수 있도록 테스트 하기 위해서 defalut로 사용자 몇 명 넣어줌 
INSERT INTO LPCHATLIST VALUES('접속자1');
INSERT INTO LPCHATLIST VALUES('접속자2');
INSERT INTO LPCHATLIST VALUES('접속자3');
INSERT INTO LPCHATLIST VALUES('접속자4');
INSERT INTO LPCHATLIST VALUES('접속자5');
INSERT INTO LPCHATLIST VALUES('접속자6');

-- 1. 세션에 접속한 사용자 리스트 출력 =================================================================================================
SELECT * FROM LPCHATLIST;





-- 1. 채팅방 생성 ==========================================================================================================================================			
-- 1) 기존에 상대방과 채팅방이 있는지 확인
SELECT CHL_ID, CHL_SENDER, CHL_RECEIVER FROM LPCHATLIST WHERE (CHL_SENDER, CHL_RECEIVER) IN (('a1@naver.com', 'b1@naver.com'),('b1@naver.com','a1@naver.com'));
-- 위와 같은 쿼리
--SELECT CHL_ID FROM LPCHATLIST WHERE CHL_SENDER= 'a1@naver.com' AND  CHL_RECEIVER = 'b1@naver.com' OR CHL_SENDER = 'b1@naver.com' AND CHL_RECEIVER = 'a1@naver.com';

-- 만약에 기존에 만들었던 채팅방이 있다면(CHL_ID) 그 채팅방을 가져와서 나의 채팅 목록에서 보이게 함(원래 F로 설정되어 있을 수도 있지만 그냥 업데이트 함)
UPDATE LPCHATLIST SET CHL_SDEL='F', CHL_RDEL = 'F' WHERE CHL_ID = '1';

-- 기존에 채팅방이 없다면(NULL) -> 채팅 리스트에 추가
INSERT INTO LPCHATLIST VALUES(LPCHATLIST_SEQ.NEXTVAL, 'a1@naver.com', 'b4@naver.com', 'F', 'F');

-- 추가한 채팅 리스트 확인
SELECT * FROM LPCHATLIST;
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
-- 3. 채팅방 메시지 보내기
DELETE FROM LPCHATROOM;

INSERT INTO LPCHATROOM VALUES(LPCHATROOM_SEQ.NEXTVAL, '1', 'a1@naver.com', 'a1 : 방가링1', 'F', SYSDATE);
INSERT INTO LPCHATROOM VALUES(LPCHATROOM_SEQ.NEXTVAL, '1', 'b1@naver.com', 'b1 : 방가링2', 'F', SYSDATE);
INSERT INTO LPCHATROOM VALUES(LPCHATROOM_SEQ.NEXTVAL, '1', 'b1@naver.com', 'b1 : 방가링3', 'F', SYSDATE);
INSERT INTO LPCHATROOM VALUES(LPCHATROOM_SEQ.NEXTVAL, '1', 'b1@naver.com', 'b1 : 방가링4', 'F', SYSDATE);
INSERT INTO LPCHATROOM VALUES(LPCHATROOM_SEQ.NEXTVAL, '1', 'a1@naver.com', 'a1 : 방가링5', 'F', SYSDATE);
INSERT INTO LPCHATROOM VALUES(LPCHATROOM_SEQ.NEXTVAL, '1', 'a1@naver.com', 'a1 : 방가링6', 'F', SYSDATE);
INSERT INTO LPCHATROOM VALUES(LPCHATROOM_SEQ.NEXTVAL, '1', 'b1@naver.com', 'b1 : 방가링7', 'F', SYSDATE);
INSERT INTO LPCHATROOM VALUES(LPCHATROOM_SEQ.NEXTVAL, '1', 'a1@naver.com', 'a1 : 방가링8', 'F', SYSDATE);
INSERT INTO LPCHATROOM VALUES(LPCHATROOM_SEQ.NEXTVAL, '1', 'a1@naver.com', 'a1 : 방가링9', 'F', SYSDATE);
INSERT INTO LPCHATROOM VALUES(LPCHATROOM_SEQ.NEXTVAL, '1', 'b1@naver.com', 'b1 : 방가링10', 'F', SYSDATE);

-- 추가한 채팅방 메시지 확인
SELECT * FROM LPCHATROOM;
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