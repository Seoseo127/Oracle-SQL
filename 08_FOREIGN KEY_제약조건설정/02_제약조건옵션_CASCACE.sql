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
5. FOREIGN KEY(FK, 외래키, 참조키) : 해당 칼럼 값은 참조되는 테이블의 칼럼 값 중 하나와 일치하거나 Null을 가짐
    - 자식 테이블 : 다른 테이블의 값을 참조하는 테이블
    - 외래키(foreign key): 부모테이블의 값을 참조하는 자식테이블의 칼럼
    - 부모 테이블 : 다른 테이블에 의해 참조되는 테이블
    - 참조컬럼(reference) : 자식 테이블에서 참조하는 부모 테이블의 칼럼
************************************************/
/* 제약조건 옵션
CASCADE : 부모테이블(parent)의 제약조건을 비활성화 시키면서
  참조하고 있는 자녀테이블(child)의 제약조건까지 비활성화
------------------
ON DELETE CASCADE
  테이블간의 관계에서 부모테이블 데이터 삭제시
  자녀테이블 데이터도 함께 삭제 처리  
***************************/
-- 자녀테이블에서 참조하고 있는 상태에서는 부모테이블 PK 비활성화 할 수 없음
--ORA-02297: cannot disable constraint (MADANG.SYS_C007030) - dependencies exist
ALTER TABLE DEPT DISABLE PRIMARY KEY;

--=================
--부모테이블 제약조건을 비활성화 하는 방법(참조관계 불일치로 안될때)
--방법1 : 직접 자녀테이블 참조키 모두 삭제 또는 비활성화 후 부모테이블 비활성화
--방법2 : 부모테이블 제약조건 비활성화하면서 CASCADE 옵션 사용
----------------------
ALTER TABLE EMP01 DISABLE CONSTRAINT SYS_C007053;
ALTER TABLE EMP02 DISABLE CONSTRAINT EMP02_DEPTNO_FK;
ALTER TABLE EMP03 DISABLE CONSTRAINT FK_EMP03_DEPTNO;

ALTER TABLE DEPT DISABLE PRIMARY KEY; --부모테이블 제약조건 비활성화

-- DEPT 테이블 PK, 자녀테이블 FK 활성화
ALTER TABLE DEPT ENABLE PRIMARY KEY;
ALTER TABLE EMP01 ENABLE CONSTRAINT SYS_C007053;
ALTER TABLE EMP02 ENABLE CONSTRAINT EMP02_DEPTNO_FK;
ALTER TABLE EMP03 ENABLE CONSTRAINT FK_EMP03_DEPTNO;

--방법2 : 부모테이블 제약조건 비활성화하면서 CASCADE 옵션 사용
ALTER TABLE DEPT DISABLE PRIMARY KEY CASCADE;

--========================
/* 제약조건 옵션 : ON DELETE CASCADE
  테이블간의 관계에서 부모테이블 데이터 삭제시
  자녀테이블 데이터도 함께 삭제 처리  
------------------------- */  
CREATE TABLE C_MAIN (
    MAIN_PK NUMBER(2) PRIMARY KEY,
    MAIN_DATA VARCHAR2(30)
);
CREATE TABLE C_SUB (
    SUB_PK NUMBER(2) PRIMARY KEY,
    SUB_DATA VARCHAR2(30),
    SUB_FK NUMBER(2),
    CONSTRAINT C_SUB_FK FOREIGN KEY (SUB_FK)
    REFERENCES C_MAIN (MAIN_PK) ON DELETE CASCADE
);
------
INSERT INTO C_MAIN VALUES (11, '1번 메인 데이터');
INSERT INTO C_MAIN VALUES (22, '2번 메인 데이터');
INSERT INTO C_MAIN VALUES (33, '3번 메인 데이터');
INSERT INTO C_MAIN VALUES (44, '4번 메인 데이터');
COMMIT;
------
INSERT INTO C_SUB VALUES (1, '1번 SUB 데이터', 11);
INSERT INTO C_SUB VALUES (2, '2번 SUB 데이터', 22);
INSERT INTO C_SUB VALUES (3, '3번 SUB 데이터', 33);
INSERT INTO C_SUB VALUES (4, '4번 SUB 데이터', 33);
COMMIT;
-----
SELECT * FROM C_MAIN;
SELECT * FROM C_SUB;
-------------
DELETE FROM C_MAIN WHERE MAIN_PK = 44;
DELETE FROM C_MAIN WHERE MAIN_PK = 11;
DELETE FROM C_MAIN WHERE MAIN_PK = 22;
DELETE FROM C_MAIN WHERE MAIN_PK = 33;










