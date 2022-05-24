--SEQUENCE // 연속적인 일렬번호 생성 -> PK에 주로 사용됨--

--작가 테이블 생성
create table author (
        author_id number(10),
        author_name varchar2(100) not null,
        author_desc varchar2(500),
        primary key(author_id)
);

--* 작가 테이블 SEQ 생성 (create sequence...)
create sequence seq_author_id
increment by 1 						--옵션 : 1씩 올라가라
start with 1 						--옵션 : 1에서 시작해라
nocache;							--옵션 : 시퀀스 부여할때 미리 값을 할당할 것인지의 여부 (?)

--* SEQ 명령어 : .nextval -> next value
--* SEQ 명령어 : .currval -> current value

--* SEQ 활용 방법 (.nextval) / 묵시적 방법
insert into author
values (seq_author_id.nextval, '박경리', '토지 작가');

insert into author
values (seq_author_id.nextval, '이문열', '삼국지 작가');

insert into author
values (seq_author_id.nextval, '기안84', '웹툰작가');

insert into author
values (seq_author_id.nextval, '황일영', 'java');

insert into author
values (seq_author_id.nextval, '유재석', '개그맨');

--* 작가 테이블 데이터 조회하기
select *
from author;

--* SEQ 시퀀스 조회 방법
select *
from user_sequences;

--* SEQ 명령어 .nextval 조회 방법
select seq_author_id.nextval
from dual;

--* SEQ 명령어 .currval 조회 방법
select seq_author_id.currval
from dual;

/*
	- SEQUENCE 사용시, PK 일렬번호가 중간 중간에 빌 수 있다.
	  그러나 너무 강박적으로 고치려고 하지 않아도 된다.
	  중요한건 번호가 겹치지 않는 것 이다.
*/

--* SEQ 삭제 (drop sequence...)
drop sequence seq_author_id;

/*
	- SEQUENCE 삭제해도 데이터는 남는다.
	
	- SEQUENCE 사용 후 삭제했다가 다시 만들면 이미 입력된 데이터 프로세스 시 오류난다
	  그러나 계속 돌려보면 일렬번호를 추가할 수 있을 때 성공한다.
	  출력값은 비어있는 숫자일 것이다.
*/

--* DML 데이터 저장
commit;

--* 이전 commit 으로 돌려놓기
rollback;

/*
	- commit : commit 을 하지 않으면 데이터가 저장되지 않음으로, 추가/수정/삭제된 데이터가 반영이 안된다.
			   일의 단위를 묶어 놓기 (transaction : 데이터 처리 단위) 위해 commit 을 만들었다.
	
	- rollback : transaction 중 문제 발생 시, 이전 commit 으로 데이터 복원하기 위해 만들어졌다. 
				 한 세트로 묶여야 하는 데이터를 실행할때 유용하게 쓰인다.
				 (예: insert 정우성 -1000 : insert 황일영 +1000 / 오류나면 둘다 실행하지 않아야 할때 활용)
*/

