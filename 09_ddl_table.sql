CREATE DATABASE  mydb;
USE mydb;

-- -----------------------------------------------------------
-- 테이블 생성

	-- UNSIGNED: 양수만 적용(데이터타입의 옵션)
	-- '': 주석
CREATE TABLE users (
	id				BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT 
	,`name`  	VARCHAR(50) NOT NULL 
	,gender  	CHAR(1) NOT NULL COMMENT 'M:남자, F:여자'
	,created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP()
	,updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP()
	,deleted_at DATETIME  
);

	-- 게시글 테이블
	-- pk, 유저번호, 제목, 내용, 작성일, 수정일, 삭제일
CREATE TABLE posts(
	id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT
	,user_id BIGINT UNSIGNED NOT NULL
	,title VARCHAR(50) NOT NULL
	,content VARCHAR(1000) NOT NULL
	,created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP()
	,updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP()
	,deleted_at DATETIME
);

-- ------------------------------------------------------------
-- 테이블 수정

	-- 컬럼 추가
	-- ALTER TABLE [테이블명] ADD COLUMN [컬럼명] [타입, 제약조건];
ALTER TABLE users ADD COLUMN age INT UNSIGNED NOT NULL ;

	-- 칼럼 데이터타입의 수정
	-- ALTER TABLE [테이블명] MODIFY COLUMN [컬럼명] [타입, 제약조건];
ALTER TABLE users MODIFY COLUMN age BIGINT NOT NULL ;

	-- 컬럼 삭제
	-- ALTER TABLE [테이블명] DROP COLUMN [컬럼명];
ALTER TABLE users DROP COLUMN age;

-- 제약 조건(constraint) 추가/삭제
ALTER TABLE posts 
ADD CONSTRAINT fk_posts_user_id
FOREIGN KEY (user_id) REFERENCES users(id);

ALTER TABLE posts
DROP CONSTRAINT fk_posts_user_id;

-- -------------------------------------------------------------
-- AUTO_INCREAMENT 값 변경

 -- 100부터 번호부여 시작
ALTER TABLE users AUTO_INCREMENT = 100;
-- INSERT INTO users(`name`, gender) VALUES('hong', 'F');

-- ------------------------------------------------------------
-- 테이블의 모든 데이터를 깨끗하게 지우는 문
TRUNCATE TABLE users;

-- -------------------------------------------------------------
-- 테이블 삭제
DROP TABLE users;