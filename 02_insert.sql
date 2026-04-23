--  INSERT문
	-- DML 중 하나로 신규 데이터를 저장하기 위해 사용하는 규칙
-- INSERT INTO 테이블명 [(컬럼1, 컬럼2...title_emp_id.)]
-- VALUES (값1, 값2);

INSERT INTO employees (
	`name`
	,birth
	,gender
	,hire_at
	,fire_at
	,sup_id
	,created_at
	,updated_at
)
VALUES ('흰둥일','2998-10-15','F',now(),null,null,now(),NOW())
, ('흰둥이','2999-10-15','M',now(),null,null,now(),NOW())
, ('흰둥삼','2997-10-15','M',now(),null,null,now(),NOW())
;

select 
	*
from employees
ORDER BY emp_id DESC
LIMIT 10
;

	-- SELECT INSERT: 복수의 요소를 인서트할 때
INSERT INTO title_emps (
	emp_id,
	title_code,
	start_at,
	end_at,
	created_at,
	updated_at,
	deleted_at
)
SELECT
	MAX(emp_id),
	'T001',
	NOW(),
	NULL,
	NOW(),
	NOW(),
	NULL
FROM employees
;

select 
	*
from title_emps
ORDER BY emp_id DESC
LIMIT 10
;