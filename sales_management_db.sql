/* ============================================================
   database creation and setup for Sales Management Demo
   ============================================================ */

-- create a new database
create database sales_management_demo;

-- switch to the newly created database
use sales_management_demo;
go


/* ============================================================
   salesman table: creation, insertion, and operations
   ============================================================ */

-- create the salesman table
create table salesman (
    salesmanid    int,
    salesmanname  varchar(20),
    commission    smallint,
    city          varchar(20),
    age           tinyint
);

-- insert sample data into the salesman table
insert into salesman values
(101, 'joe',    50,  'california', 17),
(102, 'simon',  75,  'texas',      25),
(103, 'jessie', 105, 'florida',    35),
(104, 'danny',  100, 'texas',      22),
(105, 'lia',    65,  'new jersey', 30);

-- view all records in the salesman table
select * from salesman;

-- example: drop the salesman table
-- drop table salesman;

-- example: delete a specific record from the salesman table
-- delete from salesman where salesmanid = 102;


/* ============================================================
   customer table: creation and insertion
   ============================================================ */

-- create the customer table
create table customer (
    salesmanid     int,
    customerid     varchar(20),
    customername   varchar(20),
    purchaseamount int
);

-- insert sample data into the customer table
insert into customer values
(101, 2345, 'andrew',  550),
(102, 1575, 'lucky',   4500),
(104, 2345, 'andrew',  4000),
(107, 3747, 'remona',  2700),
(110, 4004, 'julia',   4545);

-- view all records in the customer table
select * from customer;

/* ============================================================
   orders table: creation and insertion
   ============================================================ */

create table orders (
   orderid     int,      
   customerid  int,                  
   salesmanid  int,                  
   orderdate   date,                 
   amount      decimal(10,2)         
);

insert into orders values
(5001,2345,101,'2021-07-04',550),
(5003,1234,105,'2022-02-15',1500);

select * from orders

-- Upto here we have added some tables. Now we perform some task

--1. Insert a new record in your Orders table.

insert into orders values(5002,2545,109,'2025-08-27',2000);

--2. Add a Primary key constraint for the SalesmanId column in the Salesman table. Add default
    -- constraint for the City column in the Salesman table. Add a Foreign key constraint for SalesmanId
    -- column in the Customer table. Add a not null constraint in the Customer_name column for the
    -- Customer table.
alter table salesman alter column salesmanid int not null;
alter table salesman add constraint pk_salesman primary key(salesmanid);
alter table salesman add constraint df_salesman_city default 'unknown' for city;
alter table customer add constraint fk_customer foreign key(salesmanid)  references salesman(salesmanid);
alter table customer alter column customername varchar(20) not null; 

-- To see all the table
select * from customer;
select * from salesman;
select * from orders;

--3. Fetch the data where the Customer’s name ends with ‘a’ also get the purchase amount value greater than 500.

	select * from customer where customername like '%a' and purchaseamount > 500;


--4. Using SET operators, retrieve the first result with unique SalesmanId values from two tables, and the other result containing SalesmanId with duplicates from two tables.

	select salesmanid from salesman union select salesmanid from customer;
    select salesmanid from salesman union all select salesmanid from customer;

	-- just for trial
	select salesmanid from salesman union select salesmanid from customer union select salesmanid from orders;
	select salesmanid from salesman union all select salesmanid from customer union all select salesmanid from orders;

--5. Display the columns below which has the matching data.
    -- Orderdate, Salesman Name, Customer Name, Commission, and City which has the range of Purchase Amount between 500 to 1500.
    
	select o.orderdate, s.salesmanname, c.customername, s.commision, s.city from orders o 
	join salesman s on o.salesmanid = s.salesmanid
	join customer c on o.customerid = c.customerid
	where c.purchaseamount between 500 and 1500;

--6. Using right join fetch all the results from the salesman and orders table.
select s.salesmanid, s.salesmanname, o.orderid, o.orderdate, o.amount
from salesman s
right join orders o on s.salesmanid = o.salesmanid;

select * from customer;
select * from salesman;
select * from orders;


