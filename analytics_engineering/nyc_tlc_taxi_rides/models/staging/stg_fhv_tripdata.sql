{{
    config(
        materialized='view'
    )
}}

  select *
  from {{ source('staging','fhv_tripdata') }}
  WHERE EXTRACT(YEAR FROM pickup_datetime)=2019 


-- dbt build --select <model_name> --vars '{'is_test_run': 'false'}'
{% if var('is_test_run', default=true) %}

  limit 100

{% endif %}