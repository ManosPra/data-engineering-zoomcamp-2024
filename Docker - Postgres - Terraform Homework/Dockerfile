winpty docker run -it \
  -e POSTGRES_USER="root" \
  -e POSTGRES_PASSWORD="root" \
  -e POSTGRES_DB="ny_taxi" \
  -v /'DE Zoomcamp'/'Docker - Postgres'/ny_taxi_postgres_data:/var/lib/postgresql/data \
  -p 5432:5432 \
  postgres:13


PGPASSWORD=root winpty pgcli -h localhost -p 5432 -U root -d ny_taxi
