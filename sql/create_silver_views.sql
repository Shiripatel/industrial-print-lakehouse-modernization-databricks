-- Create Silver (curated) tables/views
CREATE SCHEMA IF NOT EXISTS industrial_print.silver;

-- Clean orders: enforce types, normalize status
CREATE OR REPLACE TABLE industrial_print.silver.orders_clean AS
SELECT
  order_id,
  customer_id,
  psp_id,
  CAST(order_date AS TIMESTAMP) AS order_date,
  UPPER(TRIM(status)) AS order_status,
  COALESCE(currency, 'USD') AS currency,
  CAST(total_amount AS DECIMAL(10,2)) AS total_amount,
  ingest_ts
FROM industrial_print.bronze.orders;

-- Active providers
CREATE OR REPLACE VIEW industrial_print.silver.providers_active AS
SELECT
  psp_id,
  psp_name,
  region,
  timezone,
  onboarded_date
FROM industrial_print.bronze.providers
WHERE is_active = TRUE;

-- Filtered events with valid type
CREATE OR REPLACE TABLE industrial_print.silver.events_clean AS
SELECT
  event_id,
  order_id,
  event_type,
  CAST(event_ts AS TIMESTAMP) AS event_ts,
  machine_id,
  site_code
FROM industrial_print.bronze.events
WHERE event_type IS NOT NULL;
