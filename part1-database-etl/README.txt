# Part 1: Relational Database ETL and Data Quality

This folder contains the implementation of the relational database ETL pipeline for FlexiMart. The objective of this part is to extract raw CSV data, clean and transform it, and load it into a normalized relational database schema.

The ETL process also performs data quality checks such as duplicate detection, missing value handling, and date standardization.

---

## Key Components

- *etl_pipeline.py*  
  Python ETL script that extracts raw data, applies transformations, performs data quality checks, and loads the data into MySQL.

- *schema_documentation.md*  
  Detailed documentation of the relational database schema, including entity descriptions, relationships, and normalization justification (3NF).

- *business_queries.sql*  
  SQL queries used to answer business questions based on the relational database.

- *data_quality_report.txt*  
  Auto-generated report produced by the ETL pipeline summarizing detected data quality issues and resolutions.

- *requirements.txt*  
  Python dependencies required to run the ETL pipeline.

---

This part demonstrates core data engineering skills including ETL design, data validation, and relational modeling.