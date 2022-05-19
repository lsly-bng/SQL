--도서 테이블 삭제
drop table book;

--작가 테이블 삭제
drop table author;

--도서 시퀀스 삭제
drop sequence seq_book_id;

--작가 시퀀스 삭제
drop sequence seq_author_id;

--작가 테이블 만들기 
create table author (
    author_id number(10),
    author_name varchar2(100) not null,
    author_desc varchar2(500),
    primary key(author_id)
);

--도서 테이블 만들기
create table book (
    book_id number(10),
    title varchar2(100) not null,
    publ varchar2(100),
    publ_date date,
    author_id number(10),
    primary key (book_id),
    constraint fk_book foreign key (author_id) references author(author_id)
);

--작가 시퀀스 만들기 
create sequence seq_author_id
increment by 1 start with 1
nocache;

--도서 시퀀스 만들기 
create sequence seq_book_id
increment by 1 start with 1
nocache;

--작가 데이터 추가
insert into author
values (seq_author_id.nextval, '이문열', '경북 영양');

insert into author
values (seq_author_id.nextval, '박경리', '경상남도 통영');

insert into author
values (seq_author_id.nextval, '유시민', '17대 국회의원');

insert into author
values (seq_author_id.nextval, '기안84', '기안동에서 산 84년생');

insert into author
values (seq_author_id.nextval, '강풀', '온라인 만화가 1세대');

insert into author
values (seq_author_id.nextval, '김영하', '알쓸신잡');

--도서 데이터 추가
insert into book
values (seq_book_id.nextval, '우리들의 일그러진 영웅', '다림', '22-FEB-1998', 1);

insert into book
values (seq_book_id.nextval, '삼국지', '민음사', '01-MAR-2002', 1);

insert into book
values (seq_book_id.nextval, '토지', '마로니에북스', '15-AUG-2012', 2);

insert into book
values (seq_book_id.nextval, '유시민의 글쓰기 특강', '생각의길', '01-APR-2015', 3);

insert into book
values (seq_book_id.nextval, '패션왕', '중앙북스(books)', '22-FEB-2012', 4);

insert into book
values (seq_book_id.nextval, '순정만화', '재미주의', '03-AUG-2011', 5);

insert into book
values (seq_book_id.nextval, '오직두사람', '문학동네', '04-MAY-2017', 6);

insert into book
values (seq_book_id.nextval, '26년', '재미주의', '04-FEB-2012', 5);

--전체 출력
select book_id,
        title,
        publ,
        publ_date,
        a.author_id,
        author_name,
        author_desc
from book b, author a
where a.author_id = b.author_id;

--데이터 수정 
update author
set author_desc = '서울특별시'
where author_id = 5;

--데이터 삭제
--도서 테이블에서 삭제
delete from book
where author_id = 4;

--작가 테이블에서 삭제
delete from author
where author_id = 4;
--book 테이블에 author_id 를 FK로 사용중으로, author_id 내용 삭제를 위해서는 book 에서 내용 삭제 후 author 에서 삭제해야함

--수정 후 전체 출력
select book_id,
        title,
        publ,
        publ_date,
        a.author_id,
        author_name,
        author_desc
from book b, author a
where a.author_id = b.author_id;

--데이터 저장
--commit;

--이전 데이터 복구
--rollback;

/*
--도서 테이블 조회하기
select *
from book;

--작가 테이블 조회하기
select *
from author;

--작가 시퀀스 조회하기
select *
from user_sequences;
*/