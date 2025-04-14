/* ===================
SELECT [* | DISTINCT] {컬럼명, 컬럼명, ...}
  FROM 테이블명
[WHERE 조건절]
[GROUP BY {컬럼명, ....}
    [HAVING 조건] ] --GROUP BY 절에 대한 조건
[ORDER BY {컬럼명 [ASC | DESC], ....}] --ASC : 오름차순(기본/생략가능)
                                       --DESC : 내림차순
************************** */
--GROUP BY : 데이터를 그룹핑해서 처리할 경우 사용
--GROUP BY 문을 사용하면 SELECT 항목은 
---- GROUP BY 절에 사용된 컬럼 또는 그룹함수(COUNT, SUM, AVG, MAX, MIN) 사용가능
---- 상수값 사용가능(하나의 문자열, 숫자, 날짜 데이터 등)
----------------------------------
-- HAVING 절은 단독으로 사용할 수 없고, 반드시 GROUP BY 절과 함께 사용(종속절)
-- HAVING 절 : GROUP BY 절에 의해서 만들어진 데이터에서 검색조건 부여
--============================================
SELECT COUNT(*)
     , SUM(PRICE), AVG(PRICE), MAX(PRICE), MIN(PRICE)
FROM BOOK
;
-- 출판사별 출판한 책 갯수 구하기
SELECT PUBLISHER, COUNT(*)
     , SUM(PRICE), AVG(PRICE), MAX(PRICE), MIN(PRICE)
FROM BOOK
GROUP BY PUBLISHER
;
-- 구매 고객별로 구매금액 합계를 구하시오
SELECT CUSTID, SUM(SALEPRICE)
FROM ORDERS
GROUP BY CUSTID
;
----이름표시 : 이름으로 그룹핑
SELECT C.NAME, SUM(O.SALEPRICE) AS SUM_PRICE
     , TRUNC(AVG(O.SALEPRICE)) AVG_PRICE
     , MIN(O.SALEPRICE) MIN_PRICE
     , MAX(O.SALEPRICE) MAX_PRICE
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID
GROUP BY C.NAME
--ORDER BY SUM(O.SALEPRICE) DESC --많이 구입한 금액부터
--ORDER BY 2 DESC --SELECT절의 2번째 컬럼으로 정렬
ORDER BY SUM_PRICE DESC  --컬럼별칭 사용방식 적용
;
---------------------------
--(실습) 고객명 기준으로 고객별 데이터 조회(건수,합계,평균,최소,최대)
----추신수, 장미란 고객 2명만 조회(검색)
SELECT C.NAME, COUNT(*)
     , SUM(O.SALEPRICE) AS SUM_PRICE
     , TRUNC(AVG(O.SALEPRICE)) AVG_PRICE
     , MIN(O.SALEPRICE) MIN_PRICE
     , MAX(O.SALEPRICE) MAX_PRICE
--SELECT *    
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID
  AND C.NAME IN ('장미란', '추신수')
GROUP BY C.NAME
;
--------------
SELECT C.NAME, COUNT(*)
     , SUM(O.SALEPRICE) AS SUM_PRICE
     , TRUNC(AVG(O.SALEPRICE)) AVG_PRICE
     , MIN(O.SALEPRICE) MIN_PRICE
     , MAX(O.SALEPRICE) MAX_PRICE
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID
GROUP BY C.NAME
HAVING C.NAME IN ('장미란', '추신수')
;

--표준SQL 

------------------------------
-- HAVING 절은 단독으로 사용할 수 없고, 반드시 GROUP BY 절과 함께 사용(종속절)
-- HAVING 절 : GROUP BY 절에 의해서 만들어진 데이터에서 검색조건 부여
---------------------
-- 3건 이상 구입한 고객 조회
SELECT C.NAME, COUNT(*)
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID
GROUP BY C.NAME
HAVING COUNT(*) >= 3  --그룹핑된 데이터에서 원하는 데이터 검색(찾을조건)
;
----------------
-- 구매한 책중에 20000원 이상인 책을 1권이라도 구입한 사람의 통계데이터
SELECT C.NAME, COUNT(*)
     , SUM(O.SALEPRICE) AS SUM_PRICE
     , TRUNC(AVG(O.SALEPRICE)) AVG_PRICE
     , MIN(O.SALEPRICE) MIN_PRICE
     , MAX(O.SALEPRICE) MAX_PRICE
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID
GROUP BY C.NAME
HAVING MAX(O.SALEPRICE) >= 20000 --2만원 이상인 책을 1권이라도 구입한 사람
;
------
SELECT C.NAME, COUNT(*)
     , SUM(O.SALEPRICE) AS SUM_PRICE
     , TRUNC(AVG(O.SALEPRICE)) AVG_PRICE
     , MIN(O.SALEPRICE) MIN_PRICE
     , MAX(O.SALEPRICE) MAX_PRICE
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID
  AND O.SALEPRICE >= 20000  --2만원 이상인 책만을 대상으로
GROUP BY C.NAME
;
--====================================
--(실습) 필요시 조인(JOIN)과 GROUP BY ~ HAVING 구문을 사용해서 처리
--1. 고객이 주문한 도서의 총판매건수, 판매액, 평균값, 최저가, 최고가 구하기
--2. 고객별로 주문한 도서의 총수량, 총판매액 구하기
--3. 고객의 이름과 고객이 주문한 도서의 판매가격을 검색
--4. 고객별로 주문한 모든 도서의 총 판매액을 구하고, 고객명으로 정렬
--5. 고객별로 주문한 건수, 합계금액, 평균금액을 구하고(3권 보다 적게 구입한 사람 검색)
--(번외) 고객 중 한 권도 구입 안 한 사람은 누구??
---------------------------
--1. 고객이 주문한 도서의 총판매건수, 판매액, 평균값, 최저가, 최고가 구하기
SELECT COUNT(*) AS TOTAL_COUNT -- 컬럼별칭(alias)
     , SUM(SALEPRICE) AS "판매액 합계" --한글 사용자제
     , AVG(SALEPRICE) AVG_PRICE
     , MIN(SALEPRICE) MIN_PRICE
     , MAX(SALEPRICE) MAX_PRICE
FROM ORDERS
;
--2. 고객별로 주문한 도서의 총수량, 총판매액 구하기
SELECT C.CUSTID, C.NAME, COUNT(*), SUM(O.SALEPRICE)
FROM ORDERS O, CUSTOMER C
WHERE O.CUSTID = C.CUSTID
GROUP BY C.CUSTID, C.NAME
;
--3. 고객의 이름과 고객이 주문한 도서의 판매가격을 검색
SELECT C.NAME, B.BOOKNAME, B.PRICE, O.SALEPRICE, o.orderdate
FROM ORDERS O, CUSTOMER C, BOOK B
WHERE O.CUSTID = C.CUSTID
  AND O.BOOKID = B.BOOKID
ORDER BY C.NAME, O.SALEPRICE
;
--4. 고객별로 주문한 모든 도서의 총 판매액을 구하고, 고객명으로 정렬
SELECT C.CUSTID, C.NAME, SUM(O.SALEPRICE) AS SUM_PRICE
FROM ORDERS O, CUSTOMER C
WHERE O.CUSTID = C.CUSTID
GROUP BY C.CUSTID, C.NAME
ORDER BY C.NAME
;
--5. 고객별로 주문한 건수, 합계금액, 평균금액을 구하고(3권 보다 적게 구입한 사람 검색)
SELECT C.CUSTID, C.NAME
     , COUNT(*) AS CNT
     , SUM(O.SALEPRICE) AS SUM_PRICE
     , TRUNC(AVG(O.SALEPRICE)) AS AVG_PRICE
FROM ORDERS O, CUSTOMER C
WHERE O.CUSTID = C.CUSTID
GROUP BY C.CUSTID, C.NAME
HAVING COUNT(*) < 3
;
--(번외) 고객 중 한 권도 구입 안 한 사람은 누구??
----고객 테이블에는 있는데, 주문(판매) 테이블에 없는 사람
SELECT CUSTID FROM CUSTOMER ORDER BY CUSTID;
-- DISTINCT : 중복값 없이(중복값은 1개씩만) 
SELECT DISTINCT CUSTID FROM ORDERS ORDER BY CUSTID;












