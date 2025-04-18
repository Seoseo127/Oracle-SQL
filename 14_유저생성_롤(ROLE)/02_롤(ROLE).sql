/* ********* 역할(롤 ROLE) ***********
역할(롤, ROLE) : DB 객체 및 시스템에 대한 권한을 모아둔 집합을 의미
역할 생성 : CREATE ROLE 역할이름
역할 제거 : DROP ROLE 역할이름
역할에 권한 부여 : GRANT 권한 [ON 객체] TO 역할이름
역할의 권한 회수 : REVOKE 권한 [ON 객체] FROM 역할이름
사용자에게 역할 부여 : GRANT 역할이름 TO 사용자

<역할 생성부터 사용자 추가까지의 단계>
CREATE ROLE - 역할생성
GRANT - 만들어진 역할에 권한 부여
GRANT - 사용자에게 역할 부여
-->>역할 제거할 경우 반대로 수행
DROP ROLE - 역할 삭제(사용자에게 부여된 역할에 대한 권한 역시 제거됨)
***************************************/
--(MADANG)일반유저 롤(역할) 조회
SELECT * FROM user_role_privs;-- 부여된 롤(ROLE)
SELECT * FROM USER_SYS_PRIVS; -- 부여된 시스템 권한 정보
SELECT * FROM USER_TAB_PRIVS; --객체 권한 정보

--(관리자계정-SYSTEM) : DBA_ROLE_PRIVS, DBA_SYS_PRIVS, DBA_TAB_PRIVS
SELECT * FROM DBA_ROLE_PRIVS WHERE GRANTEE = 'MADANG'; --ROLE
SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'MADANG'; --권한
SELECT * FROM DBA_TAB_PRIVS WHERE GRANTEE = 'MADANG'; --객체권한

-----------------------------
--(SYSTEM) 롤(ROLE) 생성 : PROGRAMMER(개발자) 라는 역할(롤) 생성
CREATE ROLE PROGRAMMER;

--(SYSTEM) PROGRAMMER(개발자)에게 권한 부여 테이블, 뷰(VIEW) 생성 권한 부여
GRANT CREATE ANY TABLE, CREATE ANY VIEW TO PROGRAMMER;

--(SYSTEM) MDGUEST 유저에게 PROGRAMMER 롤(역할) 부여
CREATE USER "MDGUEST" IDENTIFIED BY "mdguest"  
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

-- 롤(ROLES) 역할 부여
GRANT CONNECT, RESOURCE TO MDGUEST ;

--PROGRAMMER 롤 부여(설정)
GRANT PROGRAMMER TO MDGUEST;

--(MDGUEST) 테이블 생성 테스트 MADANG.BBB 만들기
SELECT * FROM user_role_privs; --CONNECT, PROGRAMMER, RESOURCE
CREATE TABLE MADANG.BBB (BBB NUMBER);
CREATE TABLE HR.BBB (BBB NUMBER);

--(SYSTEM) 롤(권한) 회수(취소)
REVOKE PROGRAMMER FROM MDGUEST;

--(SYSTEM) 롤(ROLE) 삭제
DROP ROLE PROGRAMMER;





