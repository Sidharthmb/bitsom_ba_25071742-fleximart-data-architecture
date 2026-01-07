-- =========================
-- DIMENSION: DATE
-- =========================
INSERT INTO dim_date
(date_key, full_date, day_of_week, day_of_month, month, month_name, quarter, year, is_weekend)
VALUES
(20240101,'2024-01-01','Monday',1,1,'January','Q1',2024,FALSE),
(20240105,'2024-01-05','Friday',5,1,'January','Q1',2024,FALSE),
(20240110,'2024-01-10','Wednesday',10,1,'January','Q1',2024,FALSE),
(20240115,'2024-01-15','Monday',15,1,'January','Q1',2024,FALSE),
(20240120,'2024-01-20','Saturday',20,1,'January','Q1',2024,TRUE),
(20240125,'2024-01-25','Thursday',25,1,'January','Q1',2024,FALSE),

(20240201,'2024-02-01','Thursday',1,2,'February','Q1',2024,FALSE),
(20240205,'2024-02-05','Monday',5,2,'February','Q1',2024,FALSE),
(20240210,'2024-02-10','Saturday',10,2,'February','Q1',2024,TRUE),
(20240215,'2024-02-15','Thursday',15,2,'February','Q1',2024,FALSE),
(20240220,'2024-02-20','Tuesday',20,2,'February','Q1',2024,FALSE),
(20240225,'2024-02-25','Sunday',25,2,'February','Q1',2024,TRUE),

(20240301,'2024-03-01','Friday',1,3,'March','Q1',2024,FALSE),
(20240305,'2024-03-05','Tuesday',5,3,'March','Q1',2024,FALSE),
(20240310,'2024-03-10','Sunday',10,3,'March','Q1',2024,TRUE),
(20240315,'2024-03-15','Friday',15,3,'March','Q1',2024,FALSE),
(20240320,'2024-03-20','Wednesday',20,3,'March','Q1',2024,FALSE),
(20240325,'2024-03-25','Monday',25,3,'March','Q1',2024,FALSE),
(20240330,'2024-03-30','Saturday',30,3,'March','Q1',2024,TRUE),

(20240401,'2024-04-01','Monday',1,4,'April','Q2',2024,FALSE),
(20240405,'2024-04-05','Friday',5,4,'April','Q2',2024,FALSE),
(20240410,'2024-04-10','Wednesday',10,4,'April','Q2',2024,FALSE),
(20240415,'2024-04-15','Monday',15,4,'April','Q2',2024,FALSE),
(20240420,'2024-04-20','Saturday',20,4,'April','Q2',2024,TRUE),
(20240425,'2024-04-25','Thursday',25,4,'April','Q2',2024,FALSE),
(20240430,'2024-04-30','Tuesday',30,4,'April','Q2',2024,FALSE),
(20240501,'2024-05-01','Wednesday',1,5,'May','Q2',2024,FALSE),
(20240505,'2024-05-05','Sunday',5,5,'May','Q2',2024,TRUE),
(20240510,'2024-05-10','Friday',10,5,'May','Q2',2024,FALSE),
(20240515,'2024-05-15','Wednesday',15,5,'May','Q2',2024,FALSE);


-- =========================
-- DIMENSION: PRODUCT
-- =========================
INSERT INTO dim_product
(product_id, product_name, category, subcategory, unit_price)
VALUES
('P001','Samsung Galaxy S21','Electronics','Smartphones',45999),
('P002','Nike Running Shoes','Fashion','Footwear',3499),
('P003','Apple MacBook Pro','Electronics','Laptops',52999),
('P004','Levis Jeans','Fashion','Clothing',2999),
('P005','Sony Headphones','Electronics','Audio',1999),
('P006','Organic Almonds','Groceries','Dry Fruits',899),
('P007','HP Laptop','Electronics','Laptops',52999),
('P008','Adidas T-Shirt','Fashion','Clothing',1299),
('P009','Basmati Rice 5kg','Groceries','Rice',650),
('P010','OnePlus Nord','Electronics','Smartphones',26999),
('P011','Puma Sneakers','Fashion','Footwear',4599),
('P012','Dell Monitor','Electronics','Monitors',12999),
('P013','Woodland Shoes','Fashion','Footwear',5499),
('P014','iPhone 13','Electronics','Smartphones',69999),
('P015','Organic Honey','Groceries','Honey',450);

-- =========================
-- DIMENSION: CUSTOMER
-- =========================
INSERT INTO dim_customer
(customer_id, customer_name, city, state, customer_segment)
VALUES
('C001','Rahul Sharma','Bangalore','Karnataka','High Value'),
('C002','Priya Patel','Mumbai','Maharashtra','Medium Value'),
('C003','Amit Kumar','Delhi','Delhi','Low Value'),
('C004','Sneha Reddy','Hyderabad','Telangana','Medium Value'),
('C005','Vikram Singh','Chennai','Tamil Nadu','High Value'),
('C006','Anjali Mehta','Bangalore','Karnataka','Medium Value'),
('C007','Ravi Verma','Pune','Maharashtra','Low Value'),
('C008','Pooja Iyer','Bangalore','Karnataka','Medium Value'),
('C009','Karthik Nair','Kochi','Kerala','Low Value'),
('C010','Deepa Gupta','Delhi','Delhi','High Value'),
('C011','Arjun Rao','Hyderabad','Telangana','Medium Value'),
('C012','Lakshmi Krishnan','Chennai','Tamil Nadu','Low Value');

-- =========================
-- FACT TABLE: SALES
-- =========================
INSERT INTO fact_sales
(date_key, product_key, customer_key, quantity_sold, unit_price, discount_amount, total_amount)
VALUES
(20240115,1,1,1,45999,0,45999),
(20240120,2,2,2,3499,0,6998),
(20240201,3,3,1,52999,0,52999),
(20240210,4,4,2,2999,0,5998),
(20240225,5,5,3,1999,0,5997),
(20240305,6,6,4,899,0,3596),
(20240310,7,7,1,52999,0,52999),
(20240320,8,8,3,1299,0,3897),
(20240401,9,9,5,650,0,3250),
(20240410,10,10,1,26999,0,26999);