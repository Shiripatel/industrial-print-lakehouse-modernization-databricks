-- Create Bronze (raw) tables
CREATE SCHEMA IF NOT EXISTS industrial_print.bronze;

CREATE TABLE IF NOT EXISTS industrial_print.bronze.orders (
  order_id STRING,
  customer_id STRING,
  psp_id STRING,
  order_date TIMESTAMP,
  status STRING,
  currency STRING,
  total_amount DECIMAL(10,2),
  ingest_ts TIMESTAMP
) USING DELTA;

CREATE TABLE IF NOT EXISTS industrial_print.bronze.providers (
  psp_id STRING,
  psp_name STRING,
  region STRING,
  timezone STRING,
  onboarded_date DATE,
  is_active BOOLEAN,
  ingest_ts TIMESTAMP
) USING DELTA;

CREATE TABLE IF NOT EXISTS industrial_print.bronze.events (
  event_id STRING,
  order_id STRING,
  event_type STRING,
  event_ts TIMESTAMP,
  machine_id STRING,
  site_code STRING,
  raw_payload STRING,
  ingest_ts TIMESTAMP
) USING DELTA;
