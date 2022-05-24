--테이블관리--
--DDL (DATA DEFINITION LANGUAGE) // 데이터 구조를 생성, 변경, 삭제 등의 기능을 제공 (CREATE, ALTER, DROP, RENAME)

--테이블 생성하기 (create table 테이블명 (칼럼명 자료형 정의))--
create table book (
    book_id number(5),
    title varchar2(50),
    author varchar2(10),
    pub_date date
    );

/* NOTE: 
    --자주사용되는 정의어--
        - CHAR(size) : 고정길이 문자열(최대 2000byte)
        - VARCHAR2(size) : 가변길이 문자열 (최대 4000byte)
        - NUMBER (p,s) : 숫자 데이터 // p(전체자리수), s(수소점 이하 자리수) // 자리수 지정 없으면 NUMBER(38) --38 자리까지 표시
        - DATE : 날짜+시간
        
    --테이블, 컬럼 명명 규칙--
        - 문자로 시작
        - 30자 이내
        - A-Z, a-z, 0-9,_(언더바),$(달러),#(해시태그)
        - 오라클 예약어 사용할 수 없음
*/

--테이블 생성 확인--
select *
from book;          

--테이블에 칼럼 추가 (alter table...add)--
alter table book add(pubs varchar2(50));

--테이블에 칼럼 수정 (alter table...modify)--
alter table book modify(title varchar2(100));

--테이블 칼럼 재정의 (alter table...rename column...to...)--
alter table book rename column title to subject;

--테이블 칼럼 삭제 (alter table...drop(...)--
alter table book drop(author);

--테이블명 수정 (rename...to...)
rename book to article;

/*
--테이블명 수정 내용 확인
select *
from article;
*/

--테이블 날리기 (drop table...)--
drop table article;

--테이블의 모든 로우를 제가하기 (truncate table...)
truncate table article;

--제약 조건--

/*
 	- NOT NULL -> NULL값 입력 불가 // 
 				  데이터 없을 시 오류냄.
 	
 	- UNIQUE -> 중복값 입력불가 (NULL값은 허용)
 				데이터 입력값이 없어도 되지만
 				데이터 입력 시 중복은 불가
 	
 	- PRIMARY KEY (PK) -> not null + unique // 
 					 	  즉, 데이터들끼리의 유일성을 보장하는 칼럼에 설정 테이블당
 						  1개만 설정 가능 (여러 개를 묶어서 설정 가능)
 						  
 	- FOREIGN KEY (FK) -> 외래키 //
 					 	  일반적으로 Reference 테이블의 PK를 참조 	// 기본키를 참조하는 속성 
 					 	  Reference 테이블에 없는 값은 삽입 불가	
 					 	  Reference 테이블에 레코드 삭제 시 동작 
 					 	  		* ON DELETE CASCADE -> 해당하는 FK를 가진 참조행도 삭제
 					 	  		* ON DELETE SET NULL -> 해당하는 FK를 NULL로 바꿈
*/




