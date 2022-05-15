/***********************
select 문
    select 절 --칼럼 정보 불러오기
    from 절 --테이블 정보 불러오기
    where 절 --가로 정보 불러오기
    order by 절
***********************/

--모든 컬럼 조회하기
select * 
from employees;

select *
from departments;

--원하는 컬럼만 조회하기
select  employee_id, first_name, last_name
from employees;


--예제)
--사원의 이름(first_name)과 전화번호 입사일 연봉을 출력하세요
select first_name, phone_number, hire_date, salary
from employees;

--사원의 이름(first_name)과 성(last_name) 급여, 전화번호, 이메일, 입사일을 출력하세요
select first_name,
        last_name,
        salary, 
        phone_number, 
        email, 
        hire_date		
from employees;
--마지막 ',' 콤마 주의

--출력할때 컬럼명 별명 사용하기
--사원의 이름(first_name)과 전화번호 입사일 급여 로 표시되도록 출력하세요
select first_name "이름",
        phone_number "전화번호",
        hire_date "입사일",
        salary "급여"
from employees;

--사원의 사원번호 이름(first_name) 성(last_name) 급여 전화번호 이메일 입사일로 표시되도록 출력하세요
select first_name as 이름, 
        last_name 성, 
        salary "Salary", 
        phone_number  "hp", 
        email "이 메 일", 
        hire_date 입사일 
from employees;
		--as 사용하는 것이 정석
        --한글은 as 생략할 수 있음 / 단 영어로 입력하면 대문자로만 표기된다.
        --영문 소문자를 표기하려면 "" 안에 작성해야 한다.
        --"" 안에 내용은 공백이라도 그대로 인식하고 표기된다.

--연결연산자(컬럼을 붙이기) ||
select first_name, 
        last_name
from employees;
		--칼럼 두개로 나뉘어서 표기됨

select first_name || last_name 
from employees;
		--칼럼 두개 합해서 표기됨 / 그러나 공백이 없음

select  first_name || ' ' || last_name 
from employees;
		--칼럼 두개 합 결과 및 결과 사이 공백 / '' 로 내용 입력해야함 ""는 오류남

select first_name || ': Hire date is ' || hire_date 입사일 
from employees;
		--'' 사이 내용 그대로 출력됨 / 공백도 포함. / 별명 지을 수 있음

--산술 연산자 
select first_name, 
        salary, 	
        salary*12,	
        (salary+300)*12
from employees;
        --칼럼명은 중복되면 서버에서 임의로 칼럼명을 변경한다 / 예: SALARY-1
        --사용가능한 산술 연산자 : +, -, *, /,

--산술 연산자는 숫자에만 적용 가능하다.
select job_id 	
from employees;

--전체직원의 정보를 다음과 같이 출력하세요
select  first_name||'-'||last_name 성명,
        salary 급여,
        salary*12 연봉,
        salary*12+5000 연봉2,
        phone_number 전화번호
from employees;

/*where절*/
--부서번호가 10인 사원의 이름을 구하시오
select first_name
from employees
where department_id = 10; 
--사용가능한 비교 연산자 : =, !=, >, <, >=, <=

--연봉이 15000 이상인 사원들의 이름과 월급을 출력하세요
select first_name, salary
from employees
where salary >= 15000; 

--07/01/01 일 이후에 입사한 사원들의 이름과 입사일을 출력하세요
select  first_name,
        hire_date
from employees
where hire_date >= '01-JAN-07' ; 
--날짜, 문자는 ''로 감싸줘야함 / 숫자는 괜춘

--이름이 Lex인 직원의 연봉을 출력하세요
select  salary
from employees
where first_name = 'Lex' ;


--조건이 2개이상 일때 한꺼번에 조회하기
--연봉이 14000 이상 17000이하인 사원의 이름과 연봉을 구하시오
select  first_name,
        salary
from employees
where salary >= 14000 
and salary <= 17000; 
-- 조건 추가 시 and 사용


--연봉이 14000 이하이거나 17000 이상인 사원의 이름과 연봉을 출력하세요
select  first_name,
        salary
from employees
where salary <=14000
or salary >=17000;

--입사일이 04/01/01 에서 05/12/31 사이의 사원의 이름과 입사일을 출력하세요
select  first_name,
        hire_date
from employees
where hire_date >= '01-JAN-04'
and hire_date <= '31-DEC-05';

--BETWEEN 연산자로 특정구간 값 출력하기
select  first_name,
        salary
from employees
where salary between 14000 and 17000;

--IN 연산자로 여러 조건을 검사하기
select  first_name,
        last_name,
        salary
from employees
where first_name in ('Neena', 'Lex', 'John');	
--문자는 ''로 나열 , 로 구분

select  first_name,
        last_name,
        salary
from employees
where first_name = 'Neena'
or first_name = 'Lex'
or first_name = 'John';

--연봉이 2100, 3100, 4100, 5100 인 사원의 이름과 연봉을 구하시오
select  first_name,
        salary
from employees
where salary in (2100, 3100, 4100, 5100); 
--숫자는 그냥 ,로 구분


select  first_name,
        salary
from employees
where salary = 2100
or salary = 3100
or salary = 4100
or salary = 5100;


--Like 연산자로 비슷한것들 모두 찾기
select first_name, last_name, salary
from employees
where first_name like '%s%';  
--비슷한 정보 찾을때는 = 이 아닌 like 사용 / % 는 앞이든 뒤든 붙이는 위치 <내용 상관 없이> 라는 의미.

select first_name, last_name, salary
from employees
where first_name like 'L___'; 	
--지정된 글자 자릿수를 찾아야 할 경우, 공백 없이 _ (언더바)를 사용한다.

--이름에 am 을 포함한 사원의 이름과 연봉을 출력하세요
select  first_name,
        salary
from employees
where first_name like '%am%';

--이름의 두번째 글자가 a 인 사원의 이름과 연봉을 출력하세요
select  first_name,
        salary
from employees
where first_name like '_a%';

--이름의 네번째 글자가 a 인 사원의 이름을 출력하세요
select  first_name,
        salary
from employees
where first_name like '___a%';

--이름이 4글자인 사원중 끝에서 두번째 글자가 a인 사원의 이름을 출력하세요
select  first_name,
        salary
from employees
where first_name like '__a_';


--is null / is not null 
select  first_name,
        salary,
        commission_pct,	
        salary*commission_pct	
from employees
where salary between 13000 and 15000;
        --null은 값이 비어 있다는 의미 / 0과 다름

select  first_name,
        salary,
        commission_pct,
        salary*commission_pct
from employees
where commission_pct is null; 
--null 정보값을 불러오려면 is null 을 사용해야함

--커미션비율이 있는 사원의 이름과 연봉 커미션비율을 출력하세요
select  first_name,
        salary,
        commission_pct,
        salary*commission_pct
from employees
where commission_pct is not null; 
--null이 아닌 정보값을 불러오려면 is not null을 사용해야함.


--담당매니저가 없고 커미션비율이 없는 직원의 이름을 출력하세요
select  first_name,
        salary,
        commission_pct
from employees
where manager_id is null
and commission_pct is null;

--설명용//
select  first_name,
        salary
from employees
where salary >= 10000;

--order by 절을 사용해 보기 좋게 정렬하기
select  first_name
from employees
order by salary asc;   
--desc // asc -> ascending / desc -> descending


select  first_name, 
        salary
from employees
where salary >=9000
order by salary asc;


--부서번호를 오름차순으로 정렬하고 부서번호, 급여, 이름을 출력하세요
select  department_id,
        salary,
        first_name
from employees
order by department_id asc;


--급여가 10000 이상인 직원의 이름 급여를 급여가 큰직원부터 출력하세요
select  first_name,
        salary
from employees
where salary >=10000
order by salary desc;

--부서번호를 오름차순으로 정렬하고 부서번호가 같으면 급여가 높은 사람부터 
--부서번호 급여 이름을 출력하세요  
select  department_id,   
        salary,
        first_name
from employees
order by department_id asc, salary desc, first_name desc ;	
--순위별로 나열

/*
단일행 함수
*/
--문자함수 – INITCAP(컬럼명) // Initial Capitalization
--부서번호 100인 직원의 이메일주소와 부서번호를 출력하세요
select  email, 
        initcap(email) "email2", 
        department_id        
from employees
where department_id = 100;

--문자함수 – LOWER(컬럼명) / UPPER(컬럼명) // lowercase / uppercase
select  first_name,
        upper(first_name) "upper", 
        lower(first_name) lower
from employees
where department_id = 100;
        --컬럼명 지정하지 않으면 (UPPER(FIRST_NAME))으로 출력됨.


--문자함수 – SUBSTR(컬럼명, 시작위치, 글자수) // substring
select  first_name,
        substr(first_name,1,4),
        substr(first_name,-3,2)
from employees
where department_id = 100;

--문자함수 – LPAD(컬럼명, 자리수, ‘채울문자’) /  RPAD(컬럼명, 자리수, ‘채울문자’) // left padding / right padding
select  first_name,
        lpad(first_name, 10, '*'),
        rpad(first_name, 10, '*')  
from employees;
        --//양옆 시도 : rpad(lpad(first_name, 10, '*'), 15, '*' )

--문자함수 – REPLACE (컬럼명, 문자1, 문자2)
select  first_name,
        replace(first_name,'a', '*'),
        substr(first_name,2, 3),
        replace(first_name, substr(first_name,2, 3), '***' )   
from employees
where department_id=100;
		--Nancy
		--N*ncy
		--anc
		--N***cy

--replace ('내용', '변경할 부분', '변경할 내용')
select replace('abcdefg', 'bc' , '******')
from dual; 
--data 없는 테이블 명은 dual --> test 해봐야 할때 사용하면 좋음.

--substr ('내용', 자릿수, 글자수)
select substr('900214-1234234',8,1)
from dual;

--숫자함수 – ROUND(숫자, 출력을 원하는 자리수) 
select  round(123.346, 2) r2,
        round(123.556, 0) r0,
        round(125.456, -1) "r-1"
from dual;

--숫자함수 – TRUNC(숫자, 출력을 원하는 자리수) 
select  trunc(123.346, 2) r2,
        trunc(123.456, 0) r0,
        trunc(123.456, -1) "r-1"
from dual;

--날짜함수 – SYSDATE()
select sysdate
from dual;

--전체 테이블 출력
select *
from employees;

--months_between ('날짜1','날짜2') / 개월수 
select months_between(sysdate, hire_date)
from employees
where department_id = 110;


--TO_CHAR(숫자, ‘출력모양’)  숫자형문자형으로 변환하기
--'출력모양' -> 9로 자리수 표시 / 빈자리 0으로 표시 / 미국에서 개발되어 $ 표시 사용 가능
select  first_name,
        to_char(salary*12, '$099999')
from employees 
where department_id = 110;

--출력모양 예시:
select  to_char(9876, '99999'),
        to_char(9876, '099999'),
        to_char(9876, '$99999'),
        to_char(9876, '9999.99'),
        to_char(987654321, '999,999,999,999'),
        to_char(987654321, '999,999,999,999.999')
from dual;


--변환함수>TO_CHAR(날짜, ‘출력모양’)  날짜문자형으로 변환하기
select  sysdate,
        to_char(sysdate, 'YYYY-MM-DD'),
        to_char(sysdate, 'YYYY/MM/DD HH24:MI:SS'),
        to_char(sysdate, 'YYYY"년"MM"월"DD"일" HH24:MI:SS'),
        to_char(sysdate, 'YYYY'),
        to_char(sysdate, 'YY'),
        to_char(sysdate, 'MM'),
        to_char(sysdate, 'MONTH'),
        to_char(sysdate, 'DD'),
        to_char(sysdate, 'DAY'),
        to_char(sysdate, 'HH24'),
        to_char(sysdate, 'MI'),
        to_char(sysdate, 'SS')
from dual;


--NVL(컬럼명, null일때값)/NVL2(컬럼명, null아닐때값, null일때 값)
select  first_name,
        commission_pct,
        nvl(commission_pct, 0), 
        nvl2(commission_pct, 100, 0) 	
from employees;
--null 만 변경할때 NVL
--is not null과 is null 으로 변경할때 NVL2
