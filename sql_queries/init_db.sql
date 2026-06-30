
CREATE TABLE raw_customers (
customerID VARCHAR(255),
gender VARCHAR(255),
SeniorCitizen INTEGER,
Partner VARCHAR(255),
Dependents VARCHAR(255),
tenure INTEGER,
PhoneService VARCHAR(255),
MultipleLines VARCHAR(255),
InternetService VARCHAR(255),
OnlineSecurity VARCHAR(255),
OnlineBackup VARCHAR(255),
DeviceProtection VARCHAR(255),
TechSupport VARCHAR(255),
StreamingTV VARCHAR(255),
StreamingMovies VARCHAR(255),
Contract VARCHAR(255),
PaperlessBilling VARCHAR(255),
PaymentMethod VARCHAR(255),
MonthlyCharges DECIMAL(10,2),
TotalCharges VARCHAR(255),
Churn VARCHAR(255)
);

DROP TABLE IF EXISTS fact_churn CASCADE;
DROP TABLE IF EXISTS dim_customer CASCADE;

CREATE TABLE dim_customer (
    customer_sk SERIAL PRIMARY KEY,
    customer_bk VARCHAR(50) UNIQUE,
    gender VARCHAR(10),
    senior_citizen INTEGER,
    partner VARCHAR(10),
    dependents VARCHAR(10)
);

CREATE TABLE fact_churn (
    churn_sk SERIAL PRIMARY KEY,
    customer_sk INTEGER REFERENCES dim_customer(customer_sk),
    tenure INTEGER,
    monthly_charges DECIMAL(10, 2),
    total_charges DECIMAL(10, 2),
    is_churned BOOLEAN
);