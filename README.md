# Pewlett-Hackard Analysis

## Overview
As part of its succession planning process, senior leadership at Pewlett-Hackard sought insight into how many of its hundreds of thousands of employees might be close to 
retirement. Managers of the company's nine departments need to assess which types of positions will be most impacted by the so-called "silver tsunami" as many employees 
of the Baby Boomer generation reach retirement age. They can use this information to work on training and mentorship programs for other employees, refine their hiring 
strategies, and plan their compensation budgets. 

While employees can retire at various ages, or forego retirement altogther, Pewlett-Hackard's leadership decided to use a relatively narrow age band to drive this 
analysis. As such, we assumed that current employees born between 1952 and 1955 were likely near-term retirees. 

We filtered Pewlett-Hackard's employee database by birth date and included titles in our query:

```
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
```
We then narrowed our results to include only current employees and identify each person's most recent title:

```
select distinct on (emp_no) emp_no, 
	first_name,
	last_name,
	title
into unique_titles
from retirement_titles
where (to_date = '9999-01-01')
order by emp_no asc, to_date desc;
```

We aggregated the number of retirement-age employees by their titles:

```
select count (title) as "count", title 
into retiring_titles
from unique_titles
group by title
order by count desc;
```

Finally, we identified slightly younger employees to form a pool of candidates for a potential mentorship program as part of the company's succession planning:
```
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
```



## Results
Pewlett-Hackard has 

## Summary

As it puts this information to use, the company should be careful to avoid age discrimination, especially when it comes to determining eligibility for mentorship 
programs. Selecting employees for such opportunities on the basis of age could pose risks when it comes to compliance with anti-discrimination policies.
