# 01 – Business Context

## Client Overview

The client is a **global industrial print provider** that operates a cloud-based production workflow platform connecting end customers with a network of Print Service Providers (PSPs).

Typical examples of work:
- Custom packaging and labels
- Wide-format graphics and signage
- Direct mail and promotional materials

## Data Flow in the Business

1. Customers submit print orders via a web portal.
2. Orders are routed to a suitable PSP based on geography, capability and capacity.
3. As jobs move through onboarding → printing → finishing → shipping, operators scan barcodes and update statuses.
4. Each scan generates **events** with timestamps, machine identifiers and job metadata.
5. Operational data is used by:
   - Internal teams: capacity management, SLA monitoring, billing and revenue analytics.
   - External PSPs: performance dashboards, backlog visibility, contract reporting.

## Business Drivers for Modernization

- Need for **near real-time visibility** into production status across all PSPs.
- Demand from customers and PSPs for **self-service analytics**.
- Ambition to monetize data via **usage-based data products**.
- Legacy architecture was brittle, slow to change and difficult to govern.

The consulting engagement aimed to design and implement a modern lakehouse architecture that would unlock these capabilities.
