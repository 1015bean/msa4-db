-- SELECT문
	-- DML 중 하나로, 저장되어 있는 데이터를
	-- 조회하기위해 사용하는 쿼리

-- SELECT: 조회한 데이터 중 특정 컬럼만 출력
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
	-- 부등호 조합시 괄호 사용('ㄱ' AND 'ㄱ') OR 'ㄴ'
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

	-- 출생년도가 1990년인 사원을 조회하기
SELECT *
FROM employees
WHERE 
	birth >= '1990-01-01'
	AND birth <= '1990-12-31'
	AND gender = 'M'
;

	-- 이름이 '조은혜' 또는 '정유리'인 사원을 조회하기
SELECT 
	*		
FROM employees
WHERE 
	`name` = '조은혜'
	OR `name` = '정유리'
;

	-- 1990년 출생이거나, 이름이 '정유리인 사원을 출력
SELECT
	*
FROM employees
WHERE
	(
			birth >= '1990-01-01'
	AND   birth <= '1990-12-31'
	)
	OR 	`name` = '정유리'
;

-- BETWEEN 연산자: 지정한 범위 내의 데이터를 조회
	-- 1990년 출생이거나, 이름이 '정유리인 사원을 출력
SELECT
	*
FROM employees
WHERE
	birth BETWEEN '1990-01-01' AND '1990-12-31'
OR `name` = '정유리'
;

	-- 사원번호가 10005, 10010인 사원을 조회하기
SELECT
 	*
FROM employees
WHERE
	emp_id = 10005
	OR emp_id = 10010
;

-- IN 연산자: 다수의 지정한 값과 일치하는 데이터 조회
SELECT
 	*
FROM employees
WHERE
	emp_id IN (10005, 10010)
;

-- LIKE절: 문자열의 내용을 조회
  -- 'ㄱ%', '%ㄱ', '%ㄴ%': 해당 문자열이 포함된 데이터 조회(글자수: 0 ~ n )
SELECT
	*
FROM employees
WHERE
	`name` LIKE '%우'   -- '우'로 끝나는 이름
;
SELECT
	*
FROM employees
WHERE
	`name` LIKE '%우%'  -- '우'가 이름 안에 들어가는 이름(글자수 상관X)
;

	-- _: 언더바의 개수만큼 "글자수를 허용"해서 조회
SELECT
	*
FROM employees
WHERE
	`name` LIKE '%우_'  -- (숫자 상관없이 글자수)우(한 글자)
;
SELECT
	*
FROM employees
WHERE
	`name` LIKE '__우_'  -- (두 글자)우(한 글자)
;

-- ORDER BY 절: 데이터를 정렬
	-- `칼럼1`, `칼럼2`... 여러 개 연결하면, 1번 정렬 결과를 2번 정렬 결과를 3번 정렬...
	-- ASC: 오름차순 / DESC: 내림차순
SELECT
	*
FROM employees 
ORDER BY `name`, birth   -- `name`으로 정렬한 그 결과를, `birth`로 정렬
;

SELECT
	*
FROM employees 
ORDER BY `name`, birth DESC  -- `name`으로 정렬한 그 결과를, `birth`로 내림차순 정렬
;

-- LIMIT 키워드, OFFSET 키워드
	-- 출력 개수를 제한
	-- LIMIT: 총 출력 개수 / OFFSET: 오프센 다음번호부터 출력

	-- 사번 오름차순으로 정렬된 상위 10명 조회하기
SELECT
	*
FROM employees
WHERE gender = 'M'
ORDER BY emp_id DESC 
LIMIT 100
;

	-- 조회 결과에서 21번째부터 10개를 조회
SELECT
	*
FROM employees
ORDER BY emp_id
-- LIMIT 10 OFFSET 20
LIMIT 20, 10  -- OFFSET 20 LIMIT 10 (21번부터 10개 표시하시오)
;

-- 집계함수
	-- SUM(칼럼): 해당 컬럼의 합계를 출력
	-- MAX(컬럼): 해당 컬럼의 값중 최대값을 출력
	-- MIN(컬럼): 해당 컬럼의 값중 최소값을 출력
	-- AVG(컬럼): 해당 컬럼의평균을 출력
SELECT
	SUM(salary) AS SUM_sal
	,MAX(salary)
	,MIN(salary)
	,AVG(salary)
FROM salaries
WHERE 
	end_at IS null
;

-- COUNT(컬럼 ||*): 검색 결과의 레코드 수를 출력
	-- (*): 총 레코드 수를 반환
SELECT
	COUNT(*)
FROM employees
;
	-- (컬럼명): 해당 컬럼의 값이 NULL이 아닌 레코드의 총 수를 출력
SELECT 
	COUNT(fire_at)
FROM employees
;

	-- 현재 받고 있는 급여 중,
	-- 가장 많이 받고 있는 급여와, 가장 적게 받고 있는 급여를 출력하기
SELECT
	MAX(salary)
	,MIN(salary)
FROM salaries
WHERE end_at IS NOT null
;

--  DISTIMCT키워드: '검색결과'(컬럼에서 검색)에서 중복되는 레코드 없이 조회
SELECT DISTINCT
	emp_id
FROM salaries
;

-- GROUP BY절, HAVING절
	-- GROUP BY절: (이름이 중복되는 친구들을 한)그룹으로 묶어서 조회
	-- HAVING절: "만든 그룹에서" 조건 검색(필터)
	
	-- 직책별 사원수
SELECT
-- SELECT절에 작성하는 컬럼은 GROUP BY절에서 사용한 컬럼과 집계함수만 작성(표준문법)
	title_code
	,COUNT(*) AS cnt
FROM title_emps
WHERE
	end_at IS NULL  
GROUP BY title_code
;

-- 직책 코드에 `02`가 포함된 직책별 사원수
SELECT
	title_code
	,COUNT(*)
FROM title_emps
GROUP BY title_code
	HAVING title_code LIKE '%02%'
;

SELECT
	title_code
	,COUNT(*)
FROM title_emps
WHERE
	title_code LIKE '%02%'
GROUP BY title_code
;

-- 직책별 사원수중, 10000명 이상인 직책의 사원수를 출력
SELECT
	title_code
	,COUNT(*) cnt
FROM title_emps
GROUP BY title_code
	HAVING cnt >= 10000
;