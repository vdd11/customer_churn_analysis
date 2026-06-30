import pandas as pd

def generate_schema(csv, name):

    df = pd.read_csv(csv)
    type_mapping = {'int64':'INTEGER', 'float64': 'DECIMAL(10,2)', 'object':'VARCHAR(255)', 'bool':'BOOLEAN'}
    c = []

    for col,dtype in df.dtypes.items():
        sqltype = type_mapping.get(str(dtype), 'VARCHAR(255)')
        c.append(f"{col} {sqltype}")
    sql = f"CREATE TABLE {name} (\n" + ",\n".join(c) + "\n);"
    return sql
print(generate_schema('csv_files/telco_churn.csv', 'raw_customers'))