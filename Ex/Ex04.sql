/*SubQuery*/

/*단일행 SubQuery*/
--‘Den’ 보다 급여가 많은 사람의 이름과 급여는?
select  first_name,
        salary
from employees
where salary >= (select  salary
                 from employees
                 where first_name = 'Den');
                 
--Den의 급여를 구한다
--답) 11000
select  salary   
from employees
where first_name = 'Den';    

--급여를 가장 적게 받는 사람의 이름, 급여, 사원번호는?
select  first_name,
        salary,
        employee_id
from employees
where salary = (select  min(salary)
                from employees);
                
--가장 작은 급여를 구한다
select  min(salary)  
from employees;

--평균 급여보다 적게 받는 사람의 이름, 급여를 출력하세요?
select  first_name,
        salary
from employees
where salary <= (select avg(salary)
                 from employees); 

--평균급여
select avg(salary)
from employees;


/*다중행 SubQuery*/
--부서번호가 110인 직원의 급여와 같은 모든 직원의 사번, 이름, 급여를 출력하세요
--답) 12008, 8300
select salary
from employees
where department_id = 110;

--비교용
select  employee_id,
        first_name,
        salary
from employees
where salary = 12008
or salary = 8300 ;

--사용
select employee_id,
       first_name,
       salary
from employees
where salary in (select salary
                 from employees
                 where department_id = 110);

--각 부서별로 최고급여를 받는 사원이름을 출력하세요 (where절 사용)
select department_id,
        max(salary)
from employees
group by department_id;

--where절로 구하기
select  first_name,
        salary,
        department_id,
        email
from employees
where (department_id, salary) in ( select  department_id,
                                           max(salary)
                                   from employees
                                   group by department_id  );

--각 부서별로 최고급여를 받는 사원이름을 출력하세요 (테이블로 구하기)
select  e.first_name,
        e.salary,
        e.department_id,
        s.department_id,
        s.maxSalary
from employees e, (select department_id, 
                          max(salary) maxSalary
                   from employees
                   group by department_id) s  
where e.department_id = s.department_id
and e.salary = s.maxSalary;


