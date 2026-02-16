import great_expectations as gx
import pandas as pd


# Read data
df = pd.read_csv('')

# Context
context = gx.get_context()

data_source = context.data_sources.add_pandas("pandas")
data_asset = data_source.add_dataframe_asset(name="medications assets")

batch_definition = data_asset.add_batch_definition_whole_dataframe("batch definition")
batch = batch_definition.get_batch(batch_parameters={"dataframe": df})

# Expectation
"""
Checks the minimum & maximum value for the base_cost.
"""
expectation = gx.expectations.ExpectColumnMaxToBeBetween(
    column="base_cost",
    min_value=0.1,
    max_value=7000,
    severity="warning"
)

# Validate
validation_result = batch.validate(expectation)
print(validation_result)
