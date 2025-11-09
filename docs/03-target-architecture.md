# 03 – Target Architecture (Databricks Lakehouse)

## Design Principles

- **Single source of truth** on Delta Lake.
- **Medallion architecture** (Bronze / Silver / Gold) for clarity and reuse.
- **Decoupled compute and storage** for cost-efficient scaling.
- **Central governance** via Unity Catalog.
- **Simple, secure data sharing** to both internal and external consumers.

## Data Flow

1. **Ingestion – Bronze Layer**
   - Raw events are ingested from MongoDB (simulated here by JSON files).
   - Data is stored as Delta tables in the `industrial_print.bronze` schema.
   - Minimal transformations only: metadata enrichment and technical fields.

2. **Cleansing & Normalization – Silver Layer**
   - Apply schema normalization, basic data quality checks and type casting.
   - Create conformed dimensions (orders, customers, PSPs, dates).
   - Store in `industrial_print.silver` as analytical-ready but still granular data.

3. **Serving – Gold Layer**
   - Build star schemas and aggregated tables:
     - `gold.fact_order_fulfillment`
     - `gold.dim_customer`
     - `gold.dim_psp`
   - Optimized for BI dashboards and downstream ML features.

4. **Consumption**
   - Internal users query Gold tables via Databricks SQL Warehouses.
   - External PSPs receive curated datasets through **Delta Sharing**.
   - APIs can be layered on top (e.g., API Gateway) for embedded analytics.

## Tooling

- **Databricks Jobs** orchestrate Bronze → Silver → Gold notebooks.
- **Unity Catalog** manages catalogs, schemas, tables, permissions and lineage.
- **System tables & audit logs** track usage and enable usage-based pricing models.
