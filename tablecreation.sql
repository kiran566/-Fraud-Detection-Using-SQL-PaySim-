select current_database();

drop table  if exists transactions;
-- creating table

create table transactions (
    txn_id serial primary key,
    step int,
    type varchar(20),
    amount numeric,
    nameOrig varchar(50),
    oldbalanceOrg numeric,
    newbalanceOrg numeric,
    nameDest varchar(50),
    oldbalanceDest numeric,
    newbalanceDest numeric,
    isFraud int,
    isFlaggedFraud int
);

---data
--error for txn_id
drop table  if exists trans;
create table trans (
    step int,
    type varchar(20),
    amount numeric,
    nameOrig varchar(50),
    oldbalanceOrg numeric,
    newbalanceOrg numeric,
    nameDest varchar(50),
    oldbalanceDest numeric,
    newbalanceDest numeric,
    isFraud int,
    isFlaggedFraud int
);
select * from trans;

---from trans to transcations

insert into transactions (
    step,
    type,
    amount,
    nameOrig,
    oldbalanceOrg,
    newbalanceOrg,
    nameDest,
    oldbalanceDest,
    newbalanceDest,
    isFraud,
    isFlaggedFraud
)
select
    step,
    type,
    amount,
    nameOrig,
    oldbalanceOrg,
    newbalanceOrg,
    nameDest,
    oldbalanceDest,
    newbalanceDest,
    isFraud ,
    isFlaggedFraud
from trans;

select * from transactions;
---insertion is done 