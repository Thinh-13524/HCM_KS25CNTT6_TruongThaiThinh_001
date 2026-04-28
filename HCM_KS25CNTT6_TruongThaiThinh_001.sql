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
    manufactuer VARCHAR(100),
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

ALTER TABLE `orders`
ADD note TEXT;

ALTER TABLE products
CHANGE manufactuer nha_san_xuat VARCHAR(100);

INSERT INTO customers VALUES 
('C01', 'Nguyễn Văn A','nguyenvana@gmail.com','098123456','TPHCM'),
('C02', 'Nguyễn Văn B','nguyenvanb@gmail.com',NULL,'HN'),
('C03', 'Nguyễn Văn C','nguyenvanc@gmail.com','098323456','TPHCM'),
('C04', 'Nguyễn Văn D','nguyenvand@gmail.com','098423456','DN'),
('C05', 'Nguyễn Văn E','nguyenvane@gmail.com',NULL,'TPHCM');

INSERT INTO products VALUES
('P01','iPhone 18 ProMax', 30000000, 15),
('P02','MacBook Air M2', 45000000, 8),
('P03','iPhone 15 Mini', 25000000, 20),
('P04','Samsung 20 untra', 500000, 50),
('P05','Laptop acer nitro V', 1000000, 0);

INSERT INTO orders(order_id, order_date, total_amount, customer_id ) VALUES 
('OR001', '2025-10-01', 30000000, 'C01'),
('OR002', '2025-10-02', 25000000, 'C03'),
('OR003', '2025-10-03', 20000000, 'C01'),
('OR004', '2025-10-04', 15000000, 'C04'),
('OR005', '2025-10-05', 22000000, 'C03');

INSERT INTO order_details VALUES
('OR001', 'P01', 1, 30000000), 
('OR001', 'P02', 1, 45000000), 
('OR002', 'P02', 1, 45000000), 
('OR003', 'P01', 1, 30000000), 
('OR004', 'P04', 1, 500000);

UPDATE products 
SET nha_san_xuat = 'Apple'
WHERE product_id IN ('P01','P03');

UPDATE products 
SET  price = price * 1.1
WHERE nha_san_xuat = 'Apple';

DELETE FROM customer 
WHERE phone_number IS NULL;

SELECT *
FROM products  
WHERE price BETWEEN 10000000 AND 20000000;

SELECT *
FROM `orders` 
WHERE order_id = 'OR001';

SELECT o.order_id, o.order_date
FROM `order` o
JOIN customers ON o.customer_id = c.customer_id
WHERE c.address = 'TPHCM';

DROP TABLE IF EXISTS Order_Detail;
DROP TABLE IF EXISTS Orders;