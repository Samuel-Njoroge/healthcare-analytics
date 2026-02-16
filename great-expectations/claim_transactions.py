import great_expectations as gx
import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

context = gx.get_context()

# MotherDuck connection details
motherduck_token = os.getenv("MOTHERDUCK_TOKEN")
motherduck_database = os.getenv("MOTHERDUCK_DATABASE", "healthcare")
claim_transactions_table = os.getenv(
    "MOTHERDUCK_CLAIM_TRANSACTIONS_TABLE",
    "staging.stg_claim_transactions"
)

connection_string = (
    f"duckdb:///md:{motherduck_database}"
    f"?motherduck_token={motherduck_token}"
)

data_source = context.data_sources.add_or_update_sql(
    name="motherduck",
    connection_string=connection_string
)
data_asset = data_source.add_table_asset(
    name="claim transactions assets",
    table_name=claim_transactions_table
)

batch_definition = data_asset.add_batch_definition_whole_table("batch definition")
batch = batch_definition.get_batch()

# Expectation
"""
Checks transfer types are either [Charge, Transferin].
"""
expectation = gx.expectations.ExpectColumnDistinctValuesToBeInSet(
    column="transfer_type",
    value_set=[1, 2],
    severity="warning"
)

# Validate
validation_result = batch.validate(expectation)
print(validation_result)
