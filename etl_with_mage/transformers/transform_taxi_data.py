if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(data, *args, **kwargs):
    processed_data = data[(data['passenger_count']>0) & (data['trip_distance']>0)]
    
    processed_data['lpep_pickup_date'] = processed_data['lpep_pickup_datetime'].dt.date
    # print(processed_data['VendorID'].unique().tolist())
    print('Columns converted from CamelCase to snake_case: {}'.format(processed_data.filter(regex=("(?<=[a-z])(?=[A-Z])")).columns))
    processed_data.columns = (processed_data.columns
                             .str.replace('(?<=[a-z])(?=[A-Z])', '_', regex=True)
                             .str.lower()
                              )

    return processed_data


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert len(output[~output['vendor_id'].isin([1,2])]) == 0 , 'There are vendor ids not in [1,2]'
    assert output['passenger_count'].isin([0]).sum() == 0 , 'There are rides with 0 passengers'
    assert output['trip_distance'].isin([0]).sum() == 0 , 'There are rides with 0 trip distance'
    assert output is not None, 'The output is undefined'
