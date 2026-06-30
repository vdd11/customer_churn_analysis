TRUNCATE TABLE fact_churn, dim_customer RESTART IDENTITY;

INSERT INTO dim_customer (customer_bk, gender, senior_citizen, partner, dependents)
SELECT DISTINCT customerid, gender, seniorcitizen, partner, dependents
FROM raw_customers;

INSERT INTO fact_churn (customer_sk, tenure, monthly_charges, total_charges, is_churned)
SELECT 
    d.customer_sk, 
    s.tenure, 
    s.monthlycharges, 
    s.totalcharges, 
    (s.churn = 'Yes') 
FROM raw_customers s
JOIN dim_customer d ON s.customerid = d.customer_bk;