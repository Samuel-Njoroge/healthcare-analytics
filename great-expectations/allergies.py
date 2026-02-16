import great_expectations as gx
import pandas as pd


# Read data 
df = pd.read_csv('')

# Context
context = gx.get_context()

# Expectation Suite
suite_name = "stg_allergies_expectation_suite"
suite = gx.ExpectationSuite(name=suite_name)

suite = context.suites.add(suite)

data_source = context.data_sources.add_pandas("pandas")
data_asset = data_source.add_dataframe_asset(name="allergies assets")

batch_definition = data_asset.add_batch_definition_whole_dataframe("batch definition")
batch = batch_definition.get_batch(batch_parameters={"dataframe": df})

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