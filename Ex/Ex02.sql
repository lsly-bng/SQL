--그룹함수--

/*
select first_name,
       sum(salary)
from employees;
*/
select sum(salary)
from employees;

--그룹함수 -> count()
select  *
from employees;

select  count(*),
        count(commission_pct),  
        count(manager_id)
from employees;
--count는 null 값을 제외함

select count(*)
from employees
where salary > 16000;

--그룹함수 -> sum()
select  count(salary),
        sum(salary)
from employees;

--그룹함수 -> avg()
select  avg(salary),       
        avg(nvl(salary, 0)), 
        round(avg(salary), 0),  
        count(*),
        sum(salary)
from employees;
--avg(salary) -> 급여가 null인 사람은 평균계산 제외 
--avg(nvl(salary, 0)) -> null인값은 0으로 변경후 평균계산
--round(avg(salary), 0) -> 반올림

--그룹함수 -> max() / min()
select  max(salary),
        min(salary),
        count(*)
from employees;

--GROUP BY 절 구성
select first_name
from employees
where salary > 16000
order by salary desc;

/*
select  department_id,  -> 여러개
        avg(salary) -> 전체평균 1개
from employees;
*/

select  department_id,
        job_id,	
        avg(salary),  
        sum(salary),  
        count(salary) 
from employees
group by department_id, job_id 
order by department_id asc;
-- avg -> department_id(부서별 평균)
-- sum -> department_id(부서별 합계)
-- count -> department_id(부서별 카운트)
--Group by에 column 추가하면 데이터가 더 세분화된다.

--연봉(salary)의 합계가 20000 이상인 부서의 부서 번호와 , 인원수, 급여합계를 출력하세요
select  department_id,
        count(*),
        sum(salary)
from employees
where sum(salary)>= 20000   
group by department_id;
--where절에는 그룹함수를 쓸수 없다

--having 절 정상
select  department_id,
        count(*),
        sum(salary)
from employees
group by department_id
having sum(salary) >= 20000
and sum(salary) <= 100000
and department_id = 90;

--오류
select  department_id,
        count(*),
        sum(salary)
from employees
group by department_id
having sum(salary) >= 20000
and sum(salary) <= 100000
and department_id = 90
and hire_date >= '04/01/01';   
--having 절에는 그룹함수 와 Group by에 참여한 컬럼만 사용할 수 있다.

--CASE ~ (ELSE) END 문
select  employee_id,
        first_name,
        job_id,
        salary,
        case when job_id = 'AC_ACCOUNT' then salary+salary*0.1
             when job_id = 'SA_REP' then salary+salary*0.2
             when job_id = 'ST_CLERK' then salary+salary*0.3
             else salary	
        END realSalary
from employees;
--else 안 넣으면 null로 값이 표현됨.

--DECODE 문
select  employee_id,
        first_name,
        job_id,
        salary,
        decode( job_id, 
                    'AC_ACCOUNT', salary+salary*0.1, 
                    'SA_REP', salary+salary*0.2,
                    'ST_CLERK', salary+salary*0.3 ,  
                salary ) bonus
from employees;

/*
a. 직원의 이름, 부서, 팀을 출력하세요
b. 팀은 코드로 결정하며 부서코드가 :
	*10~50 => ‘A-TEAM’
    *60~100 => ‘B-TEAM’  
    *110~150 => ‘C-TEAM’ 
c. 나머지는 ‘팀없음’ 으로 출력하세요.
*/
select  first_name ||' '|| last_name,
        department_id,
        case when department_id>=10 and department_id<=50 then 'A-TEAM'
             when department_id>=60 and department_id<=100 then 'B-TEAM'
             when department_id>=110 and department_id<=150 then 'C-TEAM'
             else 'NO-TEAM'
        end team
from employees;

