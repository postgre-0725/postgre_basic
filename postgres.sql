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

















