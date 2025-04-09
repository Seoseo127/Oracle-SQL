/******************************* 
오라클의 내장함수 - 문자열, 숫자, 날짜 관련 함수
<문자열 관련 내장함수>
UPPER : 대문자로 변경
LOWER : 소문자로 변경
INITCAP : 첫 글자만 대문자로 나머지는 소문자
LENGTH : 문자열의 길이(문자단위)
LENGTHB : 문자열의 길이(BYTE 단위)
SUBSTR(대상, 시작위치, 길이) : 문자열의 일부 추출
   (시작위치는 1부터 시작, 오른쪽에서 시작하는 경우 마이너스(-)값 사용)
INSTR(대상, 찾는문자) : 대상문자열에 찾는문자 위치값 리턴
INSTR(대상, 찾는문자, 시작위치)
INSTR(대상, 찾는문자, 시작위치, nth) : nth 찾은값의 순서값(3 : 3번째 찾은 값)
TRIM('문자열') : 양쪽 공백 제거
LTRIM('문자열') : 왼쪽에 있는 공백 제거
RTRIM('문자열') : 오른쪽에 있는 공백 제거
CONCAT(문자열1, 문자열2) : 문자열 연결 - 문자열1 || 문자열2
LPAD(대상문자열, 전체글자수, 삽입될문자) : 왼쪽에 삽입
RPAD(대상문자열, 전체글자수, 삽입될문자) : 오른쪽에 삽입
REPLACE(대상문자열, 찾을문자, 변경문자) : 문자열에서 찾은문자를 변경
********************************/
--UPPER : 대문자로 변경
--LOWER : 소문자로 변경
--INITCAP : 첫 글자만 대문자로 나머지는 소문자
SELECT BOOKNAME, UPPER(BOOKNAME) FROM BOOK ORDER BY BOOKNAME;
SELECT BOOKNAME, LOWER(BOOKNAME) FROM BOOK ORDER BY BOOKNAME;
SELECT BOOKNAME, INITCAP(BOOKNAME) FROM BOOK ORDER BY BOOKNAME;
SELECT INITCAP('olympic champions') FROM DUAL; --Olympic Champions
SELECT INITCAP('OLYMPIC CHAMPIONS') FROM DUAL; --Olympic Champions
-------

--LENGTH : 문자열의 길이(문자단위)
--LENGTHB : 문자열의 길이(BYTE 단위)
SELECT LENGTH('ABCDE123#@') FROM DUAL; --문자단위 : 10글자
SELECT LENGTHB('ABCDE123#@') FROM DUAL; --BYTE단위 : 10 byte

SELECT LENGTH('홍길동') FROM DUAL; --문자단위 : 3글자
SELECT LENGTHB('홍길동') FROM DUAL; --BYTE단위 : 9 byte (UTF-8 기준)

-----------
--SUBSTR(대상, 시작위치, 길이) : 문자열의 일부 추출
--   (시작위치는 1부터 시작, 오른쪽에서 시작하는 경우 마이너스(-)값 사용)
SELECT SUBSTR('홍길동123456', 1) FROM DUAL; --홍길동123456 : 첫글자부터 끝까지
SELECT SUBSTR('홍길동123456', 4) FROM DUAL; --123456
SELECT SUBSTR('홍길동123456', 1, 3) FROM DUAL; --홍길동 : 첫번째부터 3개
SELECT SUBSTR('홍길동123456', -3) FROM DUAL; --456 : 뒤에서 3번째부터 끝까지
SELECT SUBSTR('홍길동123456', -6) FROM DUAL; --123456
SELECT SUBSTR('홍길동123456', -3, 3) FROM DUAL; --456 : 뒤에서 3번째부터 3개
SELECT SUBSTR('홍길동123456', -3, 2) FROM DUAL; --45 : 뒤에서 3번째부터 2개 추출

------------------  
--INSTR(대상, 찾는문자) : 대상문자열에 찾는문자 위치값 리턴
--INSTR(대상, 찾는문자, 시작위치)
--INSTR(대상, 찾는문자, 시작위치, nth) : nth 찾은값의 순서값(3 : 3번째 찾은 값)
SELECT INSTR('950101-1234567', '-') FROM DUAL; -- 7번째 위치값 리턴
SELECT INSTR('950101-1234567', '*') FROM DUAL; -- 0리턴 : 없을 때
SELECT INSTR('950101-1234567', '345') FROM DUAL; --10
SELECT INSTR('950101-1234567', '1') FROM DUAL;    --4
SELECT INSTR('950101-1234567', '1', 7) FROM DUAL; --8
SELECT INSTR('950101-1234567', '1', 1, 2) FROM DUAL; --6 : 처음부터 찾되 2번째 찾은 위치

-----------------------
--TRIM('문자열') : 양쪽 공백 제거
--LTRIM('문자열') : 왼쪽에 있는 공백 제거
--RTRIM('문자열') : 오른쪽에 있는 공백 제거
SELECT '   TEST    ', '-' || TRIM('   TEST    ') || '-' FROM DUAL;
SELECT '   TEST    ', '-' || LTRIM('   TEST    ') || '-' FROM DUAL;
SELECT '   TEST    ', '-' || RTRIM('   TEST    ') || '-' FROM DUAL;

---------------
--CONCAT(문자열1, 문자열2) : 문자열 연결 - 문자열1 || 문자열2
SELECT CONCAT('HELLO ', 'WORLD') FROM DUAL;
SELECT 'HELLO ' || 'WORLD' || '~~~' FROM DUAL;
SELECT CONCAT(CONCAT('HELLO ', 'WORLD'), '~~~')  FROM DUAL;

---------------
--LPAD(대상문자열, 전체글자수, 삽입될문자) : 왼쪽에 삽입
--RPAD(대상문자열, 전체글자수, 삽입될문자) : 오른쪽에 삽입
SELECT LPAD('HELLO', 10) FROM DUAL;      --     HELLO 좌측 5공백(스페이스)
SELECT LPAD('HELLO', 10, '*') FROM DUAL; --*****HELLO

SELECT RPAD('HELLO', 10) FROM DUAL; 
SELECT RPAD('HELLO', 10, '*') FROM DUAL;  --HELLO*****
SELECT RPAD('HELLO', 10, '@#') FROM DUAL; --HELLO@#@#@
----------------
--REPLACE(대상문자열, 찾을문자, 변경문자) : 문자열에서 찾은문자를 변경
SELECT 'HELLO ORACLE', REPLACE('HELLO ORACLE', 'O', 'M') FROM DUAL;
SELECT 'HELLO ORACLE ORACLE', REPLACE('HELLO ORACLE ORACLE', 'ORACLE', 'WORLD') FROM DUAL;




