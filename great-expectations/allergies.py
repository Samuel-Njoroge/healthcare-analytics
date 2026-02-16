import great_expectations as gx
import os
from dotenv import load_dotenv


# Load environment variables
load_dotenv()

context = gx.get_context()

# MotherDuck connection details
motherduck_token = os.getenv("MOTHERDUCK_TOKEN")
motherduck_database = os.getenv("MOTHERDUCK_DATABASE", "healthcare")
allergies_table = os.getenv("MOTHERDUCK_ALLERGIES_TABLE", "staging.stg_allergies")

# Expectation Suite
suite_name = "stg_allergies_expectation_suite"
suite = gx.ExpectationSuite(name=suite_name)

suite = context.suites.add(suite)

connection_string = (
    f"duckdb:///md:{motherduck_database}"
    f"?motherduck_token={motherduck_token}"
)

data_source = context.data_sources.add_or_update_sql(
    name="motherduck",
    connection_string=connection_string
)
data_asset = data_source.add_table_asset(
    name="allergies assets",
    table_name=allergies_table
)

batch_definition = data_asset.add_batch_definition_whole_table("batch definition")
batch = batch_definition.get_batch()

# Expectation  1: category
"""
Checks category is in [environment, food, medication].
"""
expectation = gx.expectations.ExpectColumnDistinctValuesToBeInSet(
    column="category",
    value_set=['environment', 'food', 'medication'],
    severity="warning"
)

# Add Expectation 1 to Suite
suite.add_expectation(expectation)

# Expectation 2: 
"""
Checks system is in [RxNorm, SNOMED-CT]
"""
suite.add_expectation(
    gx.expectations.ExpectColumnDistinctValuesToBeInSet(
        column="system",
        value_set=["RxNorm", "SNOMED-CT"],
        severity="warning"
    )
)

# Retrieve an Expectation Suite
suite_name = (
    "stg_allergies_expectation_suite"
)

suite = context.suites.get(name=suite_name)
