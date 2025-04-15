/* ************************
뷰(VIEW) : 하나 또는 둘 이상의 테이블로 부터
   데이터의 부분집합을 테이블인 것처럼 사용하는 객체(가상테이블)
--뷰(VIEW) 생성문
CREATE [OR REPLACE] VIEW 뷰이름 [(컬럼별칭1, 컬럼별칭2, ..., 컬럼별칭n)]
AS
SELECT 문장
[옵션];

--읽기전용 옵션 : WITH READ ONLY

--뷰(VIEW) 삭제
DROP VIEW 뷰이름;
***************************/
SELECT * FROM BOOK WHERE BOOKNAME LIKE '%축구%';
-- 뷰(VIEW) 만들기
CREATE VIEW VW_BOOK
AS
SELECT * FROM BOOK 
WHERE BOOKNAME LIKE '%축구%'
WITH READ ONLY
;

-- 뷰 사용해서 데이터 검색
SELECT * FROM VW_BOOK;
SELECT * FROM (SELECT * FROM BOOK WHERE BOOKNAME LIKE '%축구%');

SELECT * FROM VW_BOOK
WHERE PUBLISHER = '굿스포츠'
;

SELECT * FROM BOOK
WHERE PUBLISHER = '굿스포츠'
;
--=============================
--뷰(VIEW) 생성 - 컬럼별칭(alias) 사용
CREATE OR REPLACE VIEW VW_BOOK2
    (BID, BNAME, PUB, PRICE)
AS
SELECT * FROM BOOK 
WHERE BOOKNAME LIKE '%축구%'
WITH READ ONLY
;
SELECT * FROM VW_BOOK2 WHERE PUB = '굿스포츠';
--------------------
CREATE OR REPLACE VIEW VW_BOOK3
    (BNAME, PUB, PRICE)
AS
SELECT BOOKNAME, PUBLISHER, PRICE FROM BOOK 
WHERE BOOKNAME LIKE '%축구%'
WITH READ ONLY
;
-- 뷰 삭제(DROP VIEW)
DROP VIEW VW_BOOK;

--==========================
CREATE OR REPLACE VIEW VW_ORDERS
AS
SELECT O.*
     , B.BOOKNAME, B.PUBLISHER, B.PRICE
     , C.NAME, C.ADDRESS, C.PHONE
FROM ORDERS O, BOOK B, CUSTOMER C
WHERE O.BOOKID = B.BOOKID
  AND O.CUSTID = C.CUSTID
WITH READ ONLY  
;

SELECT * FROM VW_ORDERS WHERE PUBLISHER = '굿스포츠';
SELECT * FROM VW_ORDERS WHERE NAME = '박지성';
SELECT * FROM VW_ORDERS WHERE BOOKNAME LIKE '%축구%';

--=========================
--(실습) 뷰를 생성, 조회, 삭제
--1. 뷰생성 - 뷰명칭 : VW_ORD_ALL
---- 주문(판매)정보, 책정보, 고객정보 모두 조회할 수 있는 형태 뷰 
--2. 이상미디어에서 출판한 책중 판매된 책제목, 판매금액, 판매일 조회
--3. 이상미디어에서 출판한 책 중에서 추신수, 장미란이 구매한 책 정보 조회
---- 출력항목 : 구입한 사람이름, 책제목, 출판사, 원가(정가), 판매가, 판매일자
---- 정렬 : 구입한 사람이름, 구입일자 최근순
--4. 판매된 책에 대하여 구매자별 건수, 합계금액, 평균금액, 최고가, 최저가 조회
--(최종) 뷰삭제 : VW_ORD_ALL 삭제 처리
--==========================
CREATE OR REPLACE VIEW VW_ORD_ALL
AS
SELECT O.ORDERID, O.CUSTID, C.NAME
     , O.BOOKID, B.BOOKNAME, B.PUBLISHER, B.PRICE, O.SALEPRICE, O.ORDERDATE
     , C.ADDRESS, C.PHONE
FROM BOOK B, CUSTOMER C, ORDERS O
WHERE B.BOOKID = O.BOOKID
  AND C.CUSTID = O.CUSTID
WITH READ ONLY  
;
SELECT * FROM vw_ord_all;
--2. 이상미디어에서 출판한 책중 판매된 책제목, 판매금액, 판매일 조회
SELECT BOOKNAME, PUBLISHER, SALEPRICE, ORDERDATE
FROM vw_ord_all
WHERE publisher = '이상미디어'
;

--3. 이상미디어에서 출판한 책 중에서 추신수, 장미란이 구매한 책 정보 조회
---- 출력항목 : 구입한 사람이름, 책제목, 출판사, 원가(정가), 판매가, 판매일자
---- 정렬 : 구입한 사람이름, 구입일자 최근순
SELECT NAME, BOOKNAME, PUBLISHER, PRICE, SALEPRICE, ORDERDATE
FROM vw_ord_all
WHERE publisher = '이상미디어'
  AND NAME IN ('추신수', '장미란')
ORDER BY NAME, ORDERDATE DESC 
;

--4. 판매된 책에 대하여 구매자별 건수, 합계금액, 평균금액, 최고가, 최저가 조회
SELECT CUSTID, NAME
     , COUNT(*) AS TOTAL_COUNT
     , SUM(SALEPRICE) AS SUM_PRICE
     , TRUNC(AVG(SALEPRICE)) AS AVG_PRICE
     , MAX(SALEPRICE) AS MAX_PRICE
     , MIN(SALEPRICE) AS MIN_PRICE
FROM VW_ORD_ALL
GROUP BY CUSTID, NAME
ORDER BY SUM_PRICE DESC
;

--(최종) 뷰삭제 : VW_ORD_ALL 삭제 처리
DROP VIEW VW_ORD_ALL;









