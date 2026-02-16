import great_expectations as gx
import pandas as pd


# Read data
df = pd.read_csv('')

# Context
context = gx.get_context()

data_source = context.data_sources.add_pandas("pandas")
data_asset = data_source.add_dataframe_asset(name="providers asset")

batch_definition = data_asset.add_batch_definition_whole_dataframe("batch definition")
batch = batch_definition.get_batch(batch_parameters={"dataframe": df})

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