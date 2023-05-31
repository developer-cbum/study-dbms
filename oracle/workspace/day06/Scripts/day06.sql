/*JOIN
 * 
 *여러 테이블에 흩어져 있는 정보중
 *사용자가 필요한 정보만 가져와서 기상의 테이블처럼 만들고 결과를 보여주는 것
 *정규화를 통해 조회 테이블이 너무 많이 쪼개져 있으면 작업이 불편하기 때문에
 *입력, 수정, 삭제의 성능을 향상시키기 위해서 JOIN을 통해 합친 후 사용한다. 
 *
 * */


/*SQL 실행 순서*/
/*FROM > ON > JOIN > WHERE > GROUP BY > HAVING > SELECT > ORDER BY*/


/*EMP 테이블 사원번호로 DEPT 테이블의 지역 검색 */

SELECT * FROM EMP;
SELECT * FROM DEPT;


/* 1 대 다 관계중 1이 선행 다가 후행
 * FROM 절에서 알리하스 쓰면 AS를 쓰면안된다 띄어쓰기로
 * INNER JOIN 조건식에 맞는 것만 조인 (INNER 생략가능 디폴트라)
 * 외부 조인은 나중에 배우자 */
SELECT ENAME, LOC
FROM DEPT D JOIN EMP E
ON E.DEPTNO = D.DEPTNO; 

/*PLAYER 테이블에서 송종국 선수가 속한 팀의 전화번호 검색하기*/

SELECT PLAYER_NAME, P.TEAM_ID, TEL
FROM TEAM T JOIN PLAYER P
ON T.TEAM_ID = P.TEAM_ID AND PLAYER_NAME = '송종국';


/*JOBS 테이블에서 JOB_ID로 직원들의 JOB_TITLE, EMAIL, 성, 이름 검색*/
SELECT J.JOB_ID , JOB_TITLE , EMAIL , FIRST_NAME, LAST_NAME
FROM JOBS J JOIN EMPLOYEES E
ON J.JOB_ID = E.JOB_ID;

/*EMP 테이블의 SAL을 SALGRADE 테이블의 등급으로 나누기*/
/*고정 된 것들이 선행 테이블*/
SELECT S."LEVEL", E.ENAME, E.SAL
FROM SALGRADE S JOIN EMP E
ON E.SAL BETWEEN S.LOSAL AND S.HISAL
ORDER BY SAL;

ALTER TABLE SALGRADE RENAME COLUMN GRADE TO "LEVEL";

/*EMPLOYEES 테이블에서 HIREDATE가 2003~2005년까지인 사원의 정보와 부서명 검색*/

/*TO_DATE를 사용할 때에 년도만 설정하면, 월은 SYSDATE의 월, 일은 01로 자동 설정된다.*/
SELECT TO_DATE('2003', 'YYYY') FROM DUAL;
SELECT TO_DATE('2005', 'YYYY') FROM DUAL;

SELECT E.*, D.DEPARTMENT_NAME 
FROM DEPARTMENTS D JOIN EMPLOYEES E
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID 
AND E.HIRE_DATE BETWEEN '2003-01-01' AND '2005-12-31'
ORDER BY E.HIRE_DATE ;

/*다른 방법 TO_CHAR(HIRE_DATE, 'YYYY' BETWEEN '2003' AND '2005'*/

/* 나는 -> E.HIRE_DATE BETWEEN TO_DATE('20030101', 'yyyymmdd')  
AND TO_DATE('20051231', 'yyyymmdd')*/


/*JOB_TITLE 중 'Manager'라는 문자열이 포함된 직업들의 평균 연봉을 JOB_TITLE별로 검색*/
SELECT JOB_TITLE, AVG(SALARY)  
FROM JOBS J JOIN EMPLOYEES E
ON J.JOB_ID = E.JOB_ID AND JOB_TITLE LIKE '%Manager%'
GROUP BY JOB_TITLE;

/*EMP 테이블에서 ENAME에 L이 있는 사원들의 DNAME과 LOC 검색*/
SELECT E.ENAME ,D.DNAME, D.LOC  
FROM DEPT D JOIN EMP E
ON D.DEPTNO = E.DEPTNO AND E.ENAME LIKE '%L%';

/*축구 선수들 중에서 각 팀별로 키가 가장 큰 선수들 전체 정보 검색*/
SELECT *
FROM
(
  SELECT TEAM_ID, MAX(HEIGHT) H
  FROM PLAYER
  GROUP BY TEAM_ID
) P1
JOIN
PLAYER P2
ON P1.TEAM_ID = P2.TEAM_ID AND P1.H = P2.HEIGHT;


/*팀 별 최대 키 선수가 2명 이상인 팀 조회*/
SELECT *
FROM 
(
   SELECT TEAM_ID, COUNT(HEIGHT) H, HEIGHT
   FROM
   (
      SELECT P1.TEAM_ID, HEIGHT
      FROM 
      (
         SELECT TEAM_ID, MAX(HEIGHT) H FROM PLAYER
         GROUP BY TEAM_ID
      ) P1
      JOIN
      PLAYER P2
      ON P1.TEAM_ID = P2.TEAM_ID AND P1.H = P2.HEIGHT
   )
   GROUP BY TEAM_ID, HEIGHT
)
WHERE H > 1;



/*EMP 테이블에서 사원의 이름과 매니저 이름을 검색*/
/*셀프조인 문제*/
SELECT E1.ENAME 사원, E2.ENAME 매니저
FROM EMP E1 JOIN EMP E2
ON E1.MGR = E2.EMPNO


