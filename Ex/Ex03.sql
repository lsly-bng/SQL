--JOIN--

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