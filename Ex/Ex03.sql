--JOIN--

--JOIN 5줄 요약

/*
	- 조인은 두 개의 테이블을 서로 묶어서 하나의 결과를 만들어 내는 것을 말한다.
	- INNER JOIN(내부 조인 =교집합)은 두 테이블을 조인할 때, 두 테이블에 모두 지정한 열의 데이터가 있어야 한다.
	- OUTER JOIN(외부 조인 = 합집합)은 두 테이블을 조인할 때, 1개의 테이블에만 데이터가 있어도 결과가 나온다.
	- CROSS JOIN(상호 조인)은 한쪽 테이블의 모든 행과 다른 쪽 테이블의 모든 행을 조인하는 기능이다.
	- SELF JOIN(자체 조인)은 자신이 자신과 조인한다는 의미로, 1개의 테이블을 사용한다.

 */

--OUTER Join

/*
	- Join 조건을 만족하지 않는 컬럼이 없는 경우 Null을 포함하여 결과를 생성
	- 모든 행이 결과 테이블에 참여
	- NULL이 올 수 있는 쪽 조건에 (+)를 붙인다.
*/

--종류
/*
	- Left Outer Join: 왼쪽의 모든 튜플은 결과 테이블에 나타남
	- Right Outer Join: 오른쪽의 모든 튜플은 결과 테이블에 나타남
	- Full Outer Join: 양쪽 모두 결과 테이블에 참여
*/

--equi JOIN
select *
from employees, departments;
--이렇게 적으면 107*27(no. of data from table 1 * no. data from tabe 2)

select  employee_id ,
        first_name,
        salary,
        department_name,
        em.department_id "e_did",
        de.department_id "d_did"
from employees em, departments de
where em.department_id = de.department_id;

--모든 직원이름, 부서이름, 업무명 을 출력하세요
select  e.first_name,
        d.department_name,
        j.job_title,
        e.salary,
        e.department_id,
        d.department_id,
        e.job_id,
        j.job_id
from employees e, departments d, jobs j
where e.department_id = d.department_id
and e.job_id = j.job_id
and e.salary >= 7000
order by salary desc;

--left join
--equi join 테이터 106개 --> null은 포함되지 않는다
select  e.first_name,
        e.department_id,
        d.department_name,
        d.department_id
from employees e, departments d
where e.department_id = d.department_id;

--left join 예제
select  e.first_name,
        e.department_id,
        d.department_name,
        d.department_id
from employees e left outer join departments d
on e.department_id = d.department_id;

--left join 오라클 표현법
select  e.first_name,
        e.department_id,
        d.department_name,
        d.department_id
from employees e, departments d
where e.department_id = d.department_id(+);


--right join 
--equi join 테이터 106개 --> null은 포함되지 않는다
select  e.first_name,
        e.department_id,
        d.department_name,
        d.department_id
from employees e, departments d
where e.department_id = d.department_id;

--right join 예제
select  e.first_name,
        e.department_id,
        d.department_name,
        d.department_id
from employees e right outer join departments d
on e.department_id = d.department_id;

--right join 오라클 표현법
select  e.first_name,
        e.department_id,
        d.department_name,
        d.department_id
from employees e, departments d
where e.department_id(+) = d.department_id;

--right join --> left join
select  e.first_name,
        e.department_id,
        d.department_name,
        d.department_id
from employees e right outer join departments d
on e.department_id = d.department_id;


select  e.first_name,
        e.department_id,
        d.department_name,
        d.department_id
from departments d left outer join employees e
on e.department_id = d.department_id;

--full outer join
select  e.first_name,
        e.department_id,
        d.department_name,
        d.department_id
from employees e full outer join departments d
on e.department_id = d.department_id;


--*Self Join
select  e.employee_id,
        e.first_name,
        e.salary,
        e.phone_number,
        e.manager_id,
        m.employee_id,
        m.first_name ManagerName,
        m.phone_number
from employees e, employees m
where e.manager_id = m.employee_id;