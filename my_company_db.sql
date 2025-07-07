use my_company_db;

CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10 , 2 ) NOT NULL,
    stock_quantity INT NOT NULL
);

insert into products (product_name, price, stock_quantity) values
('Laptop', 1200.00, 50),
('Mouse', 150.00, 200),
('Keyboard', 250.00, 150),
('Monitor', 400.00, 75),
('Webcam', 200.00, 100);

DELIMITER $$

create procedure GetProductsByMinStock (
In min_stock Int
)
Begin
Select 
Product_id, product_name, price, stock_quantity
From products
where stock_quantity >= min_stock;
End $$

DELIMITER ;

CALL GetProductsByMinStock(100);

CALL GetProductsByMinStock(150);

DELIMITER $$

CREATE FUNCTION CalculateTotalInventoryValue()
RETURNS DECIMAL(10, 2)
READS SQL DATA
BEGIN
    DECLARE total_value DECIMAL(10, 2);

    SELECT
        SUM(price * stock_quantity)
    INTO
        total_value
    FROM
        products;

    RETURN total_value;
END $$

DELIMITER ;

SELECT CalculateTotalInventoryValue() AS total_inventory_value;