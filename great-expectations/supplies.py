import great_expectations as gx
import pandas as pd


# Read data
df = pd.read_csv('')

# Context
context = gx.get_context()

data_source = context.data_sources.add_pandas("pandas")
data_asset = data_source.add_dataframe_asset(name="supplies assets")

batch_definition = data_asset.add_batch_definition_whole_dataframe("batch definition")
batch = batch_definition.get_batch(batch_parameters={"dataframe": df})

# Expectation
"""
Checks the minimum & maximum value for the quantity.
"""
expectation = gx.expectations.ExpectColumnMaxToBeBetween(
    column="quantity",
    min_value=1,
    max_value=100,
    severity="critical"
)

# Validate
validation_result = batch.validate(expectation)
print(validation_result)
