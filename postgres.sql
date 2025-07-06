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












