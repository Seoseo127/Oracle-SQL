/* 유저(USER) 생성 ******
-- 사용자 생성 : MDGUEST / mdguest
-- 롤(ROLE) 부여 : CONNECT, RESOURCE
-- USER SQL
CREATE USER 유저명 IDENTIFIED BY 암호  
DEFAULT TABLESPACE 테이블스페이스명
TEMPORARY TABLESPACE 테이블스페이스명;

-- 롤(ROLES) 역할 부여
GRANT CONNECT TO 유저명 ;
GRANT RESOURCE TO 유저명 ;

-- 뷰생성 권한 부여
GRANT CREATE VIEW TO 유저명 ;

-- 사용자 삭제 : DROP USER
--DROP USER 유저명 [CASCADE];
--CASCADE 옵션 : 삭제시점에 유저(USER)가 보유한 모든 데이터(객체) 일괄 삭제
******************/
-- 사용자 생성 : MDGUEST / mdguest
-- 롤(ROLE) 부여 : CONNECT, RESOURCE
CREATE USER "MDGUEST" IDENTIFIED BY "mdguest"  
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

-- 롤(ROLES) 역할 부여
GRANT CONNECT, RESOURCE TO MDGUEST ;

-- 뷰(VIEW) 생성 권한 부여
GRANT CREATE VIEW TO "MDGUEST" ;
---------------------------------
--(SYSTEM) CONNECT, RESOURCE 롤(ROLE)에 있는 권한 확인
SELECT *
FROM DBA_SYS_PRIVS
WHERE GRANTEE IN ('CONNECT', 'RESOURCE')
ORDER BY GRANTEE, PRIVILEGE
;
--=============================
/****** 권한 부여(GRANT), 권한 취소(REVOKE) **********************
GRANT 권한 [ON 객체] TO {사용자|ROLE|PUBLIC,.., n} [WITH GRANT OPTION]
--PUBLIC은 모든 사용자에게 적용을 의미

GRANT 권한 TO 사용자; --권한을 사용자에게 부여
GRANT 권한 ON 객체 TO 사용자; -객체에 대한 권한을 사용자에게 부여
-->> WITH GRANT OPTION :객체에 대한 권한을 사용자에게 부여 
-- 권한을 받은 사용자가 다른 사용자에게 권한부여할 권리 포함
GRANT 권한 ON 객체 TO 사용자 WITH GRANT OPTION;
--------------------
-->>>권한 취소(REVOKE)
REVOKE 권한 [ON 객체] FROM {사용자|ROLE|PUBLIC,.., n} CASCADE
--CASCADE는 사용자가 다른 사용자에게 부여한 권한까지 취소시킴
  (확인 및 검증 후 작업)

REVOKE 권한 FROM 사용자; --권한을 사용자에게 부여
REVOKE 권한 ON 객체 FROM 사용자; -객체에 대한 권한을 사용자에게 부여
*************************************************/
--권한부여 : MADANG 유저의 BOOK 테이블에 대한 SELECT 권한을 MDGUEST 에게 부여
--(SYSTEM) 권한부여 - MADANG.BOOK 을 SELECT 할수 있도록 MDGUEST에게 권한 부여
SELECT * FROM MADANG.BOOK;
GRANT SELECT ON MADANG.BOOK TO MDGUEST;

--(SYSTEM) 권한회수, 권한취소
REVOKE SELECT ON MADANG.BOOK FROM MDGUEST;
-------------------
--(MADANG)유저에서 권한부여
GRANT SELECT ON BOOK TO MDGUEST; --MADANG에서 작업시 MADANG. 생략가능
GRANT SELECT ON MADANG.BOOK TO MDGUEST;

--(MADANG)유저에서  권한회수(취소)
REVOKE SELECT ON BOOK FROM MDGUEST;

--------------------------------------
--(MADANG) WITH GRANT OPTION : 다른 유저에게 권한 부여할 수 있도록 허용
GRANT SELECT, UPDATE ON CUSTOMER TO MDGUEST WITH GRANT OPTION;

--(MDGUEST) MYSTUDY 유저에게 MADANG.CUSTOMER SELECT 권한 부여
GRANT SELECT ON MADANG.CUSTOMER TO MYSTUDY;

--(MADANG)유저가 MDGUEST로 부터 권한취소(회수)
REVOKE SELECT, UPDATE ON CUSTOMER FROM MDGUEST;

--======================
--(SYSTEM) 유저삭제
DROP USER MDGUEST CASCADE; --테이블등 소유하고 있는 Object 있는 경우 CASCADE 처리


