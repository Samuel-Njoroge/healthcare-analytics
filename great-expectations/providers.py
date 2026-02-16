import great_expectations as gx
import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

context = gx.get_context()

# MotherDuck connection details
motherduck_token = os.getenv("MOTHERDUCK_TOKEN")
motherduck_database = os.getenv("MOTHERDUCK_DATABASE", "healthcare")
providers_table = os.getenv("MOTHERDUCK_PROVIDERS_TABLE", "staging.stg_providers")

connection_string = (
    f"duckdb:///md:{motherduck_database}"
    f"?motherduck_token={motherduck_token}"
)

data_source = context.data_sources.add_or_update_sql(
    name="motherduck",
    connection_string=connection_string
)
data_asset = data_source.add_table_asset(
    name="providers asset",
    table_name=providers_table
)

batch_definition = data_asset.add_batch_definition_whole_table("batch definition")
batch = batch_definition.get_batch()

# Expectation
"""
Checks the length of the zip code not more than five digits.
"""
expectation = gx.expectations.ExpectColumnValueLengthsToBeBetween(
    column="zip_code",
    min_value=3,
    max_value=5,
    strict_max=True,
    severity="critical"
)

# Validate
validation_result = batch.validate(expectation)
print(expectation)
