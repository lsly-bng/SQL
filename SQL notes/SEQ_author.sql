--작가 테이블 삭제
drop table author;

--작가 시퀀스 삭제
drop sequence seq_author_id;

--작가 테이블 만들기 
create table author (
    author_id number(10),
    author_name varchar2(100),
    author_desc varchar2(500),
    primary key(author_id)
);

--작가 시퀀스 만들기 
create sequence seq_author_id
increment by 1 start with 1
nocache;

--작가 데이터 추가
insert into author
values (seq_author_id.nextval, '박경리', '토지 작가');

insert into author
values (seq_author_id.nextval, '이문열', '삼국지 작가');

insert into author
values (seq_author_id.nextval, '기안84', '웹툰 작가');

--작가 데이터 수정
update author
set author_name = '자취84',
    author_desc = '나혼자산다 출연'
where author_id = 3;

--작가 테이블 조회하기
select *
from author;

--작가 시퀀스 조회하기
select *
from user_sequences;

--commit 
commit;

--rollback
rollback;