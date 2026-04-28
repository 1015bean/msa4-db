-- 1. 현재 재직 중인 사원의 사번, 이름, 입사일을 조회해 주세요.
SELECT 
	emp_id
	,`name`
	,hire_at
FROM employees
WHERE 
	fire_at IS NULL  
;

-- 2. 삭제되지 않은 부서 중 현재 운영 중인 부서의 부서코드와 부서명을 조회해 주세요.
SELECT 
	dept_code
	,dept_name
FROM departments
WHERE 
	deleted_at IS NULL 
	AND end_at IS NULL 
;

-- 3. 급여 이력 중 2023년 이후 시작된 급여 기록만 조회해 주세요.
SELECT 
	*
FROM salaries
WHERE 
	start_at >= '2023-01-01'
;

-- 4. 사원 이름에 '민', '지', '현' 중 하나라도 포함된 사원의 사번과 이름을 조회해 주세요.
SELECT 	
	emp_id
	,`name`
FROM employees
WHERE 
	`name` LIKE '%민%' 
	OR `name` LIKE '%지%' 
	OR `name` LIKE '%현%'
;

-- 5. 현재 급여 기록만 조회해 주세요.
SELECT 
	emp_id
	,salary
FROM salaries
WHERE 
	end_at IS NULL
;

-- 6. 사원별 평균 급여를 구하고, 평균 급여가 높은 순서대로 조회해 주세요.
SELECT
	emp_id
	,AVG(salary) 
FROM salaries
GROUP BY emp_id
ORDER BY AVG(salary) DESC 
;

-- 7. 사원별 급여 변경 횟수를 조회해 주세요.
SELECT 
	emp_id
	,COUNT(salary) cnt_sal
FROM salaries
GROUP BY emp_id
;
		
-- 8. 급여가 2번 이상 변경된 사원의 사번과 급여기록개수를 조회해 주세요.
SELECT 
	emp_id
	,COUNT(salary) cnt_sal
FROM salaries
GROUP BY emp_id HAVING COUNT(salary) >= 2
;

-- 9. 전체 평균 급여보다 높은 급여를 받은 기록을 조회해 주세요.
SELECT 
	emp_id
	,salary
FROM salaries
WHERE 
	salary >= (
		SELECT AVG(salary)   -- 쿼리 실행순서 상 WHERE안에 집계함수 사용X
		FROM salaries        -- => 집계함수 부분 서브쿼리로 넣기
	)
;

-- 10. 현재 급여가 70,000,000 이상인 사원의 사번을 조회해 주세요.


-- 11. 가장 높은 급여를 받은 이력이 있는 사원의 사번과 급여를 조회해 주세요.
-- 12. 입사일이 가장 빠른 사원의 사번, 이름, 입사일을 조회해 주세요.
-- 13. 현재 직급이 T003 또는 T004 또는 T005인 사원의 사번을 조회해 주세요.
-- 사용 테이블: title_emps
-- 14. 특정 부서 D001에 현재 소속된 사원의 사번을 조회해 주세요.
-- 15. 부서별 현재 소속 인원 수를 조회해 주세요.
-- 16. 현재 소속 인원이 3명 이상인 부서코드를 조회해 주세요.
-- 17. 직급별 현재 인원 수를 조회해 주세요.
-- 18. 현재 부서장인 사원의 사번을 조회해 주세요.
-- 19. 부서장을 맡은 적이 있는 사원 중 중복 없이 사번만 조회해 주세요.
-- 20. 현재 급여가 전체 현재 급여 평균보다 높은 사원의 사번과 급여를 조회해 주세요.

