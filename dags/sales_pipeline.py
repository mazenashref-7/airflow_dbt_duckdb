from datetime import datetime, timedelta

from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.operators.python import PythonOperator
from airflow.models import Variable

default_args = {
    "owner": "mazen",
    "retries": 2,
    "retry_delay": timedelta(minutes=1),
}

with DAG(
    dag_id="sales_pipeline",
    start_date=datetime(2026, 1, 1),
    default_args=default_args,
    schedule="@daily",
    catchup=False
) as dag:

    extraction = BashOperator(
        task_id="extraction",
        bash_command="python /usr/local/airflow/scripts/load_to_ods.py",
    )

    transformation_staging = BashOperator(
        task_id="transformation_staging",
        cwd="/usr/local/airflow/dbt_first_project",
        bash_command=(
            "dbt run "
            "--profiles-dir /usr/local/airflow/profiles "
            "--select staging"
        ),
    )

    transformation_marts = BashOperator(
        task_id="transformation_marts",
        cwd="/usr/local/airflow/dbt_first_project",
        bash_command=(
            "dbt run "
            "--profiles-dir /usr/local/airflow/profiles "
            "--select marts"
        ),
    )

    test = BashOperator(
        task_id="dbt_test",
        cwd="/usr/local/airflow/dbt_first_project",
        bash_command=(
            "dbt test "
            "--profiles-dir /usr/local/airflow/profiles"
        ),
    )

    extraction >> transformation_staging >> transformation_marts >> test
