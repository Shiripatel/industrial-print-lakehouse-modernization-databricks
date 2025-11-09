# Global Industrial Print – Data Platform Modernization with Databricks SQL

This repository is a **consulting-style case study** showing how a global industrial print client (name anonymized) modernized its data platform using the **Databricks Lakehouse** on AWS.

It is designed as a **portfolio project** to demonstrate skills in:
- Data architecture & medallion design (Bronze / Silver / Gold)
- Databricks SQL and Delta Lake
- Unity Catalog governance
- Secure data sharing with Delta Sharing
- Building data products for internal and external customers

> All data in this repository is dummy/simulated and safe to publish.

---

## 🏗 High-Level Architecture

1. **Source systems**
   - Print workflow portal and operational databases (simulated via JSON files)
   - Events such as job scans, status updates and machine telemetry

2. **Bronze layer (raw)**
   - Raw ingested JSON from the operational systems stored as Delta tables

3. **Silver layer (curated)**
   - Cleaned and normalized data, conformed dimensions, basic data quality rules

4. **Gold layer (serving)**
   - Star-schema style marts for internal BI and external customer insights

5. **Governance & Sharing**
   - Unity Catalog for catalogs / schemas / tables / permissions
   - Delta Sharing for secure access to curated datasets for partners and customers

See `architecture/lakehouse-architecture.png` for a visual representation.

---

## 📁 Repository Structure

```text
industrial-print-lakehouse-modernization-databricks/
├─ README.md
├─ docs/
│   ├─ 01-business-context.md
│   ├─ 02-legacy-architecture.md
│   ├─ 03-target-architecture.md
│   ├─ 04-security-governance.md
│   └─ 05-business-impact.md
├─ architecture/
│   ├─ lakehouse-architecture.png
│   └─ lakehouse-architecture.txt
├─ notebooks/
│   ├─ 01_bronze_ingestion.ipynb
│   ├─ 02_silver_transformations.ipynb
│   ├─ 03_gold_dwh_modeling.ipynb
│   └─ 04_customer_insights_gold.ipynb
├─ sql/
│   ├─ create_bronze_tables.sql
│   ├─ create_silver_views.sql
│   ├─ create_gold_marts.sql
│   └─ dashboards_queries.sql
├─ infra/
│   ├─ databricks_job_definitions.json
│   └─ sample_unity_catalog_policies.md
└─ samples/
    ├─ sample_orders.json
    ├─ sample_providers.json
    └─ sample_events.json
```

---

## 🚀 Getting Started (Databricks)

1. Upload the repository (or selected folders) to your Databricks workspace or mount it via a repo.
2. Create a cluster with the **Spark** runtime of your choice.
3. Create these catalogs/schemas or adapt the SQL:
   - `industrial_print.bronze`
   - `industrial_print.silver`
   - `industrial_print.gold`
4. Run notebooks in order:
   1. `01_bronze_ingestion`
   2. `02_silver_transformations`
   3. `03_gold_dwh_modeling`
   4. `04_customer_insights_gold`

---

## 🔧 Tech Stack

- **Cloud**: AWS (simulated)
- **Platform**: Databricks Data Intelligence Platform
- **Storage**: Delta Lake on S3 (simulated paths: `/mnt/bronze`, `/mnt/silver`, `/mnt/gold`)
- **Governance**: Unity Catalog (policies described in `infra/sample_unity_catalog_policies.md`)
- **Consumption**: Databricks SQL, BI tools via SQL Warehouse, Delta Sharing

---

## ✨ Portfolio Usage

You can reference this project on your resume / LinkedIn as:

> "Designed and implemented a Databricks Lakehouse architecture for a global industrial print client (anonymized), including medallion data modeling, Delta Lake pipelines, Unity Catalog governance and Delta Sharing to external partners."

Feel free to fork and extend with your own dashboards, ML notebooks or infra-as-code.
