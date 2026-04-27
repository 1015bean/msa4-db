-- SubQuery

-- -------------------------------------------------------------------------------------------
-- WHERE절에서 사용
	-- 1, 단일 행 서브쿼리
	-- 서브쿼리가 단일 행 연산자와 함께 사용될 떄는
	-- 서브쿼리 결과 수가 1건 이하여야 함, 2건 이상일 경우 오류 발생
	
	-- D001 부서장의 사번과 이름을 출력
SELECT
	employees.emp_id                       -- (서브쿼리)에서 찾은 부서장 사번 바탕으로, 사번/ 이름 출력
	,employees.`name`
FROM employees
WHERE
	employees.emp_id = (                   -- 부서장 테이블: (부서=D001/현재 부서장)의 enp_id 찾기
		SELECT 
			department_managers.emp_id
		FROM department_managers
		WHERE 
			department_managers.dept_code = 'D001'
			AND department_managers.end_at IS NULL
	)
;

	-- 2, 다중 행 서브쿼리
	-- 서브쿼리가 2건 이상을 반환하는 경우
	-- 반드시 다중 행 비교 연산자(IN, ALL, ANY, SOME, EXISTS 등)을 사용
	
	-- 현재 부서장인 사원의 사번과 이름을 출력
SELECT 
	employees.emp_id
	,employees.`name`
FROM employees
WHERE 
	employees.emp_id IN (                    -- 부사장 테이블: 현역인 사람의 emp_id 찾기
		SELECT
			department_managers.emp_id
		FROM department_managers
		WHERE
			department_managers.end_at IS NULL
	)
;

   -- 3, 다중 열 서브쿼리
	-- : 서브쿼리의 결과가 여러개의 컬럼을 반환
	
	-- 현재 D002의 부서장이 해당 부서에 소속된 날짜를 출력
SELECT 
	start_at                                       -- 의 소속된 날짜
FROM department_emps
WHERE
	(department_emps.emp_id, department_emps.dept_code) IN (
		SELECT                                        
			department_managers.emp_id                -- {}의 emp_id & dept_code : 칼럼이 2개
			,department_managers.dept_code
		FROM department_managers
		WHERE 
			department_managers.dept_code = 'D002'     -- {D002의 현재 부서장}
			AND department_managers.end_at IS NULL 
	)
;
	
	-- 4, 연관 서브쿼리
	-- : 서브쿼리 내에서 메인쿼리의 컬럼이 사용된 서브쿼리
	
	-- 부서장직을 지냈던 경력이 있는 사원의 정보를 출력
SELECT
	employees.*
FROM employees
WHERE 
	employees.emp_id IN (                                     
		SELECT department_managers.emp_id
		FROM department_managers
		WHERE
			department_managers.emp_id = employees.emp_id     -- 부서장테이블에도 있고 사원테이블에도 있는 emp_id 찾기
	)
;		
	
-- -------------------------------------------------------------------------------------------------------------
-- SELECT절에서 사용

	-- 사원별 역대 전체 급여 평균
SELECT
	emp.emp_id                     
	,(                                      
		SELECT AVG(sal.salary)            -- {샐러리 테이블에도 있고 사원테이블에도 있는 emp_id}들의 salary의 평균
		FROM salaries sal
		WHERE sal.emp_id = emp.emp_id
	) avg_sal
FROM employees emp
;


-- ------------------------------------------------------------------------------------------------------------
-- FROM절에서 사용
SELECT 
	tmp.*
FROM (
	SELECT 
		emp.emp_id
		,emp.`name`
	FROM employees emp
)tmp           -- () AS tmp : () 전체를 tmp로 이름 변경(AS)
;

-- -----------------------------------------------------------------------------------
-- INSERT문에서 사용
INSERT INTO title_emps (
	emp_id
	,title_code
	,start_at
)
VALUES(
	(SELECT MAX(emp_id) FROM employees)
	,'T001'
	,DATE(NOW())
)
;

-- -----------------------------------------------------------------------------------
-- UPDATE문에서 사용
UPDATE title_emps
SET
	title_emps.end_at = (            -- { 직급테이블: 종료일자 = () }로 데이터 갱신
		SELECT employees.fire_at      -- (사원 테이블: 사번 100000인 사람의 퇴사일)
		FROM employees
		WHERE 
			employees.emp_id = 100000
	)
WHERE
	title_emps.emp_id = 100000
	AND title_emps.end_at IS NULL
;