# Part 2: NoSQL Database Design Using MongoDB

This folder contains the NoSQL database design and implementation for FlexiMart using MongoDB. The focus of this part is to model flexible product data and embedded customer reviews using a document-based approach.

MongoDB is used to overcome the limitations of relational databases when handling semi-structured and evolving product attributes.

---

## Key Components

- *products_catalog.json*  
  JSON dataset containing product documents with nested specifications, tags, and embedded customer reviews.

- *mongodb_operations.js*  
  MongoDB shell script that loads the dataset, creates indexes, and performs analytical queries and updates.

- *nosql_analysis.md*  
  Conceptual analysis explaining why NoSQL was chosen, its advantages, and trade-offs compared to relational databases.

---

This part demonstrates NoSQL data modeling, embedded documents, aggregation queries, and indexing strategies.