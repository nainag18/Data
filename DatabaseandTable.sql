# Database Creation
CREATE USER admin WITH PASSWORD 'admin';
CREATE DATABASE test;
GRANT ALL PRIVILEGES ON DATABASE test TO admin;


- hostname: localhost
- port: 5432
- username: admin
- password: admin
- db: test
