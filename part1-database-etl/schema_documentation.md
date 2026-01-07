Database Schema Documentation – FlexiMart


1. Entity–Relationship Description
ENTITY: customers

Purpose:
Stores customer master data for all registered FlexiMart customers.

Attributes:

customer_id (PK): Unique identifier for each customer

first_name: Customer’s first name

last_name: Customer’s last name

email: Customer’s email address (nullable)

phone: Customer’s contact number

city: City of residence

registration_date: Date when the customer registered

Relationships:

One customer can place many orders

Relationship type: 1 : M with orders

ENTITY: products

Purpose:
Stores product catalog information.

Attributes:

product_id (PK): Unique product identifier

product_name: Name of the product

category: Product category (Electronics, Fashion, Groceries)

price: Selling price per unit

stock_quantity: Available stock

Relationships:

One product can appear in many order items

Relationship type: 1 : M with order_items

ENTITY: orders

Purpose:
Stores order-level transactional information.

Attributes:

order_id (PK): Unique order identifier

customer_id (FK): References customers.customer_id

order_date: Date of order

total_amount: Total order value

status: Order status (Completed, Pending, Cancelled)

Relationships:

One order belongs to one customer

One order can contain many order items

ENTITY: order_items

Purpose:
Stores line-item level details for each order.

Attributes:

order_item_id (PK): Unique line item identifier

order_id (FK): References orders.order_id

product_id (FK): References products.product_id

quantity: Quantity ordered

unit_price: Price per unit at time of sale

Relationships:

Many order items belong to one order

Many order items reference one product

2. Normalization Explanation (3NF)

The FlexiMart database schema is designed in Third Normal Form (3NF) to eliminate redundancy and ensure data integrity.

In this design, each table represents a single entity, and all attributes depend only on the primary key of that table. For example, in the customers table, attributes such as first name, email, and city depend solely on customer_id. There are no partial dependencies because all primary keys are single-column identifiers.

Functional dependencies are clearly defined:

customer_id → first_name, last_name, email, phone, city

product_id → product_name, category, price, stock_quantity

order_id → customer_id, order_date, total_amount, status

order_item_id → order_id, product_id, quantity, unit_price

There are no transitive dependencies, as non-key attributes do not depend on other non-key attributes. For example, product price is stored only in the products table and not repeated in the orders table.

This design prevents:

Update anomalies: Product price updates occur in one place

Insert anomalies: New products or customers can be added independently

Delete anomalies: Deleting an order does not remove customer or product records

Thus, the schema fully satisfies the requirements of Third Normal Form.

(~220 words)

3. Sample Data Representation
customers
customer_id	first_name	last_name	email	city
C001	Rahul	Sharma	rahul.sharma@gmail.com
	Bangalore
C002	Priya	Patel	priya.patel@yahoo.com
	Mumbai
products
product_id	product_name	category	price	stock_quantity
P001	Samsung Galaxy S21	Electronics	45999	150
P004	Levi’s Jeans	Fashion	2999	120
orders
order_id	customer_id	order_date	total_amount	status
1	C001	2024-01-15	45999	Completed
2	C002	2024-01-16	5998	Completed
order_items
order_item_id	order_id	product_id	quantity	unit_price
1	1	P001	1	45999
2	2	P004	2	2999