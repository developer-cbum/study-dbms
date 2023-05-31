/*VIEW*/
/*CREATE VIEW [이름] AS [쿼리문]*/

/*
 * 기존의 테이블을 그대로 놔둔 채 필요한 컬럼들 및 새로운 컬럼을 만든 가상 테이블.
 * 실제 데이터가 저장되는 것은 아니지만, VIEW를 통해서 데이터를 관리할 수 있다.
 * 
 * 
 * -독립성: 다른 곳에서 접근하지 못하도록 하는 성질
 * -편리성: 길고 복잡한 쿼리문을 매번 작성할 필요가 없다
 * -보안성: 기존의 쿼리문이 보이지 않는다
 * 
 * */

/*PLAYER 테이블에 나이 컬럼 추가한 뷰 만들기*/
CREATE  VIEW VIEW_PLAYER AS
SELECT FLOOR((SYSDATE - BIRTH_DATE) / 365) AGE, P.* FROM PLAYER P;

SELECT * FROM VIEW_PLAYER 
WHERE AGE >20;

/*EMPLOYEES 테이블에서 사원 이름과 그 사원의 매니저 이름이 있는 VIEW 만들기, VIEW_EMPLOYEES*/
CREATE VIEW VIEW_EMPLOYEES AS
SELECT E1.FIRST_NAME ||' '||E1.LAST_NAME "사원이름" ,
		NVL(E2.FIRST_NAME, '매니저없음') ||' '||NVL(E2.LAST_NAME, '') "매니저이름"
FROM EMPLOYEES E1 LEFT OUTER JOIN EMPLOYEES E2
ON E1.MANAGER_ID = E2.EMPLOYEE_ID;

SELECT * FROM VIEW_EMPLOYEES;



