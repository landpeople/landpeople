CREATE TABLE LPCANVAS(
	CAN_ID VARCHAR2(20),
	SKETCH_ID VARCHAR2(20),
	CAN_TITLE VARCHAR2(50),
	CAN_CONTENT VARCHAR2(200),
	CAN_TYPE NUMBER,
	CAN_PAGENO NUMBER
);

CREATE SEQUENCE LPCANVAS_SEQ START WITH 1 INCREMENT BY 1;

SELECT * FROM LPCANVAS;

INSERT INTO HAPPY.LPCANVAS
(CAN_ID, SKETCH_ID, CAN_TITLE, CAN_CONTENT, CAN_TYPE, CAN_PAGENO)
VALUES('4', '3', '아무거나', '아무렇게나', 2, 1);



DELETE FROM LPCANVAS WHERE CAN_ID='26';

DELETE FROM LPTEXT WHERE CAN_ID='25';

INSERT INTO LPTEXT(TEXT_ID, CAN_ID, TEXT_CONTENT, TEXT_NO, IMG_SPATH)
			VALUES(LPTEXT_SEQ.NEXTVAL, (SELECT CAN_ID FROM LPCANVAS WHERE CAN_PAGENO='1'), '얍얍2', 2, ' ');

SELECT * FROM LPTEXT;
SELECT * FROM LPCANVAS;



INSERT INTO LPTEXT(TEXT_ID, CAN_ID, TEXT_CONTENT, TEXT_NO, IMG_SPATH)
			VALUES(LPTEXT_SEQ.NEXTVAL, '4', '얍얍2', 1, ' ');		
		
INSERT INTO LPTEXT(TEXT_ID,CAN_ID, TEXT_CONTENT, TEXT_NO, IMG_SPATH)    
	VALUES(LPTEXT_SEQ.NEXTVAL,'25' ,'test', 1, ' ');

DROP TABLE LPCANVAS;
DROP TABLE LPCANVAS_SEQ;

SELECT * FROM LPTEXT;

SELECT TEXT_ID, CAN_ID, TEXT_CONTENT, TEXT_NO, IMG_SPATH FROM LPTEXT 
			WHERE CAN_ID='22' ORDER BY TEXT_NO; 