/* 비교구문(분기처리) IF 문
IF (조건식) THEN ~ END IF;
IF (조건식) THEN ~ ELSE ~ END IF;
IF (조건식) THEN ~ ELSIF ~ ELSIF ~ ...ELSIF ~ ELSE ~ END IF;
********************/
-- 홀수, 짝수 판별
CREATE OR REPLACE PROCEDURE PRC_IF (
    IN_NUM IN NUMBER
) AS
BEGIN
    DBMS_OUTPUT.put_line('>> 입력값 : ' || IN_NUM);
    
    --홀, 짝 판별
    IF (MOD(IN_NUM, 2) = 0) THEN
        DBMS_OUTPUT.put_line(IN_NUM || ' - 짝수');
    ELSE 
        DBMS_OUTPUT.put_line(IN_NUM || ' - 홀수');
    END IF;
END;

----------------------
-- 4로 나눈 나머지 값 확인
create or replace PROCEDURE PRC_IF2 (
    IN_NUM IN NUMBER
) AS
BEGIN
    DBMS_OUTPUT.put_line('>> 입력값 : ' || IN_NUM);
    
    --4로 나눈 나머지 값 확인
    IF (MOD(IN_NUM, 4) = 0) THEN
        DBMS_OUTPUT.PUT_LINE('::첫번째 비교처리');
        DBMS_OUTPUT.PUT_LINE('4로 나눈 나머지 0');
    ELSIF (MOD(IN_NUM, 4) = 1) THEN
        DBMS_OUTPUT.PUT_LINE('4로 나눈 나머지 1');
    ELSIF (MOD(IN_NUM, 4) = 2) THEN
        DBMS_OUTPUT.PUT_LINE('4로 나눈 나머지 2');
    ELSE 
        DBMS_OUTPUT.PUT_LINE('4로 나눈 나머지 3');
    END IF;
END;

--=====================
-- 반복문 : FOR, WHILE
-- FOR 변수 IN [REVERSE] 시작값 .. 최종값 LOOP ~ END LOOP;
--------------
--숫자(N) 하나를 입력받아서 합계 출력(1~N 까지의 합)
DECLARE
    IN_NUM NUMBER(3) := 2;
    V_SUM NUMBER := 0; -- 합계 저장 변수(초기값 0 설정)
BEGIN
    --입력받은 숫자 확인
    DBMS_OUTPUT.PUT_LINE('>>입력값 : ' || IN_NUM);
    
    FOR I IN 1 .. IN_NUM LOOP
        DBMS_OUTPUT.PUT_LINE('I : ' || I);
        
        V_SUM := V_SUM + I;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('1 부터 '|| IN_NUM ||'까지의 합계 : '|| V_SUM);
END;

------------------
DECLARE
    IN_NUM NUMBER(3) := 10;
BEGIN
    --REVERSE : 큰숫자 -> 작은 숫자
    FOR I IN REVERSE 1 .. IN_NUM LOOP
        DBMS_OUTPUT.PUT_LINE('I : ' || I);
    END LOOP;
END;

--=======================
-- WHILE 문
-- WHILE (조건식) LOOP ~ END LOOP;
DECLARE
    I NUMBER := 1;
BEGIN

    WHILE (I <= 10) LOOP --실행조건(중단조건)
        DBMS_OUTPUT.PUT_LINE('WHILE I : ' || I);
        I := I + 1;
    END LOOP;

END;

--===================
/* LOOP ~ END LOOP;
LOOP
    EXIT WHEN (조건식);
END LOOP;
************************/
DECLARE
    I NUMBER(3) := 1;
BEGIN  
    LOOP
        DBMS_OUTPUT.PUT_LINE('LOOP I : ' || I);
        
        EXIT WHEN (I >= 10); --빠져나갈 조건
        I := I + 1;
    END LOOP;   
END;

--============================
/*(실습) 숫자를 하나 입력 받아서 1 ~ 숫자까지의 합계 구하기
프로시저명 : PRC_SUM_EVENODD
-- 입력값이 홀수면 홀수값만 더하고
-- 입력값이 짝수면 짝수값만 더해서
최종 합계값을 화면에 출력
<출력형태>
-- 입력숫자: 입력값, 홀수/짝수, 합계 : 합계결과
   출력예) 입력숫자 : 4, 짝수, 합계 : 6
   출력예) 입력숫자 : 5, 홀수, 합계 : 9
***********************/
CREATE OR REPLACE PROCEDURE PRC_SUM_EVENODD (
  IN_NUM IN NUMBER 
) AS 
    V_EVEN_ODD VARCHAR2(10);
    V_SUM NUMBER := 0;
BEGIN
    -- 입력값 홀/짝 판별
    --짝수일때
    IF (MOD(IN_NUM, 2) = 0) THEN
        V_EVEN_ODD := '짝수';
        --짝수일때 짝수 값만 더하기
        FOR I IN 1 .. IN_NUM LOOP
            IF (MOD(I, 2) = 0) THEN
                DBMS_OUTPUT.PUT_LINE('I :' || I);
                V_SUM := V_SUM + I;
            END IF;
        END LOOP;
    END IF;
    
    --홀수일때
    IF (MOD(IN_NUM, 2) != 0) THEN
        V_EVEN_ODD := '홀수';
        --홀수일때 홀수 값만 더하기
        FOR I IN 1 .. IN_NUM LOOP
            IF (MOD(I, 2) != 0) THEN
                DBMS_OUTPUT.PUT_LINE('I :' || I);
                V_SUM := V_SUM + I;
            END IF;
        END LOOP;
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('입력숫자 : '|| IN_NUM || ', ' || 
            V_EVEN_ODD || ', 합계 : ' || V_SUM);
END PRC_SUM_EVENODD;
    
--------------------
create or replace PROCEDURE PRC_SUM_EVENODD2 (
  IN_NUM IN NUMBER 
) AS 
    V_EVEN_ODD VARCHAR2(10) := '홀수';
    V_SUM NUMBER := 0;
    V_MOD NUMBER(1) := 0;
BEGIN
    -- 입력값 홀/짝 판별
    V_MOD := MOD(IN_NUM, 2); -- 0, 1
    IF (V_MOD = 0) THEN
        V_EVEN_ODD := '짝수';
    END IF;
    
    --짝수일때 짝수합, 홀수일때 홀수 합계 구하기
    FOR I IN 1 .. IN_NUM LOOP
        IF (MOD(I, 2) = V_MOD) THEN
            V_SUM := V_SUM + I;
        END IF;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('입력숫자 : '|| IN_NUM || ', ' || 
            V_EVEN_ODD || ', 합계 : ' || V_SUM);
END;















