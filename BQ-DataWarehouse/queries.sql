# 0

CREATE OR REPLACE EXTERNAL TABLE `tlc_taxi_data.external_green_taxi_trips`
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://green_taxi_trip_data/data/green_tripdata_2022-*.parquet']
);

CREATE OR REPLACE TABLE tlc_taxi_data.green_taxi_trips AS
SELECT * FROM tlc_taxi_data.external_green_taxi_trips;

# 1
SELECT COUNT(*) FROM `tlc_taxi_data.external_green_taxi_trips`;

# 2
SELECT DISTINCT PULocationID 
FROM `tlc_taxi_data.green_taxi_trips`;

SELECT DISTINCT PULocationID 
FROM `tlc_taxi_data.external_green_taxi_trips`;

# 3
SELECT COUNT(*) 
FROM `tlc_taxi_data.green_taxi_trips`
WHERE fare_amount = 0;

# 4
CREATE OR REPLACE TABLE tlc_taxi_data.green_taxi_trips_partitioned_clustered
PARTITION BY DATE(lpep_pickup_datetime)
CLUSTER BY PUlocationID AS
SELECT * FROM tlc_taxi_data.green_taxi_trips;

# 5
SELECT DISTINCT PUlocationID
FROM tlc_taxi_data.green_taxi_trips
WHERE DATE(lpep_pickup_datetime) >='2022-06-01'
    AND DATE(lpep_pickup_datetime) <= '2022-06-30';

SELECT DISTINCT PUlocationID
FROM tlc_taxi_data.green_taxi_trips_partitioned_clustered
WHERE DATE(lpep_pickup_datetime) >='2022-06-01'
    AND DATE(lpep_pickup_datetime) <= '2022-06-30';