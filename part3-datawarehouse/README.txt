# Part 3: Data Warehouse and Star Schema Design

This folder contains the analytical data warehouse implementation for FlexiMart. The warehouse is designed using a star schema to support reporting, trend analysis, and business intelligence use cases.

The design separates transactional facts from descriptive dimensions to enable efficient aggregation and historical analysis.

---

## Key Components

- *star_schema_design.md*  
  Conceptual explanation of the star schema design, including fact and dimension tables, design decisions, and sample data flow.

- *warehouse_schema.sql*  
  SQL script that creates the data warehouse schema, including dimension tables and the fact_sales table with foreign key constraints.

- *warehouse_data.sql*  
  SQL script used to populate dimension tables and the fact table with cleaned and validated data.

- *analytics_queries.sql*  
  Analytical SQL queries used to generate sales insights such as monthly revenue, category performance, and customer trends.

---

This part demonstrates dimensional modeling, surrogate key usage, and analytical query design.