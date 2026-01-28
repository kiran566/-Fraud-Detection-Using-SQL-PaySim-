select * from transactions;
-- Which transactions show abnormal risk based on amount and balance behavior?

select txn_id,type,nameorig,namedest,
 case  when amount > 100000 then 1 else 0  end as hign_amount_transactions,
 case  when oldbalanceorg > 0 and newbalanceorg=0  then 1 else 0 end as sudden_balance_drop,
 case when 
 oldbalanceorg>0 and amount/oldbalanceorg>=0.8 then 1 else 0 end as high_amount_rel_balnce
from transactions; 

-- Which accounts behave abnormally over time?

select nameorig as high_risk_account, 
count(distinct namedest) as count_receivers,
count(*) as total_transactions,
sum(case when oldbalanceorg>0 and newbalanceorg=0 then 1 else 0 end) as count_balance_drain
from transactions group by 1 order by 2;

-- Are frauds concentrated in specific time steps?
select step,count(*) as total_txns,sum(isfraud) as total_frauds ,
round(100*sum(isfraud)/count(*),2)as fraud_rate from transactions group by 1 order by 4 desc;

-- Can we assign a fraud risk score to each account?
with account_features as (
    select
        nameorig as account,
        count(*) as total_txns,
        count(distinct namedest) as unique_receivers,
        sum(case when amount > 100000 then 1 else 0 end) as high_amount_txns,
        sum(case when oldbalanceorg > 0 and newbalanceorg = 0 then 1 else 0 end) as balance_drain_txns
    from transactions
    group by nameorig
)

select
    account,
    (case when total_txns > 10 then 3 else 0 end +
     case when balance_drain_txns > 0 then 3 else 0 end +
     case when high_amount_txns > 2 then 2 else 0 end +
     case when unique_receivers > 5 then 2 else 0 end
    ) as fraud_risk_score
from account_features
order by fraud_risk_score desc;

-- ready to use

create view fraud_features as
select
    txn_id,
    amount,
    oldbalanceOrg,
    newbalanceOrg,
    step,
    isfraud,

    case when amount > 100000 then 1 else 0 end as high_amount_flag,
    case when oldbalanceOrg > 0 and newbalanceOrg = 0 then 1 else 0 end as balance_drain_flag,
    case when oldbalanceOrg > 0 and amount / oldbalanceOrg > 0.8 then 1 else 0 end as ratio_flag
from transactions;
select * from fraud_features;

