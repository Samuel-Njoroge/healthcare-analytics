import great_expectations as gx
import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

context = gx.get_context()

# MotherDuck connection details
motherduck_token = os.getenv("MOTHERDUCK_TOKEN")
motherduck_database = os.getenv("MOTHERDUCK_DATABASE", "healthcare")
patients_table = os.getenv("MOTHERDUCK_PATIENTS_TABLE", "staging.stg_patients")

connection_string = (
    f"duckdb:///md:{motherduck_database}"
    f"?motherduck_token={motherduck_token}"
)

data_source = context.data_sources.add_or_update_sql(
    name="motherduck",
    connection_string=connection_string
)
data_asset = data_source.add_table_asset(
    name="patients asset",
    table_name=patients_table
)

batch_definition = data_asset.add_batch_definition_whole_table("batch definition")
batch = batch_definition.get_batch()

# Expectation
"""
Checks the birth_date column exists.
"""
expectation = gx.expectations.ExpectColumnToExist(
    column="birth_date",
    severity="critical"
)

# Validate
validation_result = batch.validate(expectation)
print(expectation)
