﻿-- 스케치북 관련 쿼리
CREATE TABLE LPSKETCHBOOK(
	SKETCH_ID	VARCHAR2(20),
	USER_EMAIL	VARCHAR2(50),
	SKETCH_TITLE	VARCHAR2(50),
	SKETCH_THEME	VARCHAR2(20),
	SKETCH_SHARE	CHAR(1),
	SKETCH_DELFLAG	CHAR(1),
	SKETCH_BLOCK 	CHAR(1),
	SKETCH_SPATH	VARCHAR2(100),
);

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

CREATE TABLE LPCOLLECT(
	COL_ID	VARCHAR2(20),
	USER_EMAIL	VARCHAR2(50),
	SKETCH_ID	VARCHAR2(20),
	COL_SCRAPE	CHAR(1),
	COL_LIKE	CHAR(1)
);

-- 스케치북 작성 O

	
	-- 스케치북 생성 - 스케치북  테이블(LPSKETCHBOOK) 입력 
	SELECT USER_ISWRITE FROM LPUSER WHERE USER_EMAIL = '128@happy.com';

	INSERT INTO LPSKETCHBOOK
		(SKETCH_ID, USER_EMAIL, SKETCH_TITLE, SKETCH_THEME,
		SKETCH_SHARE, SKETCH_DELFLAG, SKETCH_SPATH, SKETCH_BLOCK)
	VALUES('0012', '130@happy.com','여행타이틀', '나홀로', 'F', 'F', 'c:\abc\dedf', 'F');


	-- 스케치북 수정
		-- 스케치북 정보 수정 O (사용자-마이페이지)
		UPDATE LPSKETCHBOOK SET SKETCH_TITLE='제목~!@!#@@#', SKETCH_THEME='가족여행', SKETCH_SHARE='Y', SKETCH_SPATH='c:\abbb\cccc' 
			                WHERE USER_EMAIL='123@happy.com' AND SKETCH_ID='0001';


			               
			               
		-- 스케치북 스크랩 수정(취소, 삭제)
		
			               
		UPDATE LPCOLLECT SET COL_SCRAPE='F' WHERE USER_EMAIL='128@happy.com' AND SKETCH_ID='0006';
 

 		-- 스케치북 '좋아요' (취소, 삭제)
		SELECT COL_LIKE FROM LPCOLLECT WHERE USER_EMAIL='128@happy.com' AND SKETCH_ID='0006';	
	
	
		UPDATE LPCOLLECT SET COL_LIKE='F' WHERE USER_EMAIL='128@happy.com' AND SKETCH_ID='0008';



	-- 스케치북 조회
		-- 스케치북 테마별 조회 
  		-- 총 좋아요 수가 표시
		SELECT (SKETCH_TITLE, SKETCH_CONTENT, SKETCH_SPATH, (SELECT COUNT(*) CNT FROM LPCOLLECT WHERE SKETCH_ID ='0001') LPLIKE FROM LPSKETCHBOOK WHERE SKETCH_THEME='나홀로') FROM LPSKETCHBOOK WHERE ROWNUM <=9;
		
	
		-- 스케치북 테마별 조회 무한스크롤 3*3	
	   SELECT SKETCH_ID, SKETCH_TITLE, SKETCH_SPATH
		  FROM (SELECT ROWNUM RNUM, SKETCH_ID, SKETCH_TITLE, SKETCH_SPATH
			 FROM (SELECT SKETCH_ID, SKETCH_TITLE, SKETCH_SPATH
					FROM LPSKETCHBOOK
					WHERE SKETCH_THEME='나홀로' AND SKETCH_SHARE='T' AND SKETCH_DELFLAG='F'AND SKETCH_BLOCK='F'  
					ORDER BY SKETCH_ID DESC)
				)
				WHERE RNUM BETWEEN 1 AND 9;
  		--SELECT COUNT(*) CNT FROM LPCOLLECT WHERE COL_LIKE='T';
  	    SELECT COUNT(*) CNT 
			FROM LPCOLLECT WHERE SKETCH_ID= '0006' AND COL_LIKE='T';	
			
			
			
			
			SELECT COUNT(*) CNT FROM LPCOLLECT, LPSKETCHBOOK WHERE LPSKETCHBOOK.USER_EMAIL='128@happy.com' AND LPCOLLECT.SKETCH_ID= LPSKETCHBOOK.SKETCH_ID AND COL_LIKE='T';
		-- 마이페이지에서는 세션에서 사용자  이메일 받아옴 테마별 스케치북 조회 사용자 이메일 ????
			
		
  	
  	
  	
		-- 스케치북 조회(사용자-마이페이지) O 
		
		SELECT SKETCH_ID, SKETCH_TITLE, SKETCH_SPATH
		  FROM (SELECT ROWNUM RNUM, SKETCH_ID, SKETCH_TITLE, SKETCH_SPATH
			 FROM (SELECT SKETCH_ID, SKETCH_TITLE, SKETCH_SPATH
					FROM LPSKETCHBOOK 
					WHERE USER_EMAIL='124@happy.com'  AND SKETCH_DELFLAG='F' AND SKETCH_BLOCK='F' 
					ORDER BY SKETCH_ID DESC)
				)
				WHERE RNUM BETWEEN 1 AND 9;
	
		SELECT COUNT(*) CNT 
		FROM LPCOLLECT WHERE SKETCH_ID= '' AND COL_LIKE='T'; 
			
			
		
		-- 마이페이지에서는 세션에서 사용자  이메일 받아옴
		
		-- 스크랩한 스케치북 조회
		SELECT LPSKETCHBOOK.SKETCH_ID, SKETCH_THEME, SKETCH_TITLE, SKETCH_SHARE, SKETCH_SPATH FROM LPSKETCHBOOK, LPCOLLECT WHERE LPCOLLECT.USER_EMAIL='128@happy.com' AND LPSKETCHBOOK.SKETCH_ID = LPCOLLECT.SKETCH_ID AND LPSKETCHBOOK.SKETCH_SHARE='T' AND LPSKETCHBOOK.SKETCH_DELFLAG='F' AND LPSKETCHBOOK.SKETCH_BLOCK='F';
	  
	
		-- 스크랩한 스케치북 갯수 조회
		SELECT COUNT(*) CNT FROM LPCOLLECT WHERE USER_EMAIL='128@happy.com' AND COL_SCRAPE='T';
	

		SELECT COUNT(*) CNT FROM LPCOLLECT  WHERE SKETCH_ID='0006' AND COL_LIKE = 'T';
	
		/*(SELECT COUNT(*) FROM LPCOLLECT WHERE COL_LIKE='T')LPLIKE*/
		-- 스케치북 스크랩 등록, 자신이 작성한 스케치북 스크랩 X		
		-- 최초 등록
		INSERT INTO LPCOLLECT(COL_ID, USER_EMAIL, SKETCH_ID, COL_SCRAPE , COL_LIKE)
		SELECT '001','128@happy.com', '0006', 'F', 'F' FROM DUAL WHERE NOT EXISTS(SELECT * FROM LPCOLLECT WHERE USER_EMAIL='128@happy.com' AND SKETCH_ID ='0006');
	
		
		-- 스케치북 스크랩 등록, 상태 변경
		UPDATE LPCOLLECT SET COL_SCRAPE='T' WHERE USER_EMAIL='128@happy.com' AND SKETCH_ID='0006'; 
	    
		

		-- 스케치북 '좋아요' 등록
		-- 좋아요 상태 변경
		UPDATE LPCOLLECT SET COL_LIKE='T' WHERE USER_EMAIL='128@happy.com' AND SKETCH_ID='0006';




	-- 스케치북 삭제 
		-- 선택한 스케치북 삭제 O
		UPDATE LPSKETCHBOOK SET SKETCH_DELFLAG='T' WHERE SKETCH_DELFLAG='F' AND USER_EMAIL='123@happy.com';

		-- 선택한 스케치북 다중 삭제 O
		UPDATE LPSKETCHBOOK SET SKETCH_DELFLAG='T' WHERE SKETCH_DELFLAG='F' AND USER_EMAIL IN('123@happy.com','124@happy.com','125@happy.com','126@happy.com','127@happy.com','128@happy.com','129@happy.com');
		
		-- 선택한 스케치북 스크랩 다중 취소
		UPDATE LPCOLLECT SET COL_SCRAPE='F' WHERE USER_EMAIL= '128@happy.com' AND SKETCH_ID IN('0006', '0007', '0004'); 












