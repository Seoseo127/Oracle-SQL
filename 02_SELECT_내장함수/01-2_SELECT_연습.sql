--=====================================
--(실습문제)
--1. 출판된 책 전체 조회(정렬: 출판사, 금액순)
--2. 굿스포츠에서 출판한 책을 책 제목 순으로 조회
--3. 출판된 책 중 10000원 이상인 책(가격순-큰금액부터)
--4. 성이 '김'씨인 고객의 이름과 주소
--5. 성이 '박'이고 이름이 '성'으로 끝나는 고객의 이름과 주소
--6. 책 제목 '야구' 부터 '축구' 까지를 검색하기(책제목으로 정렬)
---- (단, '역도' 관련도서는 제외)
--7. 박지성의 총 구매액(CUSTID = 1)
--8. 박지성이 구매한 도서의 수
--======================================
SELECT * FROM BOOK
WHERE PUBLISHER = '굿스포츠'
ORDER BY BOOKNAME;
--3. 출판된 책 중 10000원 이상인 책(가격순-큰금액부터)
SELECT * FROM BOOK
WHERE PRICE >= 10000
ORDER BY PRICE DESC;
--4. 성이 '김'씨인 고객의 이름과 주소
SELECT NAME, ADDRESS FROM CUSTOMER
WHERE NAME LIKE '김%';

--5. 성이 '박'이고 이름이 '성'으로 끝나는 고객의 이름과 주소
SELECT NAME, ADDRESS FROM CUSTOMER
WHERE NAME LIKE '박%성';

--6. 책 제목 '야구' 부터 '축구' 까지를 검색하기(책제목으로 정렬)
---- (단, '역도' 관련도서는 제외)
SELECT * FROM BOOK
WHERE BOOKNAME >= '야구' AND BOOKNAME <= '축구'
    AND BOOKNAME NOT LIKE '%역도%'
ORDER BY BOOKNAME;

--7. 박지성의 총 구매액(CUSTID = 1)
SELECT CUSTID FROM CUSTOMER 
WHERE NAME ='박지성'; --CUSTID :1

SELECT SALEPRICE FROM ORDERS
WHERE CUSTID = 1;
SELECT 6000 +21000 +12000 FROM DUAL; --39000: 수작업으로 해결

--8. 박지성이 구매한 도서의 수
SELECT * FROM ORDERS WHERE CUSTID = 1; -- 3건(권)

SELECT COUNT(*)
FROM ORDERS
WHERE CUSTID = 1;
-------------------------------





