-- **문제 1.** `[8점]`  
-- 직원(퇴사자 포함)의 이름과 입사일을 조회하세요.
-- 
-- ```sql
SELECT 
	`name`
	,hire_at
FROM employees
;

-- ```
-- 
-- ---
-- 
-- **문제 2.** `[5점]`  
-- `d005` 부서에 속한 현재 재직 중인 직원의 직원 ID를 조회하세요.
-- 
-- ```sql
SELECT 
	emp_id
FROM department_emps
WHERE 
	dept_code = 'd005'
	AND end_at IS NULL 
;
	


-- ```
-- 
-- ---
-- 
-- **문제 3.** `[5점]`  
-- 1995년 1월 1일 이후에 입사한 직원(퇴사자 포함)의 정보를 입사일 순서대로 정렬하여 조회하세요.
-- 
-- ```sql
SELECT
	*
FROM employees
WHERE
	hire_at >= '1995-01-01'
ORDER BY hire_at
;


-- ```
-- 
-- ---
-- 
-- **문제 4.** `[3점]`  
-- 현재 각 부서별로 몇 명의 직원이 있는지 계산하고, 직원 수가 많은 부서부터 순서대로 조회하세요.
-- 
-- ```sql
SELECT 
	dept_code
	,COUNT(*) cnt_dept_code
FROM department_emps
WHERE 
	end_at IS NULL 
GROUP BY dept_code
ORDER BY COUNT(*) DESC 
;

-- ```
-- 
-- ---
-- 
-- **문제 5.** `[5점]`  
-- 재직 중인 각 직원의 현재 연봉 정보를 조회하세요.
-- 
-- ```sql
SELECT 
	emp.emp_id
	,emp.`name`
	,sal.salary
FROM employees emp
	JOIN salaries sal
		ON sal.emp_id = emp.emp_id
			AND sal.end_at IS NULL 
WHERE 
	emp.fire_at IS NULL 
;

-- ```
-- 
-- ---
-- 
-- **문제 6.** `[5점]`  
-- 재직 중인 각 직원의 이름과 해당 직원의 현재 부서 이름을 함께 조회하세요.
-- 
-- ```sql
SELECT 
	emp.`name`
	,dept.dept_name
FROM employees emp
	JOIN department_emps dee
		ON dee.emp_id = emp.emp_id
			AND dee.end_at IS NULL 
	JOIN departments dept
		ON dept.dept_code = dee.dept_code
			AND dept.end_at IS NULL
WHERE emp.fire_at IS NULL 		
;
	
		
-- ```
-- 
-- ---
-- 
-- **문제 7.** `[3점]`  
-- `마케팅부` 부서의 현재 매니저의 이름을 조회하세요.
-- 
-- ```sql
SELECT 
	emp.`name`
	,dep.dept_name
FROM employees emp
	JOIN department_managers dema
		ON dema.emp_id = emp.emp_id
			AND dema.end_at IS NULL 
	JOIN departments dep
		ON dema.dept_code = dep.dept_code
WHERE 
	dep.dept_name = '마케팅부'
;

-- ```
-- 
-- ---
-- 
-- **문제 8.** `[3점]`  
-- 현재 재직 중인 각 직원의 이름, 성별, 직책(title)을 조회하세요.
-- 
-- ```sql
SELECT 
	emp.`name`
	,emp.gender
	,tit.title
FROM employees emp
	JOIN title_emps tie
		ON emp.emp_id = tie.emp_id
			AND tie.end_at IS NULL 
	JOIN titles tit
		ON tit.title_code = tie.title_code
WHERE emp.fire_at IS NULL 
;

-- ```
-- 
-- ---
-- 
-- **문제 9.** `[3점]`  
-- 현재 가장 높은 연봉을 받는 상위 5명의 직원 ID와 연봉을 조회하세요.
-- 
-- ```sql
SELECT 
	emp_id
	,salary
FROM salaries
WHERE 
	end_at IS NULL
ORDER BY salary DESC
LIMIT 5
;

-- ```
-- 
-- ---
-- 
-- **문제 10.** `[2점]`  
-- 각 부서의 현재 평균 연봉을 계산하고, 평균 연봉이 43,500,000 이상인 부서만 조회하세요.
-- 
-- ```sql
SELECT
	dee.dept_code
	,AVG(sal.salary) avg_sal
FROM employees emp
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
			AND sal.end_at IS null
	JOIN department_emps dee
		ON dee.emp_id = emp.emp_id
			AND dee.end_at IS NULL 
GROUP BY dee.dept_code
	HAVING AVG(sal.salary) >= 43500000
;

-- ```
-- 
-- ---
-- 
-- **문제 11.** `[8점]`  
-- 아래 구조의 테이블을 생성하는 SQL을 작성하세요.
-- 
-- **Table Name**: `users`
-- 
-- | Column Name | Data Type | Note |
-- |---|---|---|
-- | `user_id` | `INT` | PRIMARY KEY, AUTO INCREMENT, UNSIGNED |
-- | `user_name` | `VARCHAR(30)` | NOT NULL |
-- | `auth_flg` | `CHAR(1)` | DEFAULT `'0'` |
-- | `birthday` | `DATE` | NOT NULL |
-- | `created_at` | `DATETIME` | DEFAULT 현재 날짜·시각 |
-- 
-- ```sql
CREATE TABLE users (
	user_id 	  INT UNSIGNED PRIMARY KEY AUTO_INCREMENT 
	,user_name  VARCHAR(30) NOT NULL 
	,auth_flg	  CHAR(1)     DEFAULT '0'
	,birthday   DATE			NOT NULL 
	,created_at DATETIME		DEFAULT NOW()
);

-- ```
-- 
-- ---
-- 
-- **문제 12.** `[8점]`  
-- [문제 11]에서 만든 테이블에 아래 데이터를 입력하는 SQL을 작성하세요.
-- 
-- | 항목 | 값 |
-- |---|---|
-- | user_id | 자동 증가 |
-- | user_name | `'그린'` |
-- | auth_flg | `'0'` |
-- | birthday | `2024-01-26` |
-- | created_at | 오늘 날짜 |
-- 
-- ```sql
INSERT INTO users (
	user_name
	,auth_flg
	,birthday
	,created_at
)
VALUES (
	'그린'
	,'0'
	,'2024-01-26'
	,NOW()
);


-- ```
-- 
-- ---
-- 
-- **문제 13.** `[8점]`  
-- [문제 12]에서 입력한 레코드를 아래 데이터로 갱신하는 SQL을 작성하세요.
-- 
-- | 항목 | 값 |
-- |---|---|
-- | user_name | `'테스터'` |
-- | auth_flg | `'1'` |
-- | birthday | `2007-03-01` |
-- 
-- ```sql
UPDATE users
SET 
	user_name = '테스터'
	,auth_flg = '1'
	,birthday = '2007-03-01'
WHERE 
	user_name = '그린'
;

-- ```
-- 
-- ---
-- 
-- **문제 14.** `[10점]`  
-- [문제 12]에서 입력한 레코드를 삭제하는 SQL을 작성하세요.
-- 
-- ```sql
DROP FROM users
WHERE user_name = '그린'
;


-- ```
-- ---
-- 
-- **문제 15.** `[8점]`  
-- [문제 11]에서 만든 테이블에 아래 컬럼을 추가하는 SQL을 작성하세요.
-- 
-- | Column Name | Data Type | Note |
-- |---|---|---|
-- | `addr` | `VARCHAR(100)` | NOT NULL, DEFAULT `'-'` |
-- 
-- ```sql


ALTER TABLE users
ADD COLUMN addr VARCHAR(100) NOT NULL DEFAULT '-'
;

-- ```
-- 
-- ---
-- 
-- **문제 16.** `[10점]`  
-- [문제 11]에서 만든 테이블을 삭제하는 SQL을 작성하세요.
-- 
-- ```sql
DROP TABLE users;
-- ```
-- 
-- ---
-- 
-- **문제 17.** `[6점]`  
-- 아래 두 테이블에서 **유저명(username), 생일(birthday), 랭크명(rankname)** 을 조회하는 SQL을 작성하세요.
-- 
-- - `rankmanagement`의 FK인 `userid`는 `users`의 `userid`를 참조
-- 
-- **Table: users**
-- 
-- | userid (PK) | username | authflg | birthday | createdat |
-- |---|---|---|---|---|
-- | 1 | green | 0 | 2024-01-26 | 2024-01-26 10:51:27 |
-- 
-- **Table: rankmanagement**
-- 
-- | rankid (PK) | userid (FK) | rankname |
-- |---|---|---|
-- | 1 | 1 | manager |
-- 
-- ```sql
SELECT 
	users.username
	,users.birthday
	,rankmanagement.rankname
FROM users
	JOIN rankmanagement
		ON users.userid = rankmanagement.userid
;


-- ```
-- 