import pandas as pd
from sqlalchemy import create_engine, text
from dotenv import load_dotenv
import os
load_dotenv()
def run_load():

    db_path = f"postgresql+psycopg2://{os.getenv('DB_USER')}:{os.getenv('DB_PASSWORD')}@{os.getenv('DB_HOST')}:{os.getenv('DB_PORT')}/{os.getenv('DB_NAME')}"
    try:
        engine = create_engine(db_path)
        print("Successfully connected to the database.")

        csv_path = 'csv_files/telco_churn.csv'
        print(f"Reading file from {csv_path}...")
        df = pd.read_csv(csv_path)
        df.columns = df.columns.str.replace(' ', '_').str.lower()
        df['totalcharges'] = pd.to_numeric(df['totalcharges'], errors = 'coerce')
        with engine.begin() as connection:
            print(f"Loading data into the raw_customers table...")
            df.to_sql('raw_customers', con=connection, if_exists='replace', index=False)
            print("Commit executed!")
    except Exception as e:
        print(f"An error has occured: {e}")
    finally:
        engine.dispose()
if __name__ == "__main__":
    run_load()