CREATE DATABASE SaleManagement;
USE SaleManagement;

CREATE TABLE customers (
	customer_id INT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone_number VARCHAR(15),
    address TEXT
);

CREATE TABLE products (
	product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(15 ,2) NOT NULL,
    stock_quantity INT DEFAULT 0
);

CREATE TABLE orders (
	order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(15, 2) DEFAULT 0,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_details (
	order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    unit_price DECIMAL(15, 2),
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders (order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO customers VALUES 
(1, 'Nguyễn Văn A','nguyenvana@gmail.com','098123456','HCM'),
(2, 'Nguyễn Văn B','nguyenvanb@gmail.com','098223456','Đà Nẵng'),
(3, 'Nguyễn Văn C','nguyenvanc@gmail.com','098323456','Hà Nội'),
(4, 'Nguyễn Văn D','nguyenvand@gmail.com','098423456','Thanh Hóa'),
(5, 'Nguyễn Văn E','nguyenvane@gmail.com','098523456','Bình Thuận');

INSERT INTO products VALUES
(1,'iPhone 18 ProMax', 30000000, 15),
(2,'MacBook Air M2', 45000000, 8),
(3,'iPhone 15 Mini', 25000000, 20),
(4,'Samsung 20 untra', 500000, 50),
(5,'Laptop acer nitro V', 1000000, 0);

INSERT INTO orders(order_id, customer_id, order_date) VALUES 
(101, 1, '2025-10-01'),
(102, 2, '2025-10-02'),
(103, 1, '2025-10-05');

INSERT INTO order_details VALUES
(101, 1, 1, 300000000), 
(101, 4, 2, 500000),
(102, 2, 1, 45000000),
(102, 3, 1, 25000000),
(103, 3, 2, 25000000),
(103, 4, 1, 500000);

SET SQL_SAFE_UPDATES = 0;

UPDATE orders o 
SET total_amount = (SELECT SUM(quantity * unit_price)
FROM order_details od WHERE od.order_id = o.order_id);

UPDATE products SET price = price * 1.1 WHERE product_name LIKE '%iPhone%';

UPDATE products SET stock_quantity = stock_quantity - 5 WHERE product_id = 1;

DELETE FROM products WHERE stock_quantity = 0;

SELECT *
FROM products  WHERE stock_quantity >10;

SELECT *
FROM orders WHERE total_amount > 500000;

SELECT DISTINCT c.full_name, c.email
FROM customers as c
JOIN orders as o ON c.customer_id = o.customer_id 
JOIN order_details as od ON o.order_id = od.order_id
JOIN products as p ON od.product_id = p.product_id
WHERE p.product_name LIKE '%MacBook Air M2%' ;