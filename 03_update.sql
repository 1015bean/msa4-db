--  update문
	-- DML 중 하나로 저장되어 있는 기존 데이터를 수정하기위해 사용하는 쿼리
	-- **WHERE절로 수정할 부분 지정하기**
-- UPDATE 테이블명
-- SET
-- 	컬럼1 = 값1
-- 	,컬럼2 = 값2
-- 	[...]
-- [WHERE 조건];

UPDATE employees
SET
	`name` = '반장님'
WHERE
	emp_id = 10005
;

SELECT
	*
FROM employees
WHERE
	emp_id > 10000
;

	-- 100005번 사원의 생일을 '2020-02-02'. 이름을 '마이콜'로 변경하기
UPDATE employees
SET
	birth = '2020-02-02'
	,`name` = '마이콜'
WHERE 
	emp_id = 100005
;

