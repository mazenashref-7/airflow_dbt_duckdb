from pathlib import Path
import duckdb

PROJECT_ROOT = Path(__file__).resolve().parent.parent
 
DB_PATH = PROJECT_ROOT / "include" / "dev.duckdb"
RAW_PATH = PROJECT_ROOT / "data" / "raw"

tables = {
    "raw_accounts": RAW_PATH / "accounts.csv",
    "raw_data_dictionary": RAW_PATH / "data_dictionary.csv",
    "raw_products": RAW_PATH / "products.csv",
    "raw_sales_pipeline": RAW_PATH / "sales_pipeline.csv",
    "raw_sales_teams": RAW_PATH / "sales_teams.csv",

}

con = duckdb.connect(str(DB_PATH))

con.execute("CREATE SCHEMA IF NOT EXISTS ods")

for table_name, csv_path in tables.items():

    con.execute(f"""
        CREATE OR REPLACE TABLE ods.{table_name} AS
        SELECT *
        FROM read_csv_auto('{csv_path}', header=True)
    """)

    count = con.execute(
        f"SELECT COUNT(*) FROM ods.{table_name}"
    ).fetchone()[0]

    print(f"Loaded ods.{table_name}: {count} rows")

con.close()

print("ODS load complete")