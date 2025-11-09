# Sample Unity Catalog Policies (Conceptual)

```sql
-- Example: grant engineers access to Bronze/Silver
GRANT SELECT, MODIFY
ON SCHEMA industrial_print.bronze
TO `group:data_engineers`;

GRANT SELECT, MODIFY
ON SCHEMA industrial_print.silver
TO `group:data_engineers`;

-- Analysts: read-only access to Gold
GRANT SELECT
ON SCHEMA industrial_print.gold
TO `group:data_analysts`;

-- PSP partners: restricted access to customer insight tables
GRANT SELECT
ON TABLE industrial_print.gold.fact_order_fulfillment
TO `group:psp_partner`;
```
