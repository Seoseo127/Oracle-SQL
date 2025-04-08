-- SYSTEM 유저에서 USER 생성
-- USER 생성 SQL
-- USER SQL
CREATE USER "MYSTUDY" IDENTIFIED BY "mystudypw"  
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

-- QUOTAS
ALTER USER "MYSTUDY" QUOTA UNLIMITED ON "SYSTEM";
ALTER USER "MYSTUDY" QUOTA UNLIMITED ON "SYSAUX";
ALTER USER "MYSTUDY" QUOTA UNLIMITED ON "USERS";

-- ROLES
GRANT "CONNECT" TO "MYSTUDY" ;
GRANT "RESOURCE" TO "MYSTUDY" ;

-- SYSTEM PRIVILEGES

