-- VIEW 생성
CREATE VIEW view_avg_salary_by_dept
AS 

-- 부서별 평균 연봉 구하기: 부서명, 평균연봉 출력
SELECT 
	dept.dept_name
	,AVG(sal.salary) avg_sal
FROM department_emps dee
	JOIN departments dept
		ON dee.dept_code = dept.dept_code
			AND dee.end_at IS NULL 
			AND dept.end_at IS NULL 
	JOIN salaries sal
		ON sal.emp_id = dee.emp_id
			AND sal.end_at IS NULL 
GROUP BY dee.dept_code
ORDER BY dee.dept_code
;

SELECT 
	*
FROM view_avg_salary_by_dept
WHERE 
	avg_sal >= 44000000
;

-- VIEW 제거
DROP VIEW view_avg_salary_by_dept;