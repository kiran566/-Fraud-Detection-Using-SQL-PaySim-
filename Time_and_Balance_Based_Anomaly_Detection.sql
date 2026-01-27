-- catching suspicious behaviour 
select * from transactions;

select nameorig,step,count(*)as txn_count
   from transactions 
        group by 1,2  having count(*)>1 order by 3 desc;

--  Multiple Receivers from One Sender
select * from transactions;
select 
    nameOrig AS sender,
    count(distinct nameDest) as receivers_count
from transactions
group by 1 order by 2 desc ;

-- sudden balance drop

select txn_id,step,type,amount,nameorig, oldbalanceorg,newbalanceorg
 from transactions where oldbalanceorg>0 and newbalanceorg=0 order by oldbalanceorg desc ;

-- checking on which balance drop is done more

select type,count(*) as balance_drop_count from(select txn_id,step,type,amount,nameorig, oldbalanceorg,newbalanceorg
 from transactions where oldbalanceorg>0 and newbalanceorg=0 and amount>100000  and isfraud=1 order by oldbalanceorg desc
)group by 1 order by 2 desc;

-- Detect High-Frequency Account Activity
select namedest,step,count(*) as txn_in_same_hour_for_same_receiver
  from  transactions group by 1,2
    having count(*) > 2
     order by 3 desc;

-- 
with high_frequency as (
    select
        nameOrig as account,
        step,
        count(*) as txn_count
    from transactions
    group by nameOrig, step order by count(*) desc
),

balance_drain as (
    select
        nameOrig as account,
        case
            when type = 'TRANSFER' then 'HIGH_RISK_BALANCE_DRAIN'
            when type = 'CASH_OUT' and amount > 100000 then 'MEDIUM_RISK_BALANCE_DRAIN'
        end as reason
    from transactions
    where oldbalanceOrg > 0
      and newbalanceOrg = 0
      and (
            type = 'TRANSFER'
         or (type = 'CASH_OUT' and amount > 100000)
      )
)

select distinct account, 'HIGH_FREQUENCY_ACTIVITY' as reason
from high_frequency

union

select distinct account, reason
from balance_drain;



