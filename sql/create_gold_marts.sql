-- Create Gold (serving) marts
CREATE SCHEMA IF NOT EXISTS industrial_print.gold;

-- Date dimension (simple)
CREATE OR REPLACE TABLE industrial_print.gold.dim_date AS
SELECT
  DATE(day) AS date_key,
  YEAR(day) AS year,
  MONTH(day) AS month,
  DAY(day) AS day,
  DATE_FORMAT(day, 'EEEE') AS day_of_week
FROM (
  SELECT sequence(date('2025-01-01'), date('2025-12-31'), interval 1 day) AS days
) d
LATERAL VIEW explode(days) x AS day;

-- Provider dimension
CREATE OR REPLACE TABLE industrial_print.gold.dim_psp AS
SELECT DISTINCT
  psp_id,
  psp_name,
  region,
  timezone,
  onboarded_date
FROM industrial_print.silver.providers_active;

-- Fact table: order fulfillment
CREATE OR REPLACE TABLE industrial_print.gold.fact_order_fulfillment AS
WITH order_events AS (
  SELECT
    o.order_id,
    o.customer_id,
    o.psp_id,
    CAST(o.order_date AS DATE) AS order_date,
    o.total_amount,
    MAX(CASE WHEN e.event_type = 'PRINT_COMPLETED' THEN e.event_ts END) AS print_completed_ts,
    MAX(CASE WHEN e.event_type = 'SHIPPED' THEN e.event_ts END) AS shipped_ts
  FROM industrial_print.silver.orders_clean o
  LEFT JOIN industrial_print.silver.events_clean e
    ON o.order_id = e.order_id
  GROUP BY
    o.order_id, o.customer_id, o.psp_id, o.order_date, o.total_amount
)
SELECT
  o.order_id,
  o.customer_id,
  o.psp_id,
  d.date_key AS order_date_key,
  o.total_amount,
  print_completed_ts,
  shipped_ts,
  CASE WHEN shipped_ts IS NOT NULL AND print_completed_ts IS NOT NULL
       THEN (unix_timestamp(shipped_ts) - unix_timestamp(print_completed_ts)) / 3600.0
       ELSE NULL END AS hours_between_print_and_ship
FROM order_events o
LEFT JOIN industrial_print.gold.dim_date d
  ON d.date_key = CAST(o.order_date AS DATE);
