/* ** 실습문제 : HR유저(DB)에서 요구사항 해결 **********
--1) 사번(employee_id)이 100인 직원 정보 전체 보기
--2) 월급(salary)이 15000 이상인 직원의 모든 정보 보기
--3) 월급이 15000 이상인 사원의 사번, 이름(LAST_NAME), 입사일(hire_date), 월급여 정보 보기
--4) 월급이 10000 이하인 사원의 사번, 이름(LAST_NAME), 입사일, 월급여 정보 보기
---- (급여가 많은 사람부터)
--5) 이름(first_name)이 john인 사원의 모든 정보 조회
--6) 이름(first_name)이 john인 사원은 몇 명인가?
--7) 2008년에 입사한 사원의 사번, 성명('first_name last_name'), 월급여 정보 조회
---- 성명 출력예) 'Steven King'
--8) 월급여가 20000~30000 구간인 직원 사번, 성명(last_name first_name), 월급여 정보 조회
--9) 관리자ID(MANAGER_ID)가 없는 사람 정보 조회
--10) 직종(job_id)코드 'IT_PROG'에서 가장 많은 월급여는 얼마
--------------------
--11) 직종별 최대 월급여 검색
--12) 직종별 최대 월급여 검색하고, 최대 월급여가 10000이상인 직종 조회
--13) 직종별 평균급여 확인하고 8000 이상인 직종명과 평균급여
--14) 직종별 인원수, 급여합계, 평균급여, 가장 적은 급여, 가장 많은 급여를 구하시오
--15) 부서별 인원수, 급여합계, 평균급여, 가장 적은 급여, 가장 많은 급여를 구하시오
--16) 입사년도별 인원수 확인
-------
--17) 직종별 평균급여 이상인 직원을 찾아 사번, 성명, 직종, 급여, 직종별평균급여를 구하시오
---- (직종코드, 급여 순으로 정렬)
****************************/
--7) 2008년에 입사한 사원의 사번, 성명('first_name last_name'), 월급여 정보 조회
---- 성명 출력예) 'Steven King'
SELECT EMPLOYEE_ID, FIRST_NAME || ' ' || LAST_NAME AS NAME
     , SALARY, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE >= TO_DATE('2008-01-01', 'YYYY-MM-DD')
  AND HIRE_DATE <= TO_DATE('2008-12-31', 'YYYY-MM-DD')
ORDER BY HIRE_DATE
;

SELECT EMPLOYEE_ID, FIRST_NAME || ' ' || LAST_NAME AS NAME
     , SALARY, HIRE_DATE, TO_CHAR(HIRE_DATE, 'YYYY')
FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE, 'YYYY') = '2008'
ORDER BY HIRE_DATE
;
--8) 월급여가 15000~20000 구간인 직원 사번, 성명(last_name first_name), 월급여 정보 조회
SELECT EMPLOYEE_ID, FIRST_NAME || ' ' || LAST_NAME AS NAME, SALARY
FROM EMPLOYEES
WHERE SALARY >= 15000 AND SALARY <= 30000
ORDER BY SALARY
;
SELECT EMPLOYEE_ID, FIRST_NAME || ' ' || LAST_NAME AS NAME, SALARY
FROM EMPLOYEES
WHERE SALARY BETWEEN 20000 AND 30000
ORDER BY SALARY
;
-----------------
--17) 직종별 평균급여 이상인 직원을 찾아 사번, 성명, 직종, 급여, 직종별평균급여를 구하시오
---- (직종코드, 급여 순으로 정렬)

--IT_PROG 직종의 평균급여보다 많이 받는 IT_PROG 직종 직원의 
--사번, 성명, 직종, 급여, 직종별평균급여 구하시오
SELECT AVG(SALARY)
FROM EMPLOYEES
WHERE JOB_ID = 'IT_PROG'
;
--IT_PROG 직종 평균급여 : 5760
SELECT *
FROM EMPLOYEES
WHERE JOB_ID = 'IT_PROG'
  AND SALARY >= 5760
;

--직종별 평균급여
CREATE TABLE JOB_AVG AS
SELECT JOB_ID, AVG(SALARY) AVG_SALARY
FROM EMPLOYEES
GROUP BY JOB_ID
;
-------------------
--17) 직종별 평균급여 이상인 직원을 찾아 사번, 성명, 직종, 급여, 직종별평균급여를 구하시오
---- (직종코드, 급여 순으로 정렬)
SELECT EMPLOYEE_ID, FIRST_NAME || ' ' || LAST_NAME AS NAME
     , E.JOB_ID, SALARY, AVG_SALARY
FROM EMPLOYEES E, 
     (SELECT JOB_ID, AVG(SALARY) AVG_SALARY
      FROM EMPLOYEES
      GROUP BY JOB_ID) A --조인테이블
WHERE E.JOB_ID = A.JOB_ID   --조인조건
  AND E.SALARY >= A.AVG_SALARY
ORDER BY E.JOB_ID, E.SALARY  
;
------
-- 전 직원 평균 급여보다 많이 받는 사람
SELECT EMPLOYEE_ID, FIRST_NAME || ' ' || LAST_NAME AS NAME
     , JOB_ID, SALARY
     , (SELECT ROUND(AVG(SALARY)) FROM EMPLOYEES) COMPANY_AVG_SALARY
FROM EMPLOYEES
WHERE SALARY >= (SELECT ROUND(AVG(SALARY)) FROM EMPLOYEES)
ORDER BY SALARY
;
------------
-- 상관 서브쿼리 방식으로 찾기
--직종별 평균급여 이상인 직원을 찾아 사번, 성명, 직종, 급여, 직종별평균급여를 구하시오
SELECT EMPLOYEE_ID, FIRST_NAME || ' ' || LAST_NAME AS NAME
     , JOB_ID, SALARY
FROM EMPLOYEES E
WHERE SALARY >= (SELECT ROUND(AVG(SALARY)) FROM EMPLOYEES WHERE JOB_ID = E.JOB_ID) --현재 처리중인 직원과 동일직종 평균급여
ORDER BY JOB_ID, SALARY
;





