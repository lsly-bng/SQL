--데이터 조작어--
--DML (DATA MANIPULATION LANGUAGE) // 데이터 조작어로 검색 및 수정하기 위한 수단 제공 (SELECT, INSERT, UPDATE, DELETE)

--설명 위한 작가 테이블 생성
create table author(
    author_id number(10),
    author_name varchar2(100) not null,
    author_desc varchar2(500),
    primary key(author_id)
);

-- 묵시적 방법 : 컬럼 이름, 순서 지정하지 않음 / 테이블 생성시 정의한 순서에 따라 값 지정
insert into author
values (1, '박경리', '토지 작가 ');

-- 명시적 방법 : 컬럼 이름명시적 사용 / 지정되지 않은 컬럼 NULL 자동입력
insert into author (author_id, author_name)
values (2, '이문열');

-- 명시적 방법 : 데이터 입력할 때, 정의한 순서로 입력해야함 / 칼럼 선택 가능 / 칼럼 정의 순서 상관 없음
insert into author(author_name, author_id)
values('기안84', 3);

-- PK 혹은 not null 입력 값 없을 시 오류남
insert into author(author_id)
values(4);

/*
select *
from author;
*/

--도서 테이블 생성 / 작가 테이블 fk로 연결
create table book(
    book_id number(10),
    title varchar2(100) not null,
    pubs varchar2(100),
    pub_date date,
    author_id number(10),
    primary key(book_id),
    constraint book_fk foreign key(author_id)
    references author(author_id)
);

/*
select *
from book;

select *
from author;
*/

--도서 테이블에 데이터 추가 (insert into ... values ())--
insert into book
values(1, '토지', '마로니에북스', '15-AUG-2012', 1);

insert into book
values(2, '삼국지', '민음사', '01-MAR-2002', 2);

-- FK 및 오류 설명
insert into book
values(2, '삼국지', '민음사', '01-MAR-2002', 4);
-- 작가 테이블에 '4'번 데이터가 없기 때문에 오류 난다

--존재하는 데이터 업데이트(수정) 하기 (update...set...where...)
update author
set author_desc = '삼국지 작가'
where author_id = 2;

--조건을 지정하지 않으면 칼럼 전체 내용이 바뀐다.
update author
set author_desc = '웹툰작가';

--데이터 수정 시, row 별로 내용 수정이 가능하다.
update author
set author_name = '김경리',
    author_desc = ''		--null 로 표현됨
where author_id = 1;

--조건별로 데이터 삭제 (delete from...where...)
delete from author
where author_id = 3;

--테이블 전체데이터 삭제 (delete from...)
delete from book;

delete from author;

--테이블 전체삭제 (drop table...)
--테이블끼리 FK 등으로 연결되어 있는 경우 삭제되지 않는데.
drop table author;

--테이블 전체삭제 (drop table...)
--도서 테이블을 삭제해야 - 작가 테이블을 삭제할 수 있다.
drop table book;
