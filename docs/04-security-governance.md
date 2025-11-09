# 04 – Security & Governance

## Security Controls

1. **Encryption**
   - All data is encrypted **in transit** (TLS) and **at rest** (KMS-managed keys).
   - Sensitive customer insight tables use an additional layer of encryption ("double encryption").

2. **Network Security**
   - Access to Databricks is restricted via private endpoints and VPC peering.
   - Only approved IP ranges and service principals can access the SQL Warehouses.

3. **Secrets Management**
   - Credentials for source systems are stored in a secrets manager and scoped to specific jobs only.
   - No hard-coded credentials inside notebooks or SQL scripts.

## Governance Model (Unity Catalog)

- **Catalogs** divide environments (e.g., `industrial_print_dev`, `industrial_print_prod`).
- **Schemas** map to layers and domains (e.g., `bronze`, `silver`, `gold`, `customer_insights`).
- **Roles and Groups**:
  - `data_engineer`: full access to Bronze/Silver, read Gold.
  - `data_analyst`: read-only access to Gold.
  - `psp_partner`: read-only access to specific customer insight tables via Delta Sharing.

All permissions are managed centrally and audited.

## Audit & Compliance

- Unity Catalog logs captures:
  - Who queried which table and when.
  - Changes to permissions and table definitions.
- System tables record Delta Sharing usage by recipient, dataset and time window.
- These logs form the basis for:
  - Internal controls (SOX-style traceability).
  - Usage-based billing for premium data products.
