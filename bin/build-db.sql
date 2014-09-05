create user bank@'%' identified by '94bank';
flush privileges;

create database bank_dev;
grant all on bank_dev.* to bank@'%';
flush privileges;

create database bank_test;
grant all on bank_test.* to bank@'%';
flush privileges;

create database bank_prod;
grant all on bank_prod.* to bank@'%';
flush privileges;

