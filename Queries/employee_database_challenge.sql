-- Create a list of employees near retirement age, including their titles
select e.emp_no,
	e.first_name,
	e.last_name,
	t.title, 
	t.from_date,
	t.to_date
into retirement_titles
from employees as e
	inner join titles as t
		on (e.emp_no = t.emp_no)
where (e.birth_date between '1952-01-01' and '1955-12-31')
order by e.emp_no;

select * from retirement_titles;


-- Use Dictinct with Orderby to remove duplicate rows
select distinct on (emp_no) emp_no, 
	first_name,
	last_name,
	title
into unique_titles
from retirement_titles
where (to_date = '9999-01-01')
order by emp_no asc, to_date desc;

select * from unique_titles
limit 10;


-- Get the number of employees by most recent job title who are of retirement age
select count (title) as "count", title 
into retiring_titles
from unique_titles
group by title
order by count desc;

select * from retiring_titles


-- Get the employees eligible to participate in a mentorship program based on age
select distinct on (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
into mentorship_eligibility
from employees as e
	inner join dept_emp as de
		on (e.emp_no = de.emp_no)
	inner join titles as t
		on (e.emp_no = t.emp_no)
where (e.birth_date between '1965-01-01' and '1965-12-31')
	and (de.to_date = '9999-01-01')
order by e.emp_no;

select * from mentorship_eligibility