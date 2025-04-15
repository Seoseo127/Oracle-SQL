/******************************************
제약조건 (Constraint) 
- 올바른 데이터만 입력하기 위해 사용(잘못된 데이터는 입력 차단-에러발생)
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
4. PRIMARY KEY(PK, 기본키) : 고유 값 (NOT NULL + UNIQUE)
5. FOREIGN KEY(FK, 외래키-참조) : 해당 칼럼 값은 참조되는 테이블의 칼럼 값 중 하나와 일치하거나 Null을 가짐
    - 자식 테이블 : 다른 테이블의 값을 참조하는 테이블
    - 외래키(foreign key): 부모테이블의 값을 참조하는 자식테이블의 칼럼
    - 부모 테이블 : 다른 테이블에 의해 참조되는 테이블
    - 참조컬럼(reference) : 자식 테이블에서 참조하는 부모 테이블의 칼럼
************************************************/
SELECT * FROM DEPT;
CREATE TABLE DEPT (
    ID NUMBER(2) PRIMARY KEY,
    NAME VARCHAR2(30)
);
INSERT INTO DETP VALUES (10, '총무부');
INSERT INTO DETP VALUES (20, '급여부');
INSERT INTO DETP VALUES (30, 'IT부');
COMMIT;
--======================
--테이블 생성시 컬럼레벨에서 제약조건(외래키) 설정
CREATE TABLE EMP01 (
    EMPNO NUMBER(5) PRIMARY KEY,
    ENAME VARCHAR2(30) NOT NULL,
    JOB VARCHAR2(10),
    DEPTNO NUMBER(2) REFERENCES DEPT (ID) --외래키 설정(컬럼레벨)
);
SELECT * FROM EMP01;
INSERT INTO EMP01 (EMPNO, ENAME, JOB, DEPTNO)
VALUES (1111, '홍길동', '직무1', 10);
COMMIT;

--ORA-02291: integrity constraint (MADANG.SYS_C007053) violated - parent key not found
INSERT INTO EMP01 (EMPNO, ENAME, JOB, DEPTNO)
VALUES (2222, '홍길동2', '직무2', 90); -- DEPT 테이블의 ID 컬럼에 없는 데이터 사용(입력못함)

--====================
-- 테이블 레벨에서 제약조건 지정
CREATE TABLE EMP02 (
    EMPNO NUMBER(5),
    ENAME VARCHAR2(30) NOT NULL,
    JOB VARCHAR2(10),
    DEPTNO NUMBER(2),
    
    PRIMARY KEY (EMPNO), --기본키(PRIMARY KEY) 설정
    FOREIGN KEY (DEPTNO) REFERENCES DEPT (ID) --외래키(FOREIGN KEY) 설정
);
--=========================
-- 제약조건명을 명시적으로 선언해서 사용
-- 형태 : CONSTRAINT 제약조건명  적용할제약조건
CREATE TABLE EMP03 (
    EMPNO NUMBER(5),
    ENAME VARCHAR2(30) CONSTRAINT EMP03_ENAME_NN NOT NULL,
    JOB VARCHAR2(10),
    DEPTNO NUMBER(2),
    
    CONSTRAINT EMP03_EMPNO_PK PRIMARY KEY (EMPNO), --기본키(PRIMARY KEY) 설정
    CONSTRAINT EMP03_DEPTNO_FK FOREIGN KEY (DEPTNO) REFERENCES DEPT (ID) --외래키(FOREIGN KEY) 설정
);

INSERT INTO EMP03 (EMPNO, ENAME, JOB, DEPTNO)
VALUES (1111, '홍길동', '직무1', 10);
COMMIT;

--============================
/* 테이블에 제약조건 추가, 삭제
--제약조건 추가
ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건명  적용할제약조건;
--제약조건 삭제
ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건명;
--제약조건명 변경(수정)
ALTER TABLE 테이블명 RENAME CONSTRAINT 변경전명칭 TO 변경후명칭;
**************************/
-- EMP01 테이블의 PRIMARY KEY 삭제 : SYS_C007052 - 직접확인 사용
ALTER TABLE EMP01 DROP CONSTRAINT SYS_C007052;

-- EMP01 테이블의 PRIMARY KEY 추가
ALTER TABLE EMP01 ADD CONSTRAINT EMP01_EMPNO_PK PRIMARY KEY (EMPNO);

-------------------------
--(실습)EMP02, EMP03 외래키(FOREIGN KEY) 이름 변경 처리(삭제, 추가)
--EMP02 : EMP02_DEPTNO_FK, EMP03: FK_EMP03_DEPTNO
alter table "MADANG"."EMP02" drop constraint "SYS_C007056";
alter table "MADANG"."EMP02" add constraint EMP02_DEPTNO_FK foreign key("DEPTNO") references "DEPT"("ID");
ALTER TABLE EMP02 ADD CONSTRAINT EMP02_DEPTNO_FK FOREIGN KEY(DEPTNO) REFERENCES DEPT(ID);

-- 이름만 변경
ALTER TABLE EMP03 RENAME CONSTRAINT EMP03_DEPTNO_FK TO FK_EMP03_DEPTNO;

--======================================
/* 제약조건 활성화(ENABLE) 또는 비활성화(DISABLE)
--제약조건 설정되어 있는 것을 적용 또는 적용해제
ALTER TABLE 테이블명 DISABLE CONSTRAINT 제약이름;
ALTER TABLE 테이블명 ENABLE CONSTRAINT 제약이름;
*******************************/
--EMP02 테이블의 외래키(FK) 비활성화
alter table "MADANG"."EMP02" disable  constraint "EMP02_DEPTNO_FK";
ALTER TABLE EMP02 DISABLE  CONSTRAINT EMP02_DEPTNO_FK;
INSERT INTO EMP02 VALUES (3333, '홍길동3', '직무3', 90);
COMMIT;

--EMP02 테이블의 외래키(FK) 활성화(적용)
--제약조건 위반 데이터 존재하면 활성화 또는 추가 할 수 없다
--ORA-02298: cannot validate (MADANG.EMP02_DEPTNO_FK) - parent keys not found
ALTER TABLE EMP02 ENABLE  CONSTRAINT EMP02_DEPTNO_FK;

--=============================
-- 데이터사전 뷰 : 
SELECT * FROM USER_CONSTRAINTS; --현재 사용자 소유한 제약 조건에 대한 정보
SELECT * FROM USER_CONS_COLUMNS;--현재 사용자 소유한 제약 조건과 관련 컬럼 정보

SELECT a.owner, A.TABLE_NAME, b.column_name, A.CONSTRAINT_NAME
     , A.CONSTRAINT_TYPE
     , DECODE(A.CONSTRAINT_TYPE,
           'P', 'PRIMARY KEY',
           'U', 'UNIQUE',
           'C', 'CHECK OR NOT NULL',
           'R', 'FOREIGN KEY',
           '기타'
     ) AS CONSTRINT_TYPE_DESC
FROM USER_CONSTRAINTS A,
     USER_CONS_COLUMNS B
WHERE A.CONSTRAINT_NAME = B.CONSTRAINT_NAME  --조인조건
  AND A.TABLE_NAME = B.TABLE_NAME            --조인조건
--  AND A.TABLE_NAME LIKE 'EMP%'
ORDER BY A.TABLE_NAME  
;     

--======================
-- 기본키(PRIMARY KEY) 설정시 복합키 사용할 수 있음
CREATE TABLE HSCHOOL (
    HAK NUMBER(1), --학년
    BAN NUMBER(2), --반
    BUN NUMBER(2), --번호
    NAME VARCHAR2(30),
    CONSTRAINT HSCHOOL_HAK_BAN_BUN_PK PRIMARY KEY (HAK, BAN, BUN)
);
INSERT INTO hschool VALUES (1, 1, 1, '홍길동');
INSERT INTO hschool VALUES (1, 1, 2, '홍길동2');
INSERT INTO hschool VALUES (1, 2, 1, '홍길동3');
INSERT INTO hschool VALUES (2, 1, 1, '홍길동4');
COMMIT;

SELECT * FROM hschool;




