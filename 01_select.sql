-- SELECT문
-- DML 중 하나로, 저장되어 있는 데이터를
-- 조회하기위해 사용하는 쿼리

-- 조회한 데이터 중 특정 컬럼만 출력
-- ``으로 감싸면 컬럼으로써 인식시킨다는 의미; -- SQL 자체에 NAME이라는 예약어가 있음
SELECT 
	emp_id
	,`name`   
	, gender
FROM employees;

-- 테이블 전체 컬럼 조회
SELECT *
FROM employees;

-- WHERE 절: 특정 컬럼의 값이 일치하는 데이터만 조회
-- 부등호 사용가능//IS NULL & IS NOT NULL
SELECT *
FROM employees
WHERE emp_id = 10009;

SELECT *
FROM employees
WHERE `name` = '조은혜';

-- 
SELECT *
FROM employees
WHERE birth >= '1990-01-01';

SELECT *
FROM employees
WHERE fire_at IS NOT NULL;
