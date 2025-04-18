/****** HR 데이타 조회 문제3 ****************
/*1■ HR 부서의 어떤 사원은 급여정보를 조회하는 업무를 맡고 있다. 
  Tucker 사원 보다 급여를 많이 받고 있는 사원의 
  이름과 성(Name으로 별칭), 업무, 급여를 출력하시오
*****************************************************/
SELECT LAST_Name AS 별칭, JOB_ID AS 업무 , Salary AS 급여
FROM Employees
WHERE Salary > (SELECT Salary FROM Employees WHERE LAST_Name = 'Tucker');


/*2■ 사원의 급여 정보 중 업무별 최소 급여를 받고 있는 사원의 
  이름과 성(Name으로별칭), 업무, 급여, 입사일을 출력하시오
********************************************************/
SELECT 
    E.FIRST_NAME AS Name,
    E.JOB_ID,
    E.SALARY,
    E.HIRE_DATE
FROM 
     EMPLOYEES E
JOIN (
    SELECT 
        JOB_ID, 
        MIN(SALARY) AS MIN_SALARY
    FROM 
        EMPLOYEES 
    GROUP BY JOB_ID
)
M ON E.JOB_ID = M.JOB_ID AND E.SALARY = M.MIN_SALARY;



/*3■ 소속 부서의 평균 급여보다 많은 급여를 받는 사원의 
  이름과 성(Name으로 별칭), 급여, 부서번호, 업무를 출력하시오
***********************************************************/
SELECT e.FIRST_Name ||','|| LAST_NAME AS 별칭, e.Salary AS 급여, e.Department_ID AS 부서번호, e.JOB_ID AS 업무
FROM Employees e
WHERE e.Salary > (
    SELECT AVG(e2.Salary)
    FROM Employees e2
    WHERE e2.Department_ID = e.Department_ID
    )
    ;


/*4■ 모든 사원의 소속부서 평균연봉을 계산하여 사원별로 이름과 성(Name으로 별칭),
  업무, 급여, 부서번호, 부서평균연봉(Department Avg Salary로 별칭)을 출력하시오
***************************************************************/
SELECT 
    e.FIRST_NAME ||','|| LAST_Name AS Name,
    e.Job_ID AS Job,
    e.Salary AS Salary,
    e.Department_ID AS DepartmentID,
    D.Department_ID_AVG_SALARY AS "Department Avg Salary"
FROM 
    Employees e
JOIN (
    SELECT 
       Department_ID,
        ROUND(AVG(SALARY), 2) AS Department_ID_AVG_SALARY
    FROM 
        EMPLOYEES
    GROUP BY 
        DEPARTMENT_ID
) D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;


/*5■ HR 스키마에 있는 Job_history 테이블은 사원들의 업무 변경 이력을 나타내는 테이블이다. 
  이 정보를 이용하여 모든 사원의 현재 및 이전의 업무 이력 정보를 출력하고자 한다. 
  중복된 사원정보가 있으면 한 번만 표시하여 출력하시오
  (사원번호, 업무)
*********************************************************************/
SELECT 
    E.EMPLOYEE_ID,        -- 사원번호
    E.JOB_ID AS "Current Job"   -- 현재 업무
FROM 
    EMPLOYEES E
UNION  -- UNION은 중복을 제거
SELECT 
    J.EMPLOYEE_ID,        -- 사원번호
    J.JOB_ID AS "Previous Job"  -- 이전 업무
FROM 
    JOB_HISTORY J;

/*6■ 위 문제에서 각 사원의 업무 이력 정보를 확인하였다. 하지만 '모든 사원의
  업무 이력 전체'를 보지는 못했다. 여기에서는 모든 사원의 
  업무 이력 변경 정보(JOB_HISTORY) 및 업무변경에 따른 부서정보를 
  사원번호가 빠른 순서대로 출력하시오(집합연산자 UNION)
  (사원번호, 부서정보, 업무)
**********************************************************************/
SELECT 
    EMPLOYEE_ID,
    DEPARTMENT_ID,
    JOB_ID
FROM 
    JOB_HISTORY

UNION

SELECT 
    EMPLOYEE_ID,
    DEPARTMENT_ID,
    JOB_ID
FROM 
    EMPLOYEES

ORDER BY 
    EMPLOYEE_ID;
  
/*7■ HR 부서에서는 신규 프로젝트를 성공으로 이끈 해당 업무자들의 
  급여를 인상 하기로 결정하였다. 
  사원은 현재 107명이며 19개의 업무에 소속되어 근무 중이다. 
  급여 인상 대상자는 회사의 업무(Distinct job_id) 중 다음 5개 업무에서 
  일하는 사원에 해당된다. 나머지 업무에 대해서는 급여가 동결된다. 
  5개 업무의 급여 인상안은 다음과 같다.
  HR_REP(10%), MK_REP(12%), PR_REP(15%), SA_REP(18%), IT_PROG(20%)
**********************************************************************/

/*8■ HR 부서에서는 최상위 입사일에 해당하는 2001년부터 2003년까지 입사자들의 급여를 
  각각 5%, 3%, 1% 인상하여 지분에 따른 배당금으로 지급하고자 한다. 
  전체 사원들 중 해당 년도에 해당하는 사원들의 급여를 검색하여 적용하고, 
  입사일자에 따른 오름차순 정렬을 수행하시오
**********************************************************************/

/*9■ 부서별 급여 합계를 구하고, 그 결과를 다음과 같이 표현하시오.
  Sum Salary > 100000 이면, "Excellent"
  Sum Salary > 50000 이면, "Good"
  Sum Salary > 10000 이면, "Medium"
  Sum Salary <= 10000 이면, "Well"
**********************************************************************/

/*10■ 2005년 이전에 입사한 사원 중 업무에 "MGR"이 포함된 사원은 15%, 
  "MAN"이 포함된 사원은 20% 급여를 인상한다. 
  또한 2005년부터 근무를 시작한 사원 중 "MGR"이 포함된 사원은 25% 급여를 인상한다. 
  이를 수행하는 쿼리를 작성하시오
**********************************************************************/

/*11■ 월별로 입사한 사원 수 출력
  (방식1) 월별로 입사한 사원 수가 아래와 같이 각 행별로 출력되도록 하시오(12행).
  1월 xx
  2월 xx
  3월 xx
  ..
  12월 xx
  합계 XXX
**********************************************************************/  
---------------------------------------------------------
/* (방식2) 첫 행에 모든 월별 입사 사원 수가 출력되도록 하시오
  1월 2월 3월 4월 .... 11월 12월
  xx  xx  xx xx  .... xx   xx
**********************************************************************/







