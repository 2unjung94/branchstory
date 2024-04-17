/************************* ?SEQUNECE *************************/
DROP SEQUENCE USER_SEQ;
DROP SEQUENCE BLOG_SEQ;
DROP SEQUENCE ACCESS_HISTORY_SEQ;
DROP SEQUENCE KEYWORD_SEQ;
DROP SEQUENCE BLOG_LIST_SEQ;
DROP SEQUENCE LEAVE_USER_SEQ;
DROP SEQUENCE LIKE_SEQ;
DROP SEQUENCE COMMENT_SEQ;
DROP SEQUENCE IMAGE_SEQ;

CREATE SEQUENCE USER_SEQ NOCACHE;
CREATE SEQUENCE BLOG_SEQ NOCACHE;
CREATE SEQUENCE ACCESS_HISTORY_SEQ NOCACHE;
CREATE SEQUENCE KEYWORD_SEQ NOCACHE;
CREATE SEQUENCE BLOG_LIST_SEQ NOCACHE;
CREATE SEQUENCE LEAVE_USER_SEQ NOCACHE;
CREATE SEQUENCE LIKE_SEQ NOCACHE;
CREATE SEQUENCE COMMENT_SEQ NOCACHE;
CREATE SEQUENCE IMAGE_SEQ NOCACHE;


/************************* ?TABILE *************************/
DROP TABLE  IMAGE_T;
DROP TABLE  COMMENT_T;
DROP TABLE  LIKE_T;
DROP TABLE  LEAVE_USER_T;
DROP TABLE  BLOG_DETAIL_T;
DROP TABLE  KEYWORD_T;
DROP TABLE  ACCESS_HISTORY_T;
DROP TABLE  BLOG_INFO_T;
DROP TABLE  USER_T;

-- 사용자 테이블
CREATE TABLE USER_T (
	USER_NO	        NUMBER	            NOT NULL,
	EMAIL	        VARCHAR2(100 BYTE)	NOT NULL UNIQUE,
	PW	            VARCHAR2(64 BYTE)	NULL,
	NAME	        VARCHAR2(100 BYTE)	NULL,
	MOBILE	        VARCHAR2(20 BYTE)	NULL,
	SIGNUP_KIND	    NUMBER	            NULL,  -- 가입형태(0:직접, 1:네이버)
	GENDER	        VARCHAR2(10 BYTE)   NULL,
	SIGUNUP_DT	    DATE	            NULL,
	PW_MODIFY_DT	DATE	            NULL,
    CONSTRAINT PK_USER PRIMARY KEY (USER_NO)
);

-- 블로그 정보 테이블
CREATE TABLE BLOG_INFO_T (
	BLOG_NO	        NUMBER	            NOT NULL,
	USER_NO	        NUMBER	            NOT NULL,
	BLOG_CONTENTS	VARCHAR2(100 BYTE)	NULL,
	BLOG_IMG_PATH	VARCHAR2(100 BYTE)	NULL,
	NICKNAME	    VARCHAR2(100 BYTE)	NULL,
    CONSTRAINT PK_BLOG_INFO PRIMARY KEY (BLOG_NO),
    CONSTRAINT FK_BLOG_INFO_USER FOREIGN KEY (USER_NO)
        REFERENCES USER_T (USER_NO)
);

-- 접속 히스토리 테이블
CREATE TABLE ACCESS_HISTORY_T (
	ACCESS_HISTORY_NO	NUMBER	            NOT NULL,
	USER_NO	            NUMBER	            NOT NULL,
	EMAIL	            VARCHAR2 (100 BYTE)	NULL UNIQUE,
	IP	                VARCHAR2(50 BYTE)	NULL,
	USER_AGENT	        VARCHAR2(150 BYTE)	NULL,
	SESSION_ID	        VARCHAR2(32 BYTE)	NULL,
	SIGNIN_DT	        DATE	            NULL,
    CONSTRAINT PK_ACCESS_HISTORY PRIMARY KEY (ACCESS_HISTORY_NO),
    CONSTRAINT FK_ACCESS_HISTORY_USER FOREIGN KEY (USER_NO)
        REFERENCES USER_T (USER_NO)
);

-- 키워드 테이블
CREATE TABLE KEYWORD_T (
	KEYWORD_NO	    NUMBER	            NOT NULL,
	KEYWORD_NAME	VARCHAR2(100 BYTE)	NULL,
    CONSTRAINT PK_KEYWORD PRIMARY KEY (KEYWORD_NO)
);


-- 블로그 게시물 테이블
CREATE TABLE BLOG_DETAIL_T (
	BLOG_LIST_NO	NUMBER	             NOT NULL,
	BLOG_NO	        NUMBER	             NOT NULL,
	KEYWORD_NO	    NUMBER	             NOT NULL,
	TITLE	        VARCHAR2(1000 BYTE) NOT NULL,
	CONTENTS	    CLOB	             NULL,
	CREATE_DT	    DATE	             NULL,
	MODIFY_DT	    DATE	             NULL,
    CONSTRAINT PK_BLOG_DETAIL PRIMARY KEY (BLOG_LIST_NO),
    CONSTRAINT FK_BLOG_DETAIL_BLOG_INFO FOREIGN KEY (BLOG_NO)
        REFERENCES BLOG_INFO_T (BLOG_NO),
    CONSTRAINT FK_BLOG_DETAIL_KEYWORD FOREIGN KEY (KEYWORD_NO)
        REFERENCES KEYWORD_T (KEYWORD_NO)
);

-- 탈퇴 회원 테이블
CREATE TABLE LEAVE_USER_T (
	LEAVE_USER_NO	NUMBER	            NOT NULL,
	EMAIL	        VARCHAR2(100 BYTE)	NOT NULL UNIQUE,
	LEAVE_DT	    DATE	            NULL,
    CONSTRAINT PK_LEAVE_USER PRIMARY KEY (LEAVE_USER_NO)
);

-- 좋아요 테이블
CREATE TABLE LIKE_T (
	LIKE_NO	        NUMBER	NOT NULL,
	BLOG_LIST_NO	NUMBER	NOT NULL,
	USER_NO	        NUMBER	NOT NULL UNIQUE,
    CONSTRAINT PK_LIKE PRIMARY KEY (LIKE_NO),
    CONSTRAINT FK_LIKE_BLOG_DETAIL FOREIGN KEY (BLOG_LIST_NO)
        REFERENCES BLOG_DETAIL_T (BLOG_LIST_NO)
);

-- 블로그 댓글 테이블
CREATE TABLE COMMENT_T (
	COMMENT_NO	    NUMBER	            NOT NULL,
	BLOG_LIST_NO	NUMBER	            NOT NULL,
	USER_NO	        NUMBER	            NULL,
	CONTENTS	    VARCHAR2(4000 BYTE)	NOT NULL,
	CREATE_DT	    DATE	            NULL,
	STATE	        NUMBER	            NULL,  -- 0:삭제, 1:정상
	DEPTH	        NUMBER	            NULL,  -- 0:원글, 1:답글, 2:답답글, ...
	GROUP_NO	    NUMBER	            NULL,  -- 같은 GROUP_NO 내부에서 표시할 순서
    CONSTRAINT PK_COMMENT PRIMARY KEY (COMMENT_NO),
    CONSTRAINT FK_COMMENT_BLOG_DETAIL FOREIGN KEY (BLOG_LIST_NO)
        REFERENCES BLOG_DETAIL_T (BLOG_LIST_NO),
    CONSTRAINT FK_COMMENT_USER FOREIGN KEY (USER_NO)
        REFERENCES USER_T (USER_NO)
);

-- 이미지 테이블
CREATE TABLE IMAGE_T (
	IMAGE_NO	    NUMBER	            NOT NULL,
	BLOG_LIST_NO	NUMBER	            NOT NULL,
	FILESYSTEM_NAME	VARCHAR2(500 BYTE)	NOT NULL,
	UPLOAD_PATH	    VARCHAR2(500 BYTE)	NOT NULL,
    CONSTRAINT PK_IMAGE_T PRIMARY KEY (IMAGE_NO),
    CONSTRAINT FK_IMAGE_BLOG_DETAIL FOREIGN KEY (BLOG_LIST_NO)
        REFERENCES BLOG_DETAIL_T (BLOG_LIST_NO)
);


-- 관리자 계정 삽입
INSERT INTO USER_T VALUES(USER_SEQ.NEXTVAL, 'admin@example.com', STANDARD_HASH('admin', 'SHA256'), '관리자', '010-1111-1111', '0', 'man', CURRENT_DATE, CURRENT_DATE);


/************************* 트리거 *************************/

/*
  USER_T 테이블에서 삭제된 회원정보를 LEAVE_USER_T 테이블에 자동으로 삽입하는
  LEAVE_TRIGGER 트리거 생성하기
*/
CREATE OR REPLACE TRIGGER LEAVE_TRIGGER
  AFTER
  DELETE
  ON USER_T
  FOR EACH ROW
BEGIN
  INSERT INTO LEAVE_USER_T (
      LEAVE_USER_NO
    , EMAIL
    , LEAVE_DT
  ) VALUES (
      LEAVE_USER_SEQ.NEXTVAL
    , :OLD.EMAIL
    , CURRENT_DATE
  );
  -- COMMIT;  트리거 내에서는 오류가 있으면 ROLLBACK, 없으면 COMMIT 자동 처리
END;
