--혼합 SQL 문제입니다.--

/*
문제 1.
	- 담당 매니저가 배정되어있으나							// manager_id is not null
	- 커미션비율이 없고,									// commission_pct is null 				
	- 월급이 3000초과인 직원의							// employees with salary > 3000			
			* 이름 (first_name),
			* 매니저아이디 (manager_id), 
			* 커미션 비율 (commission_pct), 
			* 월급 (salary)을 출력하세요.(45건) 
*/

--문제 1번 풀이
select first_name 이름,
        manager_id 매니저아이디,
        commission_pct 커미션비율,
        salary 월급
from employees
where salary > 3000
and commission_pct is null
and manager_id is not null
order by salary asc;

/*
문제 2.
	- 각 부서별로 										// group by department
	- 최고의 급여를 받는 사원의 							// employees with max(salary)
		* 직원번호(employee_id), 
		* 이름(first_name), 
		* 급여(salary), 
		* 입사일(hire_date), 							
		* 전화번호(phone_number), 
		* 부서번호(department_id) 를 조회하세요			// from employees
	- 조건절비교 방법으로 작성하세요							// where (department_id,salary) in (department_id, max(salary))
	- 급여의 내림차순으로 정렬하세요							// order by salary desc
	- 입사일은 2001-01-13 토요일 형식으로 출력합니다.			// to_char(hire_date, 'yyyy-mm-dd day')
	- 전화번호는 515-123-4567 형식으로 출력합니다. (11건)		// replace(phone_number,'','-')
*/

--각 부서별 최고의 급여를 받는 사원 조회
select department_id,
		max(salary)
from employees
group by department_id;

--문제 2번 조건절비교 풀이
select employee_id 직원번호,
        first_name 이름,
        salary 급여,
        hire_date 입사일,
        phone_number 전화번호,
        department_id 부서번호
from employees
where (department_id, salary) in (select department_id,
                                        max(salary)
                                from employees
                                group by department_id)
order by salary desc;

--문제 2번 입사일 및 전화번호 형식 갖춘 풀이
select employee_id 직원번호,
        first_name 이름,
        salary 급여,
        to_char(hire_date, 'YYYY-MM-DD DAY') 입사일,
        replace(phone_number,'.','-') 전화번호,
        department_id 부서번호
from employees
where (department_id, salary) in (select department_id,
                                        max(salary)
                                from employees
                                group by department_id)
order by salary desc;

/*
문제 3.
	- 매니저별 / 담당직원들의 								// select avg/min/max salary from employees and group by manager_id (m)
		* 평균급여 (avg(salary))
		* 최소급여 (min(salary))
		* 최대급여 (max(salary))를 알아보려고 한다. 
	- 통계대상(직원)은 2005년 이후(2005년 1월 1일 ~ 현재)의 입사자 입니다.		// where hire_date >= '01-jan-05' (m)
	- 매니저별 평균급여가 5000이상만 출력합니다.				// where m.avg(salary) >= 5000
	- 매니저별 평균급여의 내림차순으로 출력합니다.				// order by m.avg(salary) desc
	- 매니저별 평균급여는 소수점 첫째자리에서 반올림 합니다.		// (round(avg(salary),1)
	- 출력내용은 
		* 매니저 아이디 (manager_id), 
		* 매니저 이름(first_name), 
		* 매니저별 평균급여 (round(avg(salary),1)), 
		* 매니저별 최소급여 (min(salary)), 
		* 매니저별 최대급여 (max(salary)) 입니다. (9건)
*/

--매니저별 담당직원들의 평균급여, 최소급여, 최대급여 조회
select manager_id,
       avg(salary) avs,
       min(salary) mis,
       max(salary) mas
from employees
group by manager_id;

--통계대상 조건문 작성
select manager_id,
       avg(salary) avs,
       min(salary) mis,
       max(salary) mas
from employees
where hire_date >= '01-JAN-05'
group by manager_id;

--문제 3번 풀이
select e.manager_id 매니저아이디,
        e.first_name 매니저이름,
        round(m.avs,1) 평균급여,
        m.mis 최소급여,
        m.mas 최대급여
from employees e, (select manager_id,
                          avg(salary) avs,
                          min(salary) mis,
                          max(salary) mas
                    from employees
                    where hire_date >= '01-JAN-05'
                    group by manager_id) m
where e.employee_id = m.manager_id
and m.avs >= 5000
order by m.avs desc;

/*
문제 4.
	- 각 사원(employee)에 대해서 						
		* 사번(employee_id), 							// (e)select '' from employees
		* 이름(first_name),							// (e)select '' from employees		// join (e) with (d) & (m)
		* 부서명(department_name), 					// (d)select '' from departments 	// where e.department_id = d.department_id
		* 매니저(manager)의 이름(first_name)을 조회하세요.	// (m)select '' from employees 		// where m.employee_id = e.manager_id
	- 부서가 없는 직원(Kimberely)도 표시합니다. (106명)		// show null(+) from departments
*/

--문제 4번 오라클 (+) 풀이
select e.employee_id 사번,
		e.first_name 이름,
		d.department_name 부서명,
		m.first_name 매니저이름
from employees e, departments d, employees m
where e.manager_id = m.employee_id
and e.department_id = d.department_id(+)
order by e.employee_id asc;

--문제 4번 join 문 풀이
select e.employee_id 사번,
		e.first_name 이름,
		d.department_name 부서명,
		m.first_name 매니저이름
from employees e 
        left outer join departments d 
        	on e.department_id = d.department_id 
        inner join employees m 
        	on e.manager_id = m.employee_id
order by e.employee_id asc;

/*
문제 5.
	- 2005년 이후 입사한 직원중에 							// select from employees where hire_date > '31-DEC-05'
	- 입사일이 11번째에서 20번째의 직원의					// where '' (rownum (select '' / from '' / order by hire_date)) between 11 and 20
		* 사번(employee_id),							// (e) 
		* 이름(first_name), 							// (e) select '' from employees			// join(e) and (d)
		* 부서명(department_name), 					// (d) select '' from departments		// where e.department_id = d.department_id
		* 급여(salary), 								// (e) 
		* 입사일(hire_date)을 							// (e) 
	- 입사일 순서로 출력하세요								// order by hire_date
*/

--2005년 이후 입사한 직원 중에 사번,이름,부서명,급여,입사일을 입사일 순서로 정렬
select e.employee_id,
		e.first_name,
        d.department_name,
        e.salary,
        e.hire_date
from employees e, departments d
where e.department_id = d.department_id
and e.hire_date > '31-DEC-05'
order by e.hire_date;

--입사일 순서로 정렬된 테이블에 rownum 추가
select rownum rn,
        ot.employee_id ,
        ot.first_name,
        ot.department_name,
        ot.salary,
        ot.hire_date
from (select e.employee_id,
              e.first_name,
              d.department_name,
              e.salary,
              e.hire_date
      from employees e, departments d
      where e.department_id = d.department_id
      and e.hire_date > '31-DEC-05'
      order by e.hire_date) ot;

--문제 5번 풀이
select ort.rn,
        ort.employee_id 사번,
        ort.first_name 이름,
        ort.department_name 부서명,
        ort.salary 급여,
        ort.hire_date 입사일
from (select rownum rn,
                ot.employee_id ,
                ot.first_name,
                ot.department_name,
                ot.salary,
                ot.hire_date
    from (select e.employee_id,
                    e.first_name,
                    d.department_name,
                    e.salary,
                    e.hire_date
        from employees e, departments d
        where e.department_id = d.department_id
        and e.hire_date > '31-DEC-05'
        order by e.hire_date) ot
        ) ort 
where ort.rn between 11 and 20;

/*
문제 6.
	- 가장 늦게 입사한 직원의 								// select '' where (hire_date = max(hire_date)) from employees
		* 이름(first_name last_name)과 				// (e) 
		* 연봉(salary)과 								// (e) select '' from employees			// join(e) and (d)
		* 근무하는 부서 이름(department_name)은?			// (d) select '' from departments		// where e.department_id = d.department_id
*/

--가장 늦게 입사한 직원의 이름과 연봉 조회 (21-APR-08, 2명)
select hire_date,
        first_name||' '||last_name,
        salary*12
from employees
order by hire_date desc;

--가장 늦은 입사일
select max(hire_date)
from employees;

--문제 6번 풀이
select first_name||' '||last_name 이름,
        salary*12 연봉,
        d.department_name 부서명
from employees e, departments d
where e.department_id = d.department_id
and hire_date = (select max(hire_date)
                 from employees);
                 
/*
문제 7.
	- 평균연봉(salary)이 가장 높은 / 부서 직원들의 			// select '' from (select max(avg(salary)) from employees group by department_id)
		* 직원번호(employee_id), 						//(e)
		* 이름(firt_name), 							//(e)
		* 성(last_name)과 							//(e) select '' from employees			// join (e) and (j)
		* 업무(job_title), 							//(j) select '' from jobs
		* 연봉(salary)을 조회하시오.						//(e)
*/

--부서별 평균연봉(salary) 조회 (가장 높음 평균연봉 부서 = 90,19333)
select department_id,
		avg(salary)
from employees
group by department_id
order by avg(salary) desc;

--평균연봉 가장 높은 부서 직원 정보 조회 (3명)
select department_id,
        employee_id,
        first_name,
        salary
from employees
where department_id = 90;

--평균연봉 가장 높은 부서와 평균급여 조회 (90)
select ort.rn,
        ort.department_id,
		ort.salary
from (select rownum rn,
			  ot.department_id,
			  ot.salary salary
	   from (select department_id,
                    avg(salary) salary
	   		from employees
	   		group by department_id
	   		order by salary desc) ot
	   where rownum = 1) ort;   				

--문제 7번 풀이
select e.employee_id 직원번호,
        e.first_name 이름,
        e.last_name 성,
        j.job_title 업무,
        e.salary*12 연봉
from employees e, jobs j, (select ort.rn,
        						   ort.department_id,
								   ort.salary
							from (select rownum rn,
			  							  ot.department_id,
			  							  ot.salary salary
	   						from (select department_id,
                   						  avg(salary) salary
	   							  from employees
	   							  group by department_id
	   							  order by salary desc) ot
	   						where rownum = 1) ort) m  
where e.job_id = j.job_id
and e.department_id = m.department_id;
	   						
/*
문제 8.
	- 평균 급여(salary)가 가장 높은 부서는?
*/

--부서별 평균급여 조회하기
select department_id,
        avg(salary)
from employees
group by department_id
order by avg(salary) desc;

--평균급여가 가장 높은 부서 조회하기
select 	max(avg(salary)) mas
from (select department_id,
        		avg(salary) salary
		from employees
		group by department_id)	;

--문제 8번 풀이
select d.department_name
from departments d, (select max(avs) mas
                     from (select department_id,
                                  avg(salary) avs
                           from employees
                           group by department_id)) mxst, (select department_id,
                                                                avg(salary) avs
                                                         from employees
                                                         group by department_id 
                                                         order by avs desc) avst
where avst.avs = mxst.mas
and avst.department_id = d.department_id;

/*
문제 9.
	- 평균 급여(salary)가 가장 높은 지역은?
*/

--지역별 평균 급여 조회하기
select r.region_name,
       avg(e.salary)
from regions r, employees e, countries c, locations l, departments d
where r.region_id = c.region_id
and c.country_id = l.country_id
and l.location_id = d.location_id
and d.department_id = e.department_id
group by r.region_name;

--평균 급여가 가장 높은 지역 조회하기 
select max(avs)
from (select r.region_name,
       		  avg(e.salary) avs
	   from regions r, employees e, countries c, locations l, departments d
	   where r.region_id = c.region_id
       and c.country_id = l.country_id
	   and l.location_id = d.location_id
	   and d.department_id = e.department_id
	   group by r.region_name);
	   
--문제 9번 풀이
select avst.rname
from (select max(avs) mas
   	  from (select r.region_name,
	       		  	avg(e.salary) avs
		    from regions r, employees e, countries c, locations l, departments d
		    where r.region_id = c.region_id
	        and c.country_id = l.country_id
		    and l.location_id = d.location_id
		    and d.department_id = e.department_id
		    group by r.region_name)) mxst, (select r.region_name rname,
                                                   avg(e.salary)avs
                                            from regions r, employees e, countries c, locations l, departments d
                                            where r.region_id = c.region_id
                                            and c.country_id = l.country_id
                                            and l.location_id = d.location_id
                                            and d.department_id = e.department_id
                                            group by r.region_name) avst
where avst.avs = mxst.mas;

/*
문제 10.
	- 평균 급여(salary)가 가장 높은 업무는? 
*/

--업무별 평균 급여 조회하기
select job_id,
		avg(salary)
from employees
group by job_id
order by avg(salary) desc;

--평균급여가 가장 높은 업무 조회하기
select max(avs)
from (select job_id,
			  avg(salary) avs
	   from employees
	   group by job_id
	   order by avs desc);
	   
--문제 10번 풀이
select j.job_title
from jobs j, (select max(avs) mas
              from (select job_id,
                           avg(salary) avs
                    from employees
                    group by job_id
                    order by avs desc)) mxst, (select job_id,
                                                      avg(salary)avs
                                               from employees
                                               group by job_id
                                               order by avs desc) avst
where j.job_id = avst.job_id
and avst.avs = mxst.mas;


