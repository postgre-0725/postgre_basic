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

create sequence sequence_contoh; --create sequence (auto increment in postgres)

select nextval ('sequence_contoh'); --call sequence, auto increment

select currval ('sequence_contoh');

/ds --see list sequences

/d sequence_contoh; -- see detail sequence

select id, lower(name) ,length(name), lower(description) from products;

select id, extract (year from created_at), extract(month from created_at) from products;

select id, 
		category, 
		case category 
			when 'Makanan' then 'Lapar'
			when 'Minuman' then 'Haus'
			else 'Cemilan'
		end as category_case
from products;

select id,
		name,
		price,
		case
		when price <= 10000 then 'Murah juga:)'
		when price <= 20000 then 'Mahal yaa:v'
		else 'Mahal amat euy:('
		end as Mahal_pora
from products;

select id,
		name,
		case
			when description is null then 'No desc detected'
			else description
		end as descriptions
from products;
		
select count(id) from products;

select avg(price) from products;

select max(price) from products;

select min(price) from products;

select category, 
		count(id) as total_product,
		avg(price) as rata2_harga,
		max(price) as harga_termahal,
		min(price) as harga_termurah
from products 
group by category; 

select category, 
		count(id) as total_product
from products 
group by category
having count(id) > 1; 

select category, 
		count(id) as total_product,
		avg(price) as rata2_harga,
		max(price) as harga_termahal,
		min(price) as harga_termurah
from products 
group by category
having avg(price) > 6000; 

create table customers (
	id serial not null,
	email varchar(100) not null,
	first_name varchar(100) not null,
	last_name varchar(100),
	primary key (id),
	constraint unique_email unique (email)
)

insert into customers (email, first_name, last_name) values ('mhasan@qa.test','M.','Hasan'); -- Sukses add data

insert into customers (email, first_name, last_name) values ('mhasan@qa.test','Muh.','Hasanain'); -- Gagal add data, email harus unix

alter table customers drop constraint unique_email;

alter table customers add constraint unique_email unique (email);

alter table products add constraint check_price check (price >= 500);

insert into products (id, name, description, price, quantity) values ('F012', 'Permen Lolita', 'Lolita jambu', 100, 9); -- gagal karena price >= 500

-- primary key & constraint unique otomatis membuat index
create table sellers (
	id serial not null,
	name varchar(100) not null,
	email varchar(100) not null,
	primary key (id),
	constraint email_unique unique (email)
);

insert into sellers (name, email)
values ('Berkah Jaya','berkahjaya@mail.com'),
		('Ayu Makmur','ayumakmur@mail.com'),
		('Budi Sentoss','budisentosa@mail.com');
	
select * from sellers where id = 1; -- search cepat krn menggunakan index di PK	

select * from sellers where email = 'budisentosa@mail.com'; -- search cepat krn menggunakan index constraint unique
	
select * from sellers where name = 'Berkah Jaya'; -- search tidak cepat krn tidak menggunakan index di name

select * from sellers where id = 1 or name = 'Ayu Makmur'; -- search tidak cepat krn tidak menggunakan index di seluruh kolom

create index sellers_id_and_name_index on sellers (id, name);

select * from products where to_tsvector(name) @@ to_tsquery('sambal') -- search tanpa index

-- search with index by full text search
select cfgname from pg_ts_config; -- see available language

create index products_name_search on products using gin (to_tsvector('indonesian',name));

create index products_description_search on products using gin (to_tsvector('indonesian',description));

select * from products where name @@ to_tsquery('sambal') 

select * from products where description @@ to_tsquery('ayam') 

select * from products where description @@ to_tsquery('ayam bakar') -- error krn hanya bisa single keyword

select * from products where category @@ to_tsquery('makanan') -- error krn belum add full text search

select * from products where name @@ to_tsquery('ayam & sambal') -- with AND

select * from products where name @@ to_tsquery('ayam | sambal') -- with OR

select * from products where name @@ to_tsquery('!ayam') -- with NOT

select * from products where name @@ to_tsquery('''ayam bakar''') -- untuk semua data (ayam bakar sambal ijo)

create table wishlist(
	id serial not null,
	id_product varchar(10) not null,
	description text,
	primary key(id),
	constraint fk_wishlist_product foreign key (id_product) references products(id)
)

insert into wishlist (id_product, description) values ('id_salah', 'Description salah'); -- error krn tidak ada id product tsb di table relasi

insert into wishlist (id_product, description) -- success id available in product
values ('F001', 'Geprek idaman'),
		('F002','Ayam bakal joss'),
		('F003','Ayam krispi lezatoz');
	
select * from wishlist;	

update wishlist set id_product = 'id_salah' where id '5'; -- error juga krn tidak dapat update, id not available in products

delete from products where id = 'F001'; -- error juga krn tidak dapat delete product yg sudah reference ke table lain

alter table wishlist -- to update behavior fk from default restrict (ditolak)
add constraint fk_wishlist_product foreign key (id_product) references products(id)
on delete cascade on update cascade;

select * from wishlist join products on wishlist.id_product = products.id;

select products.id, products.name, products.description, wishlist.description, products.quantity, products.price 
from wishlist join products on wishlist.id_product = products.id;

select p.id, p.name, p.description, w.description, p.quantity, p.price 
from wishlist as w join products as p on w.id_product = p.id;

alter table wishlist add column id_customer int;

alter table wishlist
add constraint fk_wishlist_customer foreign key (id_customer) references customers(id);

update wishlist set id_customer = 1 where id in (5,7);

update wishlist set id_customer = 3 where id = 6;

select p.id, p.name, p.description, w.description, p.quantity, p.price, c.first_name, c.email 
from wishlist as w join products as p on w.id_product = p.id;

create table wallet (
	id serial not null,
	id_customer int not null,
	balance int not null default 0,
	primary key (id),
	constraint wallet_customer_unique unique (id_customer),
	constraint fk_wallet_customer foreign key (id_customer) references customers(id)
)

insert into wallet (id_customer, balance) values (1,5000000), (3, 2500000);

select * from wallet join customers on wallet.id_customer = customers.id;

create table categories (
	id varchar(10) not null,
	name varchar(100) not null,
	primary key (id)
)

insert into categories (id, name) values ('C001','Makanan'), ('C002','Minuman'),('C003','Lain-lain');

select * from categories;

alter table products add column id_category varchar(10);

alter table products 
add constraint fk_products_categories foreign key (id_category) references categories(id);

update products set id_category = 'C001' where category = 'Makanan';
update products set id_category = 'C002' where category = 'Minuman';
update products set id_category = 'C003' where category = 'Lain-lain';

alter table products drop column category;

select * from products join categories on products.id_category = categories.id;

create table orders(
	id serial not null,
	total int not null,
	order_date timestamp not null default current_timestamp,
	primary key (id)
)

create table order_detail(
	id_product varchar(10) not null,
	id_order int not null,
	price int not null,
	quantity int not null,
	primary key(id_product,id_order)
)

alter table order_detail
add constraint fk_order_detail_products foreign key (id_product) references products(id);

alter table order_detail
add constraint fk_order_detail_order foreign key (id_order) references orders(id);

insert into orders(total) values (1),(1),(1);

select * from orders;

insert into order_detail (id_product, id_order, price, quantity)
	values ('F001', 1, 1000, 2),
			('F002', 1, 1500, 2),
			('F003', 1, 1500, 2);

insert into order_detail (id_product, id_order, price, quantity)
	values ('F004', 2, 2000, 2),
			('F005', 2, 3500, 2),
			('F006', 2, 5000, 2);

insert into order_detail (id_product, id_order, price, quantity)
	values ('F001', 3, 1000, 3),
			('F004', 3, 2000, 6),
			('F005', 3, 3500, 1);

select * from order_detail;		

select * from orders
join order_detail on order_detail.id_order = orders.id
join products on order_detail.id_product = products.id;

insert into categories (id,name) values ('C004','Buah'),('C005','Sayur');

insert into products (id, name, price, quantity) values ('F010','Salak pondok','17500','182'),('F011','Apel fuji','53000','39'),('F012','Brokoli','2300','9');

select * from categories inner join products on products.id_category = categories.id;

select * from categories left join products on products.id_category = categories.id;

select * from categories right join products on products.id_category = categories.id;

select * from categories full join products on products.id_category = categories.id;

select avg(price) from products;

select * from products where price > (select avg(price) from products);

select max(price) from (select products.price as price from categories join products on products.id_category = categories.id) as example;

create table guestbooks (
	id serial not null,
	email varchar(100) not null,
	title varchar(100) not null,
	content text,
	primary key (id)
)

insert into guestbooks (email, title, content)
values ('mhasan@qa.test','from hasan','isi hasan'),
		('mhasan@qa.test','from hasan 2','isi hasan 2'),
		('musa@mail.com','from musa','isi musa'),
		('another@mail.com','from another','isi another'),
		('other@mail.com','from other','isi other');

select * from guestbooks;	

select distinct email from customers union select distinct email from guestbooks;

select distinct email from customers union all select distinct email from guestbooks;

select email from customers union all select email from guestbooks;

select email, count(email) from (select email from customers union all select email from guestbooks) as contoh group by email;

select email from customers intersect select email from guestbooks;

select email from customers except select email from guestbooks;

start transaction;

insert into guestbooks (email, title, content) values ('trans@qa.test','trans1','trans 1');

insert into guestbooks (email, title, content) values ('trans2@qa.test','trans2','trans 2');

insert into guestbooks (email, title, content) values ('trans2@qa.test','trans3','trans 3');

select * from guestbooks;

commit;

start transaction;

insert into guestbooks (email, title, content) values ('trans4@qa.test','trans4','trans 4');

insert into guestbooks (email, title, content) values ('trans5@qa.test','trans4','trans 5');

select * from guestbooks;

rollback;

start transaction;

update products set description = 'Ayam geprek joss' where id = 'F001';

select * from products order by id;

commit;

update products set quantity = 50 where id = 'F001'; -- run in other place, baru running ketika diatas commit

start transaction;

select * from products where id = 'F001' for update;

rollback;

update products set price = 20000 where id = 'F001'; -- run in other place, baru running ketika diatas rollback

-- Deadlock
start transaction;

select * from products where id = 'F001' for update; -- run again in another place, deadlock

select * from products where id = 'F002' for update; -- run transaction in another place

rollback;

-- see schema current
select current_schema();
show search_path;

create schema example;

set search_path example;

drop schema example;

select * from public.products;

create table example.products(
	id serial not null,
	name varchar(100) not null,
	primary key(id)
);

insert into example.products (name) values ('products example 01');

select * from example.products;

create role hasan;

create role sans login password 'password';

drop role sans;

alter role hasan login password 'password';

grant insert, update, select on all tables in schema public to hasan;

grant usage, select, update on guestbooks_id_seq to hasan;

grant insert, update, select on customers to sans;

pg_dump --host=localhost --port=5432 --dbname=db_postgres --username=postgres --format=plain --file=D:\QA\PZN\PostgreSQL\postgre_basic\db_postgres.sql

create database db_postgres_restore;

psql --host=localhost --port=5432 --dbname=db_postgres_restore --username=postgres --file=\db_postgres.sql










