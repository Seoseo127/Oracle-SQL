--테이블조인(JOIN) : 2개 이상의 테이블 데이터를 연결(JOIN)해서 함께 사용
-- (1개의 테이블처럼 사용)
SELECT * FROM ORDERS WHERE CUSTID = 1;
SELECT * FROM CUSTOMER WHERE CUSTID = 1;

--ORDERS, CUSTOMER 테이블 데이터 동시 조회 (검색)
SELECT * 
FROM ORDERS, CUSTOMER --조인테이블임
WHERE ORDERS.CUSTID = CUSTOMER.CUSTID --조인조건임
AND CUSTOMER.NAME = '박지성'
;

----------
--테이블  
SELECT *
FROM ORDERS O, CUSTOMER C --조인테이블(별칭사용)
WHERE O.CUSTID = C.CUSTID --조인조건
    AND C.NAME = '박지성' --선택조건(찾을조건)
;

--표준(ANSI) 조인 쿼리문
SELECT *
FROM ORDERS O INNER JOIN CUSTOMER C --조인테이블
        ON O.CUSTID = C.CUSTID                 -- 조인조건
WHERE C.NAME = '박지성'                        -- 선택조건(찾을조건)
;

----------------------
--판매된 책 목록 확인(BOOK, ORDERS)
SELECT * FROM BOOK;
SELECT * FROM ORDERS;

-- 출판한 책중 판매된 책 목록
-- 미디어로 끝나는 출판사
SELECT O.ORDERID, O.BOOKID
     , B.BOOKID AS B_BOOKID --(주의)동일컬럼명 2번 선택(사용) 안됨
     , B.BOOKNAME, B.PUBLISHER, B.PRICE
     , O.SALEPRICE, O.ORDERDATE
--SELECT *
FROM BOOK B, ORDERS O     --조인테이블
WHERE B.BOOKID = O.BOOKID -- 조인조건
--  AND B.PUBLISHER LIKE '%미디어'
--  AND B.PUBLISHER = '굿스포츠'
ORDER BY B.PUBLISHER, B.BOOKNAME
;
--========================
--(문제해결) 테이블 조인해서 요청한 데이터 찾기
--실습 : '야구를 부탁해'라는 책이 팔린 내역을 확인(책제목, 판매금액, 판매일자)
--실습 : '야구를 부탁해'라는 책이 몇 권이 팔렸는지 확인
--실습 : '추신수'가 구입한 책값과 구입일자를 확인(책값, 구입일자)
--실습 : '추신수'가 구입한 합계금액을 확인
--실습 : 박지성, 추신수가 구입한 내역을 확인(이름, 구입(판매)금액, 구입(판매)일자)
--=========================
--실습 : '야구를 부탁해'라는 책이 팔린 내역을 확인(책제목, 판매금액, 판매일자)
SELECT * FROM BOOK;
SELECT * FROM ORDERS;

SELECT BOOKNAME, SALEPRICE, ORDERDATE
FROM BOOK B, ORDERS O --조인테이블(별칭사용)
WHERE B.BOOKID = O.BOOKID --조인조건
    AND B.BOOKNAME = '야구를 부탁해' --선택조건(찾을조건)
;

--실습 : '야구를 부탁해'라는 책이 몇 권이 팔렸는지 확인
SELECT COUNT(*)
FROM BOOK B, ORDERS O --조인테이블(별칭사용)
WHERE B.BOOKID = O.BOOKID --조인조건
    AND B.BOOKNAME = '야구를 부탁해'
;

--실습 : '추신수'가 구입한 책값과 구입일자를 확인(책값, 구입일자)
SELECT O.SALEPRICE, O.ORDERDATE
FROM ORDERS O, CUSTOMER C --조인테이블(별칭사용)
WHERE O.CUSTID = C.CUSTID --조인조건
    AND C.NAME = '추신수'
    ;
--실습 : '추신수'가 구입한 합계금액을 확인
SELECT SUM (O.SALEPRICE)
FROM ORDERS O, CUSTOMER C --조인테이블(별칭사용)
WHERE O.CUSTID = C.CUSTID --조인조건
    AND C.NAME = '추신수'
    ;

--실습 : 박지성, 추신수가 구입한 내역을 확인(이름, 구입(판매)금액, 구입(판매)일자)
SELECT C.NAME, O.SALEPRICE, O.ORDERDATE
FROM ORDERS O, CUSTOMER C --조인테이블(별칭사용)
WHERE O.CUSTID = C.CUSTID --조인조건
    AND (C.NAME = '박지성' OR C.NAME ='추신수')
    ;
    
SELECT C.NAME, O.SALEPRICE, O.ORDERDATE
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID 
  AND C.NAME IN ('박지성', '추신수')
ORDER BY C.NAME, O.ORDERDATE  
;

--표준 SQL문으로
SELECT C.NAME, O.SALEPRICE, O.ORDERDATE
FROM CUSTOMER C INNER JOIN ORDERS O
     ON C.CUSTID = O.CUSTID
WHERE C.NAME IN ('박지성', '추신수')
ORDER BY C.NAME, O.ORDERDATE
;

--================================
--3개 테이블 조인하기 : BOOK, CUSTOMER, ORDERS
--고객명, 책제목, 출판사명, 정가, 판매가격, 판매일자
SELECT C.NAME, B.BOOKNAME, B.PUBLISHER
     , B.PRICE, O.SALEPRICE, O.SALEPRICE
--SELECT *
FROM ORDERS O, BOOK B, CUSTOMER C --조인테이블
WHERE O.BOOKID = B.BOOKID --조인조건
  AND O.CUSTID = C.CUSTID --조인조건
;
---------
-- 표준 SQL
SELECT C.NAME, B.BOOKNAME, B.PUBLISHER
     , B.PRICE, O.SALEPRICE, O.SALEPRICE
--SELECT *
FROM ORDERS O INNER JOIN BOOK B --조인테이블
     ON O.BOOKID = B.BOOKID     --조인조건
     INNER JOIN CUSTOMER C  --조인테이블
     ON O.CUSTID = C.CUSTID --조인조건
;
-----------------
SELECT C.NAME, B.BOOKNAME, B.PUBLISHER
     , B.PRICE, O.SALEPRICE, O.SALEPRICE
--SELECT *
FROM ORDERS O, BOOK B, CUSTOMER C --조인테이블
WHERE B.BOOKID = O.BOOKID  --조인조건
  AND O.CUSTID = C.CUSTID --조인조건
  ;
  
  --=============================
--(실습) BOOK, CUSTOMER, ORDERS 테이블 데이터 조회
--1.장미란이 구입한 책제목, 출판사, 구입가격, 구입일자
--2.장미란이 구입한 책 중에 2014-01-01 ~ 2014-07-08까지 구입한 내역
--3.'야구를 부탁해'라는 책을 구입한 사람과 구입일자를 확인
--4.추신수, 장미란이 구입한 책제목, 구입금액, 구입일자 확인
---- (정렬 : 고객명, 구입일자 순으로)
--5.추신수가 구입한 책갯수, 합계금액, 평균값, 가장 큰금액, 가장 작은금액
------------------------------------
--1.장미란이 구입한 책제목, 출판사, 구입가격, 구입일자
SELECT * FROM BOOK;
SELECT * FROM CUSTOMER;
SELECT * FROM ORDERS;

SELECT BOOKNAME, PUBLISHER, SALEPRICE
FROM BOOK B, CUSTOMER C, ORDERS O --조인테이블
WHERE C.CUSTID = O.CUSTID  --조인조건
  AND O.BOOKID = B.BOOKID --조인조건
  AND C.NAME ='장미란'
  ;
  
--2.장미란이 구입한 책 중에 2014-01-01 ~ 2014-07-08까지 구입한 내역 
//내가 한거(틀림)
SELECT O.ORDERDATE 
FROM BOOK B, CUSTOMER C, ORDERS O --조인테이블
WHERE C.CUSTID = O.CUSTID  --조인조건
  AND O.BOOKID = B.BOOKID --조인조건
  AND C.NAME ='장미란'
  AND O.ORDERDATE BETWEEN '2014-01-01' AND '2014-07-08'
  ;
  
SELECT C.NAME, B.BOOKNAME, B.PUBLISHER, O.SALEPRICE, O.ORDERDATE
FROM CUSTOMER C, ORDERS O, BOOK B
WHERE C.CUSTID = O.CUSTID
  AND O.BOOKID = B.BOOKID
  AND ORDERDATE >= TO_DATE('2014-01-01', 'YYYY-MM-DD') --날짜와 날짜 비교(타입 일치)
  AND ORDERDATE < TO_DATE('2014-07-09', 'YYYY-MM-DD') --7/9 이전까지
  AND C.NAME = '장미란'
ORDER BY ORDERDATE
  ;
--3.'야구를 부탁해'라는 책을 구입한 사람과 구입일자를 확인
SELECT C.NAME, B.BOOKNAME, B.PUBLISHER, O.SALEPRICE, O.ORDERDATE
--SELECT *
FROM CUSTOMER C, ORDERS O, BOOK B
WHERE C.CUSTID = O.CUSTID
  AND O.BOOKID = B.BOOKID
  AND B.BOOKNAME = '야구를 부탁해'
  ;
--4.추신수, 장미란이 구입한 책제목, 구입금액, 구입일자 확인
---- (정렬 : 고객명, 구입일자 순으로)
SELECT C.NAME, B.BOOKNAME, O.SALEPRICE, O.ORDERDATE
--SELECT *
FROM CUSTOMER C, ORDERS O, BOOK B
WHERE C.CUSTID = O.CUSTID
  AND O.BOOKID = B.BOOKID
  AND C.NAME IN ('추신수', '장미란')
ORDER BY C.NAME, O.ORDERDATE 
;
--5.추신수가 구입한 책갯수, 합계금액, 평균값, 가장 큰금액, 가장 작은금액
SELECT '추신수' AS NAME
     , COUNT(*), SUM(SALEPRICE), AVG(SALEPRICE), MAX(SALEPRICE), MIN(SALEPRICE)
FROM ORDERS O, CUSTOMER C
WHERE O.CUSTID = C.CUSTID
  AND C.NAME = '추신수'
;
----------------
--고객별 구입한 내역
SELECT C.NAME AS NAME
     , COUNT(*), SUM(SALEPRICE)
     , ROUND(AVG(SALEPRICE))
     , MAX(SALEPRICE), MIN(SALEPRICE)
FROM ORDERS O, CUSTOMER C
WHERE O.CUSTID = C.CUSTID
GROUP BY C.NAME