---1.understanding

select * from transactions;

--2.total transactions

select count(*) as total_transactions
  from transactions;

-- 3.types of transactions and count
select type,count(*) as total_type from transactions 
  group by type order by 2 desc;

-- 4.fraud vs non-fraud
select isfraud,count(*) as total from transactions
  group by 1 order by 2 desc;
--0 means not an fraud and 1 means fraud

-- 5.fraud count by  transaction type
select type, count(*)as fraud_count
  from transactions where isfraud=1
     group by 1 ;

--6. amount distribution sanity check
select
  min(amount) as min_amount,
  max(amount) as max_amount,
  avg(amount) as avg_amount
from transactions;

--7.Top 10 Highest Amount Transactions
select 
  txn_id ,type,amount,isfraud
  from transactions 
  order by 3 desc limit 10;
