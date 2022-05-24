--계정관리--
--DCL (DATA CONTROL LANGUAGE) // 데이터에 대한 권한 관리 및 트랜잭션 제어 (GRANK, REVOKE)

--계정 만들기
create user webdb identified by 1234;   --webdb create connection

--권한 설정
grant resource, connect to webdb;       --grant [connect][resource] privileges

--비밀번호 변경
alter user webdb identified by webdb;   --alter [password] to webdb

--계정 삭제
drop user webdb cascade;                --delete // gotta disconnect to delete

--관리 차원이 아니면 system 접속할 일 없음 //