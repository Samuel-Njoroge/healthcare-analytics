import great_expectations as gx
import pandas as pd


# Read data
df = pd.read_csv('')

# Context
context = gx.get_context()

data_source = context.data_sources.add_pandas("pandas")
data_asset = data_source.add_dataframe_asset(name="encounters assets")

batch_definition = data_asset.add_batch_definition_whole_dataframe("batch definition")
batch = batch_definition.get_batch(batch_parameters={"dataframe": df})

# Expectation
"""
Checks encounter_class are either [wellness, inpatient, outpatient, urgentcare, ambulatory, emergency].
"""
expectation = gx.expectations.ExpectColumnDistinctValuesToBeInSet(
    column="encounter_class",
    value_set=['wellness', 'inpatient', 'outpatient', 'urgentcare', 'ambulatory', 'emergency'],
    severity="warning"
)

# Validate
validation_result = batch.validate(expectation)
print(validation_result)
