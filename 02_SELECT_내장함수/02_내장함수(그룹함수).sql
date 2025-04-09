/* 내장함수 : 오라클 DBMS에서 제공하는 함수(FUNCTION)
그룹함수 : 하나 이상의 행을 그룹으로 묶어서 연산
COUNT(*) : 데이터 갯수 조회(전체 컬럼에 대하여)
COUNT(컬럼명) : 데이터 갯수 조회(지정된 컬럼만 대상으로)
SUM(컬럼명) : 합계값 구하기
AVG(컬럼명) : 평균값 구하기
MAX(컬럼명) : 최대값 구하기
MIN(컬럼명) : 최소값 구하기
******************************/
SELECT * FROM BOOK;
SELECT COUNT(*) FROM BOOK; --테이블 데이터 전체 건수 확인

SELECT * FROM CUSTOMER;
SELECT COUNT(*) FROM CUSTOMER; -- 5건 조회
SELECT COUNT(CUSTID) FROM CUSTOMER; -- 5건 조회
SELECT COUNT(NAME) FROM CUSTOMER; -- 5건 조회
SELECT COUNT(PHONE) FROM CUSTOMER; -- 4건 조회, NULL 값은 제외됨
--------
-- PHONE 컬럼 값이 NULL 인 데이터 건수
SELECT COUNT(*) FROM CUSTOMER WHERE PHONE IS NULL; --1건
-- PHONE 컬럼 값이 NULL 이 아닌 데이터 건수
SELECT COUNT(*) FROM CUSTOMER WHERE PHONE IS NOT NULL; -- 4건
SELECT COUNT(PHONE) FROM CUSTOMER; -- 4건

---------------------------
--SUM(컬럼명) : 합계값 구하기
SELECT * FROM BOOK;
SELECT SUM(PRICE) FROM BOOK; --144500

--(실습)대한미디어, 이상미디어 출판사에서 출판한 모든 책 금액 합계
SELECT SUM(PRICE) AS SUM_PRICE
FROM BOOK
WHERE PUBLISHER IN ('대한미디어', '이상미디어')
;

--AVG(컬럼명) : 평균값 구하기
--(실습)대한미디어, 이상미디어 출판사에서 출판한 모든 책 평균 금액
SELECT AVG(PRICE) AVG_PRICE
FROM BOOK
WHERE PUBLISHER IN ('대한미디어', '이상미디어')
;
--MAX(컬럼명) : 최대값 구하기
--MIN(컬럼명) : 최소값 구하기
--(실습)굿스포츠 출판한 책중 최고가, 최저가 구하기
SELECT MAX(PRICE), MIN(PRICE)
FROM BOOK
WHERE PUBLISHER = '굿스포츠'
;
--(실습)책제목(도서명)에 대하여 MIN, MAX 값은 무엇인지 확인
SELECT MIN(BOOKNAME), MAX(BOOKNAME) FROM BOOK;
SELECT * FROM BOOK ORDER BY BOOKNAME;

--(실습)출판된 책 갯수(권수), 합계금액, 평균금액, 가장비싼책값, 가장싼책값
SELECT COUNT(*), SUM(PRICE), AVG(PRICE), MAX(PRICE), MIN(PRICE)
FROM BOOK
;





