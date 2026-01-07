\# NoSQL Database Analysis for FlexiMart



\## Section A: Limitations of RDBMS (Relational Databases)



Relational databases such as MySQL are designed around fixed schemas, which makes them less suitable for highly diverse and evolving product catalogs. In FlexiMart’s case, different product types can have very different attributes. For example, laptops require attributes such as RAM, processor, and storage, while shoes require size, color, and material. In a relational model, this would either require a very wide table with many nullable columns or multiple related tables, increasing complexity and reducing clarity.



Frequent schema changes are another limitation. Each time a new product type with new attributes is introduced, the database schema must be altered using DDL operations. These changes are disruptive, risky in production environments, and require coordination across applications that depend on the schema.



Additionally, storing customer reviews is difficult in an RDBMS. Reviews naturally fit a nested structure (multiple reviews per product), but relational databases require separate tables and joins. This increases query complexity and reduces performance when retrieving product data along with its reviews.



---



\## Section B: Benefits of MongoDB (NoSQL)



MongoDB addresses these limitations through its flexible, document-based data model. Instead of enforcing a fixed schema, MongoDB allows each product document to have its own structure. This makes it easy to store diverse products such as laptops and shoes in the same collection, each with attributes relevant only to that product type.



Embedded documents are another major advantage. Customer reviews can be stored directly inside the product document as an array of review objects. This closely matches real-world data structures and allows product and review data to be retrieved in a single query without complex joins.



MongoDB also supports horizontal scalability through sharding. As FlexiMart’s product catalog and traffic grow, MongoDB can distribute data across multiple servers. This makes it easier to handle large volumes of product data and read-heavy workloads, which is common in e-commerce platforms.



---



\## Section C: Trade-offs of Using MongoDB



One disadvantage of MongoDB compared to MySQL is weaker support for complex transactional guarantees across multiple documents. While MongoDB supports transactions, they are generally more expensive and less mature than relational database transactions, making MySQL a better choice for highly consistent financial operations.



Another drawback is the lack of enforced schema constraints at the database level. While flexibility is a strength, it also increases the risk of inconsistent data if proper validation is not implemented at the application level. This shifts responsibility from the database to developers and requires stricter application-side controls.

