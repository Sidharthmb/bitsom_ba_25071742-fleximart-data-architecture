# Star Schema Design – FlexiMart Data Warehouse

## Schema Overview

The FlexiMart Data Warehouse uses a star schema to analyze historical sales data. The design separates transactional sales facts from descriptive dimension data, enabling efficient analytical queries and reporting.

The schema is optimized for aggregation, drill-down, and roll-up analysis across time, products, and customers.

---

## Fact Table: fact_sales

*Grain:*  
One record per product sold per transaction date.

*Business Process:*  
Sales transactions.

### Measures
- quantity_sold
- unit_price
- discount_amount
- total_amount

### Foreign Keys
- date_key → dim_date
- product_key → dim_product
- customer_key → dim_customer

The fact table stores only numeric measures and foreign keys to ensure fast query performance.

---

## Dimension Table: dim_date

*Purpose:*  
Supports time-based reporting.

### Attributes
- date_key (YYYYMMDD)
- full_date
- day_of_week
- day_of_month
- month
- month_name
- quarter
- year
- is_weekend

---

## Dimension Table: dim_product

*Purpose:*  
Stores product-related descriptive information.

### Attributes
- product_key
- product_id
- product_name
- category
- subcategory
- unit_price

---

## Dimension Table: dim_customer

*Purpose:*  
Stores customer information for segmentation and analysis.

### Attributes
- customer_key
- customer_id
- customer_name
- city
- state
- customer_segment

A default “Unknown Customer” record is used to handle missing customer values.

---

## Design Decisions

The schema uses transaction-level granularity to support detailed analysis and aggregation at higher levels such as monthly or yearly reports.

Surrogate keys are used to improve performance and isolate the data warehouse from changes in source systems. Default dimension records ensure that no valid sales data is lost due to missing source values.

---

## Sample Data Flow

*Source Transaction:*  
Transaction ID: T004  
Customer ID: NULL  
Product ID: P002  
Quantity: 1  
Unit Price: 3499  
Date: 2024-01-18  

*Data Warehouse Records:*

fact_sales  
date_key: 20240118  
product_key: 3  
customer_key: 1  
quantity_sold: 1  
unit_price: 3499  
discount_amount: 0  
total_amount: 3499  

dim_customer  
customer_key: 1  
customer_name: 'Unknown Customer'

This approach preserves all sales data while maintaining referential integrity.