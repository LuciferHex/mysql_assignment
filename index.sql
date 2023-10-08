Columns for EmployeeDetails: EmpId FullName ManagerId DateOfJoing City && Columns for EmployeeSalary: : EmpId Project Salary Variable.

Employee Details:

create table emp_details(emp_id int,full_name varchar(20),manager_id int,join_date int,city varchar(10));
 alter table emp_details add constraint primary key(emp_id);

mysql> describe emp_details;
+-------------+-------------+------+-----+---------+-------+
| Field       | Type        | Null | Key | Default | Extra |
+-------------+-------------+------+-----+---------+-------+
| emp_id      | int         | NO   | PRI | NULL    |       |
| full_name   | varchar(20) | YES  |     | NULL    |       |
| manager_id  | int         | YES  |     | NULL    |       |
| join_date   | int         | YES  |     | NULL    |       |
| city        | varchar(10) | YES  |     | NULL    |       |
+-------------+-------------+------+-----+---------+-------+

insert into emp_details(emp_id,full_name,manager_id,join_date,city)values(105,"naveen",5,STR_TO_DATE('15-JUL-2013', '%d-%M-%Y'),"hyderabad");

 select * from emp_details; 
+--------+-----------+-------------+------------+------------+
| emp_id | full_name | join_date | city       | manager_id |
+--------+-----------+-------------+------------+------------+
|    101 | john      | 2005-05-24  | chennai    |        101 |
|    102 | siva      | 2020-07-15  | banglore   |        102 |
|    103 | arun      | 2011-11-11  | kolkata    |       NULL |
|    104 | ashok     | 2011-03-10  | mumbai     |        104 |
|    105 | naveen    | 2020-07-15  | hyderabad  |       NULL |
|    106 | vicky     | 2013-06-05  | coimbatore |        106 |
|    107 | naveen    | 2013-07-15  | hyderabad  |          5 |
+--------+-----------+-------------+------------+------------+

 EmployeeSalary:

 create table emp_salary(emp_id int,project_name varchar(20),salary int,foreign key (emp_id) references emp_details (emp_id));

  describe emp_salary;
+--------------+-------------+------+-----+---------+-------+
| Field        | Type        | Null | Key | Default | Extra |
+--------------+-------------+------+-----+---------+-------+
| emp_id       | int         | YES  | MUL | NULL    |       |
| project_name | varchar(20) | YES  |     | NULL    |       |
| salary       | int         | YES  |     | NULL    |       |
+--------------+-------------+------+-----+---------+-------+

select * from emp_salary;
+--------+--------------+--------+
| emp_id | project_name | salary |
+--------+--------------+--------+
|    101 | project x    |  50000 |
|    104 | project k    |  70000 |
|    103 | project k    |  40000 |
|    105 | project y    |  40000 |
+--------+--------------+--------+

1) SQL Query to fetch records that are present in one table but not in another table.

 select  s.emp_id, d.full_name,s.project_name  from emp_details d left joinemp_salary s on s.emp_id=d.emp_id;

 +--------+-----------+--------------+
| emp_id | full_name | project_name |
+--------+-----------+--------------+
|    101 | john      | project x    |
|   NULL | siva      | NULL         |
|    103 | arun      | project k    |
|    104 | ashok     | project k    |
|    105 | naveen    | project y    |
|   NULL | vicky     | NULL         |
+--------+-----------+--------------+
6 rows in set (0.00 sec)


2)SQL query to fetch all the employees who are not working on any project.

 select   d.full_name,d.join_date,d.city,s.project_name  from emp_details d left joinemp_salary s on s.emp_id=d.emp_id where project_name is null;
+-----------+-------------+------------+--------------+
| full_name | join_date | city       | project_name |
+-----------+-------------+------------+--------------+
| siva      | 2020-07-15  | banglore   | NULL         |
| vicky     | 2013-06-05  | coimbatore | NULL         |
+-----------+-------------+------------+--------------+
2 rows in set (0.00 sec)

3)SQL query to fetch all the Employees from EmployeeDetails who join in the Year 2020:

 select * from emp_details where Year(join_date)="2020";
+--------+-----------+------------+-------------+-----------+
| emp_id | full_name | manager_id | join_date | city      |
+--------+-----------+------------+-------------+-----------+
|    102 | siva        |          2 | 2020-07-15  | banglore  |
|    105 | naveen      |          5 | 2020-07-15  | hyderabad |
+--------+-----------+------------+-------------+-----------+

4)Fetch all employees from EmployeeDetails who have a salary record in EmployeeSalary:

select d.emp_id,d.full_name,s.salary from emp_details d joinmp_salary s on d.emp_id = s.emp_id;
+--------+-----------+--------+
| emp_id | full_name | salary |
+--------+-----------+--------+
|    101 | john      |  50000 |
|    104 | ashok     |  70000 |
|    103 | arun      |  40000 |
|    105 | naveen    |  40000 |
+--------+-----------+--------+


5)Write an SQL query to fetch a project-wise count of employees.

 select project_name,count(emp_id) as project_count from emp_salary group by project_name;
+--------------+---------------+
| project_name | project_count |
+--------------+---------------+
| project x    |             1 |
| project k    |             2 |
| project y    |             1 |
+--------------+---------------+
3 rows in set (0.00 sec)

6)Fetch employee names and salaries even if the salary value is not present for the employee.

select d.full_name ,s.salary from emp_details d left joinmp_salary s on d.emp_id = s.emp_id;
+-----------+--------+
| full_name | salary |
+-----------+--------+
| john       |  50000 |
| siva       |   NULL |
| arun       |  40000 |
| ashok      |  70000 |
| naveen     |  40000 |
| vicky      |   NULL |
+-----------+--------+
6 rows in set (0.00 sec)

7)Write an SQL query to fetch all the Employees who are also managers.

 select d.full_name  from emp_details d joinmp_details m on d.emp_id = m.manager_id;
+-----------+
| full_name |
+-----------+
| john      |
| siva      |
| ashok     |
| vicky     |
+-----------+
4 rows in set (0.00 sec)

8)Write an SQL query to fetch duplicate records from EmployeeDetails.

 select full_name ,count(*) from emp_details group by full_name having count(*)>1;
+-----------+----------+
| full_name | count(*) |
+-----------+----------+
| naveen    |        2 |
+-----------+----------+
1 row in set (0.00 sec)

9)Write an SQL query to fetch only odd rows from the table.

select * from emp_details where mod (emp_id,2)<>0;
+--------+-----------+-------------+-----------+------------+
| emp_id | full_name | join_date | city      | manager_id |
+--------+-----------+-------------+-----------+------------+
|    101 | john    | 2005-05-24  | chennai   |        101 |
|    103 | arun    | 2011-11-11  | kolkata   |       NULL |
|    105 | naveen  | 2020-07-15  | hyderabad |       NULL |
|    107 | naveen  | 2013-07-15  | hyderabad |          5 |
+--------+-----------+-------------+-----------+------------+

10)Write a query to find the 3rd highest salary from a table without top or limit keyword.

 select emp_id,salary from emp_salary where salary=(select max(salary) from emp_salary where salary<(select max(salary) from emp_salary where salary <(select max(salary) from emp_salary)))limit 1;
+--------+--------+
| emp_id | salary |
+--------+--------+
|    103 |  40000 |
+--------+--------+
1 row in set (0.00 sec)