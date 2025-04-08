/* *************************
데이터 정의어
- DDL(Data Definition Language) : 데이터를 정의하는 언어
- CREATE(생성), DROP(삭제), ALTER(수정)
- {}반복가능, []생략가능, | 또는(선택)
CREATE TABLE 테이블명 (
    {컬럼명 데이터타입
        [NOT NULL | UNIQUE | DEFAULT 기본값 | CHECK 체크조건]
    }
    [PRIMARY KEY 컬럼명]
    {[FOREIGN KEY 컬럼명 REFERENCES 테이블명(컬럼명)]
    [ON DELETE [CASCADE | SET NULL]
    }
);
-----------------------------------------------
<제약조건 5종류>
- NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY
-----------------------------------------------
컬럼의 기본 데이타 타입(문자열, 숫자, 날짜)
- VARCHAR2(n) : 문자열 가변길이
- CHAR(n) : 문자열 고정길이
- NUMBER(p, s) : 숫자타입 p:전체길이, s:소수점이하 자리수
    예) (5,2) : 정수부 3자리, 소수부 2자리 - 전체 5자리
- DATE : 날짜형 년,월,일 시간 값 저장

문자열 처리 : UTF-8 형태로 저장
- 숫자, 알파벳 문자, 특수문자 : 1 byte 처리(키보드 자판 글자들)
- 한글 : 3 byte 처리
***************************/
/******************************************
제약조건 (Constraint) 
- 올바른 데이터만 들어오게 해주기 위해 사용(잘못된 데이터는 못들어 차단-에러발생)
- 데이터의 정확성과 일관성을 보장하기 위해 각 칼럼에 정의하는 규칙
- 딕셔너리에 저장됨
- 테이블 생성시 무결성 제약조건을 정의하여 프로그래밍 과정을 단순화
- 데이터베이스 서버에 의해 무결성 제약조건이 관리되어 데이터 오류 발생 가능성을 줄여줌
- 일시적으로 활성화(ENABLE) 또는 비활성화(DISABLE) 할 수 있다.

<제약조건 5종류>
- NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY
1. NOT NULL : Null값 포함할수 없음
2. UNIQUE : 중복되는 값 오면 안됨
    (중복되는 것 없어야 하므로, 서버프로세스가 기존 데이터를 찾아야 한다. 오래걸림 - 해결 : 인덱스)
3. CHECK : 해당 칼럼에 저장 가능한 데이터 값의 범위나 조건 지정
4. PRIMARY KEY(기본키) : 고유 값 (NOT NULL + 유니크)
5. FOREIGN KEY(외래키-참조) : 해당 칼럼 값은 참조되는 테이블의 칼럼 값 중 하나와 일치하거나 Null을 가짐
    - 자식 테이블 : 다른 테이블의 값을 참조하는 테이블
    - 외래키(foreign key): 부모테이블의 값을 참조하는 자식테이블의 칼럼
    - 부모 테이블 : 다른 테이블에 의해 참조되는 테이블
    - 참조키(reference : 자식 테이블에서 참조하는 부모 테이블의 칼럼
************************************************/
-- DDL 문 사용 테이블 생성
CREATE TABLE MEMBER (
    ID VARCHAR2(20) PRIMARY KEY, -- NOT NULL + UNIQUE
    NAME VARCHAR2(30) NOT NULL,
    PASSWORD VARCHAR2(20) NOT NULL,
    PHONE VARCHAR2(20),
    ADDRESS VARCHAR2(300)
);
--------------------
-- DML : SELECT, INSERT, UPDATE, DELETE
-- INSERT : 데이터 입력시 사용
INSERT INTO MEMBER (ID, NAME, PASSWORD)
VALUES ('HONG', '홍길동', '1234');

-- DCL : COMMIT, ROLLBACK
COMMIT; -- 임시 처리된 작업 최종 적용(확정)
ROLLBACK; -- 임시 처리된 작업 취소

INSERT INTO member (id, name, password)
VALUES ('HONG2', '홍길동2', '1234');
COMMIT;
INSERT INTO MEMBER (ID, NAME)
VALUES ('HONG3', '홍길동3');

-----------------------
SELECT * FROM MEMBER;
SELECT ID, NAME, PASSWORD, PHONE FROM MEMBER;
----------------------
--입력 : 컬럼명 명시적으로 쓰지 않고 INSERT 문 작성
-- 테이블에 있는 모든 컬럼 사용 + 컬럼 순서대로 데이터 입력
INSERT INTO MEMBER
VALUES ('HONG3', '홍길동3', '1234', '010-1111-1111', '서울');
COMMIT;

INSERT INTO MEMBER
VALUES ('HONG4', '홍길동4', '010-4444-4444', 'PW1234' , '부산');
COMMIT;
----------------
-- 컬럼명을 명시적으로 작성시 해당 컬럼에 1대 1 매칭되어 데이터 입력
INSERT INTO MEMBER (ID, NAME, PASSWORD, ADDRESS, PHONE)
VALUES ('HONG5', '홍길동5', 'PW5555', '010-5555-5555', '대전');
COMMIT;

SELECT * FROM MEMBER;
-----------------------------------------------
-- UPDATE : 테이블 데이터를 수정하기
-- 수정 : ID값 HONG4 로 데이터를 찾아서 PASSWORD, PHONE 컬럼값 변경
-- PASSWORD: PW1234, PHONE: 010-4444-4444 값으로 변경
SELECT * FROM MEMBER WHERE ID = 'HONG4';
UPDATE MEMBER SET PASSWORD = 'PW1234' WHERE ID = 'HONG4';
UPDATE MEMBER SET PHONE = '010-4444-4444' WHERE ID = 'HONG4';
ROLLBACK;
------
-- SQL 작성방식1 - 맨앞에 맞추기
UPDATE MEMBER
SET PASSWORD = 'PW1234',
    PHONE = '010-4444-4444'
WHERE ID = 'HONG4'
;
-- SQL 작성방식2 - SQL 내용 시작위치 일치시키기
UPDATE MEMBER
   SET PASSWORD = 'PW1234',
       PHONE = '010-4444-4444'
 WHERE ID = 'HONG4'
;
-- SQL 작성방식3 - 탭 또는 일정간격 들여쓰기
UPDATE MEMBER
    SET PASSWORD = 'PW1234',
        PHONE = '010-4444-4444'
    WHERE ID = 'HONG4'
;
COMMIT;
----------------------------
-- 삭제 : HONG5 데이터 삭제
SELECT * FROM MEMBER WHERE ID = 'HONG5';
DELETE FROM MEMBER WHERE ID = 'HONG5';
COMMIT;
----------------

SELECT * FROM MEMBER WHERE ID = 'HONG4';

UPDATE MEMBER
SET NAME = '홍길동'
WHERE ID = 'HONG4'
;
COMMIT;
-- 삭제 : 이름이 '홍길동'인 사람 삭제
SELECT * FROM MEMBER WHERE NAME = '홍길동';
DELETE FROM MEMBER WHERE NAME = '홍길동';
COMMIT;

--=============================
/* (실습) 입력, 수정, 삭제, 조회(검색)
■입력
 - 아이디: HONG8
 - 이름: 홍길동8
 - 암호: 1111 
 - 주소: 서울시 강남구
■조회(검색) : 이름이 '홍길동8'인 사람의 아이디, 이름, 주소, 전화번호 조회
■수정 : 아이디가 HONG8 사람의
    전화번호 : 010-8888-8888
    암호 : 8888
    주소 : 서울시 강남구 역삼동
■ 삭제 : 아이디가 HONG2 인 사람    
********************************/















