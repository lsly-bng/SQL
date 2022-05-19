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

-------------------------------------------------
--rownum은 오라클 exclusive function (가상 일렬번호 : pseudo-column)


--급여를 가장 많이 받는 5명의 직원의 이름을 출력하시오.
--정렬을 하면 rownum이 섞인다 --> 정렬을 하고 rownum 을 준다
select  rownum,
        employee_id,
        first_name,
        salary
from employees  
order by salary desc;
-- 미리 정렬되어 있는 테이블이면 rownum이 섞이지 않는다

/* LOGIC: 
		- from -> where -> select -> order by // logic 순서
		- rownum 은 select 부분에 입력되기 때문에 rownum 번호 출력 후 order by로 정렬을 한다.
		- 그렇기 때문에 rownum 번호들이 뒤섞인다.
*/

-->정렬(정렬된 테이블 사용)하고 rownum을 준다
select  rownum,
        ot.employee_id,
        ot.first_name,
        ot.salary
from (select  employee_id,
              first_name,
              salary
      from employees
      order by salary desc) ot;
      
/* LOGIC: 
      - from (ot -> ordered table) -> select // logic 순서
*/
      
--설명: ot 테이블에 phone_number 데이터가 존재하지 않기 때문에 오류난다.
select  rownum,
        ot.employee_id,
        ot.first_name,
        ot.salary
        ot.phone_number
from (select  employee_id,
              first_name,
              salary
      from employees
      order by salary desc) ot;

--rownum을 이용해서 원하는 순위의 값을 선택한다(where절)
--where절이 2번 부터이면 데이터가 없다 (rownum이 항상 1이다)

select  rownum ,
        ot.employee_id,
        ot.first_name,
        ot.salary
from (select  employee_id,
              first_name,
              salary
      from employees
      order by salary desc) ot  
where rownum >= 2
and rownum <= 5;

/* LOGIC: 
		- ot 테이블에 rownum이 정의되지 않았음 //
		- 그렇기 때문에 where 절 사용 시 2번부터 출력하라고 하면 데이터가 없음 //
		- 그러나 ot 테이블에 rownum이 없어도 rownum 1번 부터 출력하면 where 절 사용이 가능하다.
		- rownum 1번이 가능한 이유는 rownum 기능은 기본적으로 1번부터 데이터를 매기는데, 1번을 뛰어넘으려고 하니 1번 이외 숫자는 출력이 안됨
		- from -> where -> select -> order by // logic 순서**
*/
--정렬도 되어 있고  rownum로 있는 테이블이면?

-->(1)정렬하고 (2)rownum이 있는 테이블을 사용하고 (3)where절을 쓴다
select  ort.rn,
        ort.first_name,
        ort.salary
from (select  rownum rn,
              ot.employee_id,
              ot.first_name,
              ot.salary
      from (select  employee_id,
                    first_name,
                    salary
            from employees
            order by salary desc) ot   --(1)
      )ort  --(2)
where rn >= 2
and rn<=5;  --(3)

/* LOGIC:
		- from (ot) -> from (rownum rn) -> from (ort)
				
				* from (ot)	//
					- from (ordered table)
					- select (id-name-sal)
					- order by (sal desc)
				* from (rownum rn) //
					- give (rownum) in the order of (sal desc)	
					- select (id-name-sal)
				* from (ordered row table)
					- where (rownum) is larger or equal to (2) & (rownum) is smaller or equal to (5)
					- select (rownum-id-name)
*/

--예제) 07년에 입사한 직원 중 급여가 많은 직원 중 3에서 7등의 이름, 급여, 입사일은?
select ort.rn,
        ort.first_name,
        ort.salary,
        ort.hire_date
from (select rownum rn,
            ot.first_name,
            ot.salary,
            ot.hire_date
    from (select first_name,
                salary,
                hire_date
        from employees
        where hire_date between '01-JAN-07' and '31-DEC-07'
        order by salary desc)ot) ort
where ort.rn between 3 and 7;
