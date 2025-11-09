# 02 – Legacy Architecture

## High-Level Design

The legacy data platform consisted of:

- **Operational DB:** MongoDB cluster used by the production workflow application.
- **Pipelines:** Kubernetes-based microservices running on Amazon EKS to extract and transform data.
- **Analytics Targets:**
  - Amazon Redshift for internal BI and finance reporting.
  - Amazon RDS for external customer-facing dashboards and APIs.

Data typically followed this path:

`MongoDB → ETL microservice → S3 (staging) → Redshift / RDS`

## Challenges

1. **Siloed Data and Duplicate Logic**
   - Separate pipelines were built for each consuming system.
   - Business logic was often copied rather than reused.

2. **Limited Lineage and Reprocessing**
   - No medallion pattern; raw and transformed data were mixed.
   - Replaying historical data required ad hoc scripts.

3. **Fragmented Governance**
   - Access rules managed separately in MongoDB, Redshift and RDS.
   - No single place to see who has access to which data.

4. **Slow Time-to-Market for New Data Products**
   - Launching a new dashboard or partner dataset required a new schema and pipeline.
   - Infrastructure changes were tightly coupled to application teams.

5. **Operational Overhead**
   - Managing EKS clusters, ETL containers and Redshift loads consumed significant engineering time.
   - Performance issues during peak ingestion windows affected downstream reporting.

These issues motivated the client to move towards a **Databricks Lakehouse** pattern with central governance and simpler sharing.
