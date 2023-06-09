/*
*자동차
*
*-자동차 번호
*-자동차 브랜드
*-출시 날짜
*-색상
*-가격
*/

CREATE TABLE TBL_CAR(
	CAR_ID NUMBER PRIMARY KEY,
	CAR_BRAND VARCHAR2(1000),
	CAR_RELESE_DATE DATE,
	CAR_COLOR VARCHAR2(500),
	CAR_PRICE NUMBER
);

--제약조건 삭제
ALTER TABLE TBL_CAR DROP CONSTRAINT SYS_C007193;

-- 설정한 이름으로 PRIMARY KEY 정하기
ALTER TABLE TBL_CAR ADD CONSTRAINT PK_CAR PRIMARY KEY(CAR_ID);

--테이블 삭제
DROP TABLE TBL_CAR;


/*
 * 동물 테이블 생성
 * 
 * - 고유 번호
 * - 종류
 * - 나이
 * - 먹이
 * 
 * */

CREATE TABLE TBL_ANIMAL (
	ANIMAL_ID NUMBER,
	ANIMAL_KIND VARCHAR2(1000),
	ANIMAL_AGE NUMBER,
	ANIMAL_FEED VARCHAR2(1000),
	CONSTRAINT ANIMAL_ID PRIMARY KEY(ANIMAL_ID)
);

-- 제약 조건 바로 이름 주는 방법 // 이게 가장 편함
-- ANIMAL_ID NUMBER CONSTRAINT ANIMAL_ID PRIMARY KEY,

DROP TABLE TBL_ANIMAL;

ALTER TABLE TBL_ANIMAL DROP CONSTRAINT ANIMAL_ID;
ALTER TABLE TBL_ANIMAL ADD CONSTRAINT
PK_ANIMAL PRIMARY KEY(ANIMAL_ID);


/*
 * 학생 테이블 생성
 * 
 * - 학생 번호
 * - 학생 아이디
 * - 학생 이름
 * - 전공
 * - 성별
 * - 생년월일
 * - 학생 나이
 * - 학생 학점
 * 
 * */


CREATE TABLE TBL_STUDENT(
	STUDENT_ID NUMBER CONSTRAINT PK_STUDENT PRIMARY KEY,
	STUDENT_IDENTIFICATION VARCHAR2(500) CONSTRAINT UK_STUDENT UNIQUE NOT NULL,
	STUDENT_NAME VARCHAR2(500) NOT NULL,
	STUDENT_MAJOR VARCHAR2(500) NOT NULL,
	STUDENT_GENDER CHAR(1) DEFAULT 'N' CONSTRAINT BAN_GENDER 
	CHECK(STUDENT_GENDER IN('M', 'W', 'N')),
	STUDENT_BIRTH DATE CONSTRAINT BAN_BIRTH 
	CHECK(STUDENT_BIRTH >= TO_DATE('1985-01-01', 'YYYY-MM-DD')),
	STUDENT_AGE NUMBER,
	STUDENT_GRADE VARCHAR2(10) CONSTRAINT BAN_GRADE
	CHECK(STUDENT_GRADE IN('A+', 'A', 'B', 'B+', 'C', 'C+', 'D', 'D+','F'))
);


--학생 아이디는 NULL을 허용한다.
ALTER TABLE TBL_STUDENT MODIFY (STUDENT_IDENTIFICATION NULL);
-- 기존 BAN_GENDER 제약조건을 없앤다.
ALTER TABLE TBL_STUDENT DROP CONSTRAINT BAN_GENDER;
--학생 성별에 'W'를 기본값으로 설정한다.
ALTER TABLE TBL_STUDENT MODIFY (STUDENT_GENDER DEFAULT 'W');
--학생 나이는 19세가 넘어야 한다.
ALTER TABLE TBL_STUDENT  ADD CONSTRAINT BAN_AGE
CHECK(STUDENT_AGE > 19);
--학생 나이는 NULL을 허용하지 않는다.
ALTER TABLE TBL_STUDENT MODIFY (STUDENT_AGE NOT NULL);


/*
 *    TBL_FLOWER      
   ----------------------------------
   FLOWER_NAME   VARCHAR2 PK_FLOWER
   FLOWER_COLOR   VARCHAR2 PK_FLOWER
   ----------------------------------
   FLOWER_PRICE   NUMBER NOT NULL
 * 
 * */
CREATE TABLE TBL_FLOWER(
   FLOWER_NAME VARCHAR2(500),
   FLOWER_COLOR VARCHAR2(500),
   FLOWER_PRICE NUMBER NOT NULL,
   CONSTRAINT PK_FLOWER PRIMARY KEY(FLOWER_NAME, FLOWER_COLOR)
);

/*
 * 
   TBL_POT
   ----------------------------------
   POT_ID      NUMBER PK_POT
   ----------------------------------
   POT_SHAPE   VARCHAR2 NOT NULL
   POT_COLOR   VARCHAR2 NOT NULL
   FLOWER_NAME   VARCHAR2 FOREIGN KEY NOT NULL
   FLOWER_COLOR    VARCHAR2 FOREIGN KEY NOT NULL
 *
 */
CREATE TABLE TBL_POT(
   POT_ID NUMBER CONSTRAINT PK_POT PRIMARY KEY,
   POT_SHAPE VARCHAR2(500) NOT NULL,
   POT_COLOR VARCHAR2(500) NOT NULL,
   FLOWER_NAME VARCHAR2(500) NOT NULL,
   FLOWER_COLOR VARCHAR2(500) NOT NULL,
   CONSTRAINT FK_POT FOREIGN KEY(FLOWER_NAME, FLOWER_COLOR)
   REFERENCES TBL_FLOWER(FLOWER_NAME, FLOWER_COLOR)
);


/*
--------------------------------
   TBL_GUARDIAN
--------------------------------
   GUARDIAN_ID NUMBER PK_GUARDIAN
-------------------------------------
   GUARDIAN_NAME          VARCHAR2 NOT NULL
   GUARDIAN_AGE          NUMBER NOT NULL
   GUARDIAN_ADRESS          VARCHAR2 NOT NULL
   GUARDIAN_PHONENUMBER   VARCHAR2 NOT NULL
   ANIMAL_ID            FK NOT NULL
*/


CREATE TABLE TBL_GUARDIAN(
   GUARDIAN_ID NUMBER CONSTRAINT PK_GUARDIAN PRIMARY KEY,
   GUARDIAN_AGE NUMBER CONSTRAINT BAN_GUARDIAN_AGE CHECK (GUARDIAN_AGE > 0) NOT NULL,
   GUARDIAN_ADRESS VARCHAR2(500) NOT NULL,
   GUARDIAN_PHONENUMBER VARCHAR2(500) NOT NULL
);




/*
----------------------------
   TBL_ANIMAL
----------------------------
   ANIMAL_ID NUMBER PK_ANIMAL
-----------------------------
   ANIMAL_SPECIE       VARCHAR2 NOT NULL
   ANIMAL_NAME       VARCHAR2 NOT NULL
   ANIMAL_AGE          NUMBER NOT NULL
   ANIMAL_DISEASE       VARCHAR2 NOT NULL
*/


CREATE TABLE TBL_ANIMAL(
   ANIMAL_ID NUMBER CONSTRAINT PK_ANIMAL PRIMARY KEY,
   ANIMAL_SPECIE VARCHAR2(500) NOT NULL,
   ANIMAL_NAME VARCHAR2(500) NOT NULL,
   ANIMAL_AGE NUMBER CONSTRAINT BAN_ANIMAL_AGE CHECK (ANIMAL_AGE > 0) NOT NULL,
   ANIMAL_DISEASE VARCHAR2(500) NOT NULL,
   GUARDIAN_ID NUMBER,
   CONSTRAINT FK_ANIMAL_GARDIAN FOREIGN KEY(GUARDIAN_ID)
   REFERENCES TBL_GUARDIAN(GUARDIAN_ID)
);






		