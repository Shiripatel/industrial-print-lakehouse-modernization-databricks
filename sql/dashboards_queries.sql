-- Example queries for BI dashboards

-- 1. PSP performance: on-time shipping rate
SELECT
  p.psp_name,
  COUNT(f.order_id) AS total_orders,
  AVG(CASE WHEN f.shipped_ts IS NOT NULL THEN 1.0 ELSE 0.0 END) AS ship_rate
FROM industrial_print.gold.fact_order_fulfillment f
JOIN industrial_print.gold.dim_psp p
  ON f.psp_id = p.psp_id
GROUP BY p.psp_name
ORDER BY ship_rate DESC;

-- 2. Revenue by month
SELECT
  d.year,
  d.month,
  SUM(f.total_amount) AS revenue
FROM industrial_print.gold.fact_order_fulfillment f
JOIN industrial_print.gold.dim_date d
  ON f.order_date_key = d.date_key
GROUP BY d.year, d.month
ORDER BY d.year, d.month;

-- 3. Average hours between print and ship by PSP
SELECT
  p.psp_name,
  AVG(f.hours_between_print_and_ship) AS avg_hours
FROM industrial_print.gold.fact_order_fulfillment f
JOIN industrial_print.gold.dim_psp p
  ON f.psp_id = p.psp_id
WHERE f.hours_between_print_and_ship IS NOT NULL
GROUP BY p.psp_name
ORDER BY avg_hours;
