-- --------------------------------------------------------------------------------------
-- Transaction

-- Transaction 시작
START TRANSACTION;

INSERT INTO employees (
	`name`
	,birth
	,gender
	,hire_at
)
VALUES (
	'이예빈'
	,'2001-10-15'
	,'F'
	,NOW()
)
;

SELECT
	*
FROM employees
WHERE 
	`name` = '이예빈'
;

-- COMMIT/ROLLBACK
ROLLBACK;

