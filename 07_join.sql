-- -------------------------------------------------------------------------------------
-- JOIN문 
	-- 두 개 이상의 테이블을 묶어서 하나의 결과 집합으로 출력

-- ---------------------------------------------------------------------------------------
-- INNER JOIN(교집합)
	-- :복수의 테이블이 공통적으로 만족하는 테이블 출력
	-- INNER는 생략 가능

	-- (테이블 2개)전 사원의 사번, 이름, 현재 급여를 출력해주세요
SELECT 
	emp.emp_id
	,emp.`name`
	,sal.salary
FROM employees emp
	JOIN salaries sal           
		ON emp.emp_id = sal.emp_id    -- INNER JOIN할떄, emp_id가 같은 애들끼리 묶음
			AND sal.end_at IS NULL     	-- 그 중에서 end_at가 NULL인 것만 출력	
;

	-- 예전 Oracle에서 사용하던 방식 (지금은 ANSI방식으로 사용할 것)
SELECT
	emp.emp_id
	,emp.`name`
	,sal.salary
FROM employees emp, salaries sal
WHERE 
	emp.emp_id = sal.emp_id
	AND sal.end_at IS NULL
;

	-- ---------------
	-- (테이블 3개)재직중인 사원의 사원, 이름, 생일, 부서명
SELECT 
	emp.emp_id
	,emp.`name`
	,emp.birth
	,dept.dept_name	
FROM employees emp                
	JOIN department_emps dee
		ON emp.emp_id = dee.emp_id         -- emp테이블과 dee테이블의 emp_id를 연결
			AND dee.end_at IS NULL 
	JOIN departments dept
		ON dee.dept_code = dept.dept_code  -- (부서명 구하기 위해)
;  	                                   -- dee테이블과 dept테이블의 dept_code 연결


-- --------------------------------------------------------------------------
-- LEFT JOIN
	-- 왼쪽 테이블을 기준 테이블로 두고 JOIN실행 

	-- emp가 기준이 됨; emp에 있으면 sal에 없는 것도 출력(없는 부분은 null로 출력)
SELECT 
	*
FROM employees emp
	LEFT JOIN salaries sal
		ON emp.emp_id = sal.emp_id
			AND sal.end_at IS NULL
;			

-- ----------------------------------------------------------------------------
-- UNION
	-- 두개 이상의 결과를 합쳐서 출력
	-- UNION (중복 레코드 제거)
	-- UNION ALL (중복 레코드 제거 안함)
	
	-- 중복 레코드(1)를 제거
SELECT * FROM employees WHERE emp_id IN (1,3)
UNION 
SELECT * FROM employees WHERE emp_id IN (1,5);

	-- 중복 레코드(1)를 제거 안함 => (1, 3, 1, 5 출력)
SELECT * FROM employees WHERE emp_id IN (1,3)
UNION ALL
SELECT * FROM employees WHERE emp_id IN (1,5);

-- -------------------------------------------------------------------------
--  SELF JOIN
	-- 같은 테이블 끼리 JOIN
	
	-- 현재 사수(n번 사원의 sup_id)를 하고 있는 사원의 정보을 출력
SELECT
	emp.emp_id
	,emp.`name`
	,supe.*
FROM employees emp
	JOIN employees supe
		ON emp.sup_id = supe.emp_id   -- 사수의 사번(emp.sup_id) = emp의 사번(사수의 정보)
			AND emp.sup_id IS NOT NULL 
;			