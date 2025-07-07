psql

psql --username=USERNAME

psql --host=localhost --port=5432 --dbname=postgres --username=postgres --password

-- Show Database
\l
select datname from pg_database;

-- Use Database
\c db_name;

create database db_name;

drop database db_name;

-- Show Table
\dt;
select * from pg_tables where schemaname='public';

create table barang(
	kode int,
	name varchar(100),
	harga int,
	jumlah int
)

-- Describe table
\d barang;

-- Update table
alter table barang 
	add column deskripsi text;
	
alter table barang 
	drop column deskripsi;

alter table barang 
	rename column name to nama;

truncate barang;

drop table barang;

create table barang(
	kode int not null,
	name varchar(100) not null,
	harga int not null default 1000,
	jumlah int not null default 0,
	waktu_dibuat TIMESTAMP not null default current_timestamp
)

create table products(
	id varchar(10) not null,
	name varchar(100) not null,
	description text,
	price int not null,
	quantity int not null default 0,
	created_at timestamp not null default current_timestamp
)

insert into products (id, name, price, quantity) values ('F001', 'Ayam Grepek Sambal Matah', 15000, 34);

insert into products (id, name, description, price, quantity) values ('F002', 'Ayam Bakar Sambal Ijo', 'Ayam Bakar Lembut + sambal', 18000, 58);

insert into products (id, name, price, quantity) 
values ('F003', 'Ayam Krispi Lalapan', 12000, 22),
		('F004', 'Ayam Goreng Sambal Teri', 21000, 9),
		('F005', 'Ayam Gepuk Bumbu Madura', 25000, 79);


select * from products;

select id, name, price, quantity from products;

create table products(
	id varchar(10) not null,
	name varchar(100) not null,
	description text,
	price int not null,
	quantity int not null default 0,
	created_at timestamp not null default current_timestamp,
	primary key (id)
)

alter table products
	add primary key (id);

select id, name, price, quantity from products where id = 'F004';

select id, name, price, quantity from products where price > 15000;

select id, name, price, quantity from products where quantity < 50;

create type PRODUCT_CATEGORY as enum ('Makanan', 'Minuman', 'Lain-lain');

alter table products 
	add column category PRODUCT_CATEGORY;

update products set category = 'Makanan' where id = 'F001';

update products set category = 'Makanan', description = 'Ayam Gepuk Jatinegara' where id = 'F005';

update products set category = 'Makanan' where id in ('F002','F003','F004');

update products set price = price + 2000 where id = 'F001';

insert into products (id, name, price, quantity, category) values ('F999', 'Jus jeruk 100ML', 15000, 34, 'Minuman');

delete from products where id = 'F999';

select id as kode, name as nama, description as deskripsi from products;

select id as "kode barang", name as "nama barang", description as "deskripsi barang" from products;

select p.id as "kode barang", p.name as "nama barang", p.description as "deskripsi barang" from products as p;

insert into products (id, name, price, quantity, category) 
values ('F006', 'Jus Jeruk Dingin', 7000, 121, 'Minuman'),
		('F007', 'Teh Tawar Gelas Besar', 4000, 5, 'Minuman'),
		('F008', 'Gorengan anget',1000, 0, 'Lain-lain');

select * from products where price > 17000;

select * from products where price >= 17000;

select * from products where category != 'Makanan';

select * from products where price <= 17000 and category != 'Makanan';

select * from products where price <= 17000 or category != 'Makanan';

select * from products where (price <= 17000 or category = 'Makanan') and quantity > 5;

select * from products where category = 'Makanan' or (price >= 17000 and quantity > 5);

select * from products where name like '%a';

select * from products where name like 'k%';

select * from products where name like '%Ayam%';

select * from products where name ilike '%ayam%';

select * from products where description is null;

select * from products where price between 10000 and 20000;

select * from products where price not between 10000 and 20000;

select * from products where category in ('Makanan', 'Minuman');

select * from products where category not in ('Makanan', 'Minuman');

select * from products order by price asc;

select * from products order by name desc;

select * from products where price > 5000 order by price asc limit 2;

select * from products where price > 5000 order by price asc limit 2 offset 2; -- limit 2 skip 2

select distinct category from products; -- menghilangkan data duplikat

select 100 + 100 as result;

select id, name, price / 1000 as result_in_k from products;

select pi();

select power(7,2);

select cos(10), sin(10), tan(10);

select id, name, power(quantity, 2) as quantity_power_2 from products;

create table admin(
	id serial not null,
	first_name varchar(100) not null,
	last_name varchar(100),
	primary key (id)
)

insert into admin (first_name, last_name)
values ('M.','Hasan'),
		('Musa',''),
		('Sans','Tuy');

select * from admin;

select currval ('admin_id_seq'); --see last value id increment











