# Database Creation
CREATE USER admin WITH PASSWORD 'admin';
CREATE DATABASE test;
GRANT ALL PRIVILEGES ON DATABASE test TO admin;

# Table Creation 
create table installs (country varchar(2), country_id integer, user_install_id UUID, client varchar(255), year integer, month integer, day integer);
create table spend (country_id integer, client varchar(255), year integer, month integer, day integer, spend numeric(18,8));
create table revenue (country varchar(2), client varchar(255), year integer, month integer, day integer, user_install_id UUID, revenue numeric(18,8));

# Table Number of rows after importing csv files 
Steps Right click on table and select Import/Export Data.. and choose right file according to table
installs - rows 81752
revenue - rows 2126539
spend - rows 102

