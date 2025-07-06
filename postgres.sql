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







