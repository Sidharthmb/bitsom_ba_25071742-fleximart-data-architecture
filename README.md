# FlexiMart Data Architecture Project

*Student Name:* [M B Sidharth]  
*Student ID:* [bitsom_ba_25071742]  
*Email:* [mbsidharth@gmail.com]  
*Date:* [8/01/2026]

## Project Overview

This project implements an end-to-end data architecture for FlexiMart, an e-commerce company. The solution covers data ingestion from raw CSV files, data cleaning and transformation, relational database design, NoSQL analysis using MongoDB, and a dimensional data warehouse with analytical reporting.

## Repository Structure

├── data/  
│   ├── customers_raw.csv  
│   ├── products_raw.csv  
│   └── sales_raw.csv  
│  
├── part1-database-etl/  
│   ├── etl_pipeline.py  
│   ├── schema_documentation.md  
│   ├── business_queries.sql  
│   └── data_quality_report.txt  
│  
├── part2-nosql/  
│   ├── nosql_analysis.md  
│   ├── mongodb_operations.js  
│   └── products_catalog.json  
│  
├── part3-datawarehouse/  
│   ├── star_schema_design.md  
│   ├── warehouse_schema.sql  
│   ├── warehouse_data.sql  
│   └── analytics_queries.sql  
│  
└── README.md

## Technologies Used

- Python 3.x (pandas, mysql-connector-python)
- MySQL 8.0
- MongoDB 8.x
- MongoDB Shell (mongosh)

## Setup Instructions

### MySQL Setup

```sql
CREATE DATABASE fleximart;
CREATE DATABASE fleximart_dw;