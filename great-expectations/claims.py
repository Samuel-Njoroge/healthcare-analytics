import great_expectations as gx
import pandas as pd


# Read data
df = pd.read_csv('')

# Context
context = gx.get_context()

data_source = context.data_sources.add_pandas("pandas")
data_asset = data_source.add_dataframe_asset(name="claims asset")

batch_definition = data_asset.add_batch_definition_whole_dataframe("batch definition")
batch = batch_definition.get_batch(batch_parameters={"dataframe": df})

# Expectation
"""
Checks first status is in [CLOSED, BILLED].
"""
expectation = gx.expectations.ExpectColumnDistinctValuesToBeInSet(
    column="first_status",
    value_set=['CLOSED', 'BILLED'],
    severity="warning"
)

# Validate
validation_result = batch.validate(expectation)
print(expectation)