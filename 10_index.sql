-- --------------------------------------------------------------------------
-- INDEX

-- ---------------------------------------------------------------------------
-- INDEX 확인
SHOW INDEX FROM employees;

	-- 0.078초
SELECT * FROM employees WHERE `name` = '조은혜';

-- INDEX 생성
ALTER TABLE employees
ADD INDEX idx_employees_name (`name`)
;

	-- 0초
SELECT * FROM employees WHERE `name` = '조은혜';

-- INDEX 삭제
ALTER TABLE employees
DROP INDEX idx_employees_name
;