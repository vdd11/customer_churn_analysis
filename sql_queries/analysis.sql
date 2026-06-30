--customer retention

SELECT 
is_churned,
COUNT(*) as count,
ROUND(100.0 * COUNT(*)/SUM(COUNT(*)) OVER(), 2) as percentage

FROM fact_churn
GROUP BY is_churned


--tenure buckets

SELECT
    CASE 
        WHEN tenure < 6 THEN '0 to 6 Months'
        WHEN tenure < 24 THEN '6 to 24 Months'
        ELSE '2+ Years'
    END AS tenure_bucket,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN is_churned THEN 1 ELSE 0 END) AS churned_customers
FROM fact_churn
GROUP BY tenure_bucket;

--senior citizen to churn correlation

SELECT
    dim_customer.senior_citizen,
    COUNT(*) as total_customers,
    SUM(CASE WHEN fact_churn.is_churned THEN 1 ELSE 0 END) AS churned_count,
    ROUND(100.0 * AVG(fact_churn.is_churned::int), 2) as churn_percent
FROM fact_churn
JOIN dim_customer ON
    fact_churn.customer_sk = dim_customer.customer_sk
GROUP BY dim_customer.senior_citizen


--SELECT COUNT(*) FROM fact_churn WHERE total_charges IS NULL;

--SELECT * FROM fact_churn WHERE tenure = 0 AND total_charges > 0;

--SELECT * FROM fact_churn 
--WHERE total_charges IS NULL AND tenure = 0;

--SELECT f.*, d.gender, d.senior_citizen, d.partner 
--FROM fact_churn f
--JOIN dim_customer d ON f.customer_sk = d.customer_sk