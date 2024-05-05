create database if not exists Sales;
create schema if not exists Sales;
-- database/schema are the same

use Sales;

-- CREATE TABLE --
-- EXAMPLE --

create table sales
(
	purchase_name int not null auto_increment primary key,
    data_of_purchase date not null,
    customer_id int,
    item_code varchar(255) not null
);

-- PRACTICE --

create table customers
(
	customer_id int,
    first_name varchar(255),
    last_name varchar(255),
    email_address varchar(255),
    number_of_complaints int
);

select * from sales;

-- database.object.sal_object --

select * from Sales.sales;


-- PRIMARY KEY CONSTRAINT --
-- EXAMPLE --

drop table sales;

create table sales
(
	purchase_name int auto_increment,
    data_of_purchase date,
    customer_id int,
    item_code varchar(10),
 primary key (purchase_name)
);

-- PRACTICE --

drop table customers;

create table customers
(
	customer_id int,
    first_name varchar(255),
    last_name varchar(255),
    email_address varchar(255),
    number_of_complaints int,
primary key (customer_id)
);

create table items
(
	item_code varchar(255),
    unit_price numeric(10,2),
    company_id varchar(255),
primary key (item_code)
);

create table companies
(
	company_id varchar(255),
    company_name varchar(255),
    headquarters_phone_number int,
primary key (company_id)
);

-- FOREIGN KEY CONSTRAINT --
-- EXAMPLE --

drop table sales;

create table sales
(
	purchase_name int auto_increment,
    data_of_purchase date,
    customer_id int,
    item_code varchar(10),
 primary key (purchase_name),
 foreign key (customer_id) references customers (customer_id) on delete cascade
);

drop table sales;

create table sales
(
	purchase_name int auto_increment,
    data_of_purchase date,
    customer_id int,
    item_code varchar(10),
 primary key (purchase_name)
);

alter table sales
add foreign key (customer_id) references customers (customer_id) on delete cascade;

alter table sales
drop foreign key sales_ibfk_1;

-- 'MENU'-'ALTER TABLE'-'FOREIGN KEYS'

drop table sales;
drop table customers;
drop table items;
drop table companies;

-- UNIQUE KEY CONSTAINT --
-- EXAMPLE --

create table customers
(
	customer_id int,
    first_name varchar(255),
    last_name varchar(255),
    email_address varchar(255),
    number_of_complaints int,
primary key (customer_id),
unique key (email_address)
);

drop table customers;

create table customers
(
	customer_id int,
    first_name varchar(255),
    last_name varchar(255),
    email_address varchar(255),
    number_of_complaints int,
primary key (customer_id)
);

alter table customers
add unique key (email_address);

 alter table customers
 drop index email_address;
 
 -- PRACTICE --
 
 drop table customers;
 
 create table customers
 (
	customer_id int auto_increment,
    first_name varchar(255),
    last_name varchar(255),
    email_address varchar(255),
    number_of_complaints int,
primary key (customer_id)
);

alter table customers
add column gender enum('M','F') after last_name;

insert into customers (first_name, last_name, gender, email_address, number_of_complaints)
values ('John','Mackinley','M','john.mckinley@365careers.com',0)
;

-- DEFAULT CONSTRAINT --
-- EXAMPLE --

drop table customers;
 
 create table customers
 (
	customer_id int auto_increment,
    first_name varchar(255),
    last_name varchar(255),
    email_address varchar(255),
    number_of_complaints int,
primary key (customer_id)
);

alter table customers
add column gender enum('M','F') after last_name;

alter table customers
change column number_of_complaints number_of_complaints int default 0;

insert into customers (first_name, last_name, gender)
values ('Peter', 'Figaro', 'M');

select * from customers;

alter table customers
alter column number_of_complaints drop default;

-- PRACTICE --

create table companies
(
	company_id varchar(255),
    company_name varchar(255) default 'X',
    headquarters_phone_number varchar(255),
primary key (company_id),
unique key (headquarters_phone_number)
);

drop table companies;

-- NOT NULL CONSTRAINT --
-- EXAMPLE --

create table companies
(
	company_id int auto_increment,
    headquarters_phone_number varchar(255),
    company_name varchar(255) not null,
primary key (company_id)
);

 alter table companies
 modify company_name varchar(255) null;
 
 alter table companies
 change column company_name company_name varchar(255) not null;
 
 insert into companies (headquarters_phone_number, company_name)
 values ('+1 (145) 1419', 'Senpai');
 
 select * from companies;
 
 -- PRACTICE --
 
 alter table companies
 modify headquarters_phone_number varchar(255) null;
 
 alter table companies
 change column headquarters_phone_number headquarters_phone_number varchar(255) not null;
 