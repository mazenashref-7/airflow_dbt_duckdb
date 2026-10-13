import duckdb

path = r"D:\Project__\airflow_dbt\airflow_dbt_duckdb\dbt_first_project\dev.duckdb"

conn = duckdb.connect(path)

print(conn.sql("SHOW ALL TABLES").fetchall())

conn.close()