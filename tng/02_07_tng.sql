-- 1. 사원의 사원번호, 이름, 직급코드를 출력해 주세요.
SELECT
	emp.emp_id
	,emp.`name`
	,tit.title_code
FROM employees emp
	JOIN title_emps tit
		ON emp.emp_id = tit.emp_id
			AND emp.fire_at IS NULL 
			AND tit.end_at IS NULL 
;		

-- 2. 사원의 사원번호, 성별, 현재 연봉을 출력해 주세요.
SELECT 
	emp.emp_id
	,emp.gender
	,sal.salary
FROM employees emp
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
			AND emp.fire_at IS NULL 
			AND sal.end_at IS NULL 			
;		

-- 3. 10010 사원의 이름과 과거부터 현재까지 연봉 이력을 출력해 주세요.
SELECT 
	emp.`name`
	,sal.salary
FROM employees emp
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
WHERE 
	emp.emp_id = 10010
ORDER BY sal.start_at
;

-- 4. 사원의 사원번호, 이름, 소속부서명을 출력해 주세요.
SELECT
	emp.emp_id
	,emp.`name`
	,dept.dept_name
FROM employees emp
	JOIN department_emps dee
		ON emp.emp_id = dee.emp_id
			AND dee.end_at IS NULL 
			AND emp.fire_at IS NULL 
	JOIN departments dept
		ON dee.dept_code = dept.dept_code
		 AND dept.end_at IS NULL 
WHERE emp.fire_at IS NULL
ORDER BY emp.emp_id 
;		

-- 5. 현재 연봉의 상위 10위까지 사원의 사번, 이름, 연봉을 출력해 주세요.
SELECT 
	emp.emp_id
	,emp.`name`
	,sal.salary
FROM employees emp
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
			AND sal.end_at IS NULL 
			AND emp.fire_at IS NULL 
ORDER BY sal.salary
LIMIT 10		
;

	-- 속도 개선 버전
SELECT 
	emp.emp_id
	,emp.`name`
	,tmp_sal.salary
FROM employees emp
	JOIN (           -- () tmp_sal:현재의 상위 10위 연봉을 나타내는 테이블
		SELECT 
			sal.emp_id
			,sal.salary
	FROM salaries sal
	WHERE 
		sal.end_at IS null
	ORDER BY sal.salary DESC 
	LIMIT 10
	)	tmp_sal
		ON emp.emp_id = tmp_sal.emp_id
			AND emp.fire_at IS NULL 
ORDER BY tmp_sal.salary DESC
;

-- 6. 현재 각 부서의 부서장의 부서명, 이름, 입사일을 출력해 주세요.
SELECT 
	dept.dept_name
	,emp.`name`
	,emp.hire_at
FROM employees emp
	JOIN department_managers dept_mgr
		ON emp.emp_id = dept_mgr.emp_id
			AND emp.fire_at IS NULL 
			AND dept_mgr.end_at IS NULL 
	JOIN departments dept
		ON dept_mgr.dept_code = dept.dept_code
			AND dept.end_at IS NULL 
ORDER BY dept.dept_code			
;		
	
-- 7. 현재 직급이 "부장"인 사원들의 연봉 평균을 출력해 주세요.
SELECT 
	AVG(sal.salary) sal_avg
FROM employees emp
	JOIN title_emps tie
		ON emp.emp_id = tie.emp_id
			AND tie.end_at IS NULL 
	JOIN titles tit
		ON tie.title_code = tit.title_code  
			AND tit.title = '부장'
			AND tit.deleted_at IS NULL 
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
			AND sal.end_at IS NULL 
;	

	-- ------------------
SELECT 
	tie.emp_id
	,AVG(sal.salary)	avg_sal
FROM title_emps tie
	JOIN titles tit
		ON tie.title_code = tit.title_code
			AND tit.title = '부장'
			AND tie.end_at IS NULL 
	JOIN salaries sal
		ON sal.emp_id = tie.emp_id
GROUP BY tie.emp_id
;

-- 7-1. (보너스)현재 각 부장별 이름, 연봉평균	
SELECT 
	emp.`name`
	,AVG(sal.salary) sal_avg
FROM employees emp
	JOIN title_emps tie
		ON emp.emp_id = tie.emp_id
		AND tie.end_at IS NULL 
	JOIN titles tit
		ON tie.title_code = tit.title_code  
			AND tit.title = '부장'
			AND tit.deleted_at IS NULL 
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
			AND sal.end_at IS NULL
GROUP BY emp.emp_id, emp.`name`
;	

-- 8. 부서장직을 역임했던 모든 사원의 이름과 입사일, 사번, 부서번호를 출력해 주세요.
SELECT 
	emp.`name`
	,emp.hire_at
	,emp.emp_id
	,dept_mrg.dept_code
FROM employees emp
	JOIN department_managers dept_mrg
		ON emp.emp_id = dept_mrg.emp_id
ORDER BY dept_mrg.dept_code, dept_mrg.start_at
;		
		
-- 9. 현재 각 직급별 평균연봉 중 60,000,000이상인 직급의 
-- 직급명, 평균연봉(정수)를을 평균연봉 내림차순으로 출력해 주세요.
SELECT 
	tit.title
	,FLOOR(AVG(sal.salary))   -- 60000000이상인 것을 정수로 출력하므로 FLOOR
FROM title_emps tie
	JOIN employees emp
		ON emp.emp_id = tie.emp_id
			AND emp.fire_at IS null
	JOIN salaries sal
		ON sal.emp_id = emp.emp_id
			AND sal.end_at IS NULL 
	JOIN titles tit
		ON tit.title_code = tie.title_code
			AND tit.deleted_at IS NULL
WHERE 
	tie.end_at IS NULL 
GROUP BY tie.title_code, tit.title
	HAVING AVG(sal.salary) >= 60000000
ORDER BY AVG(sal.salary) DESC 
;

-- 10. 성별이 여자인 사원들의 직급별 사원수를 출력해 주세요.
SELECT 
	tie.title_code
	,COUNT(*)
FROM title_emps tie
	JOIN employees emp
		ON emp.emp_id = tie.emp_id
			AND emp.gender = 'F'
WHERE 
	tie.end_at IS NULL
	AND emp.fire_at IS NULL 
GROUP BY tie.title_code
ORDER BY tie.title_code
;			
	