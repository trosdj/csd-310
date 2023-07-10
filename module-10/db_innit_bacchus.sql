/*
    Emanuel Pagan, Wendy Rzechula, Sheila Smallwood, Dj Trost, Corey Ward
    Assignment 10.1 | Milestone #2
    9 July 2023
*/

/* bacchus database initialization script */

-- drop database user if exists
DROP USER IF EXISTS 'bacchus_user'@'localhost';

-- create bacchus_user and grant them all privileges to the bacchus database
CREATE USER 'bacchus_user'@'localhost' IDENTIFIED WITH mysql_native_password BY 'winery';

-- grant all privileges to the bacchus database to user bacchus_user on localhost
GRANT ALL PRIVILEGES ON bacchus.* TO 'bacchus_user'@'localhost';

-- drop tables if they are present
DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS distributor;
DROP TABLE IF EXISTS supply;
DROP TABLE IF EXISTS supplier;
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS wine;


-- create employee table
CREATE TABLE employee (
    employee_id INT NOT NULL AUTO_INCREMENT,
    employee_firstName VARCHAR(75) NOT NULL,
    employee_lastName VARCHAR(75) NOT NULL,
    employee_department VARCHAR(75) NULL,
    employee_hours VARCHAR(75) NULL,

    PRIMARY KEY (employee_id)
);

-- create supplier table
CREATE TABLE supplier (
    supplier_id INT NOT NULL AUTO_INCREMENT,
    supplier_name VARCHAR(75) NOT NULL,

    PRIMARY KEY (supplier_id)
);

-- create supply table
CREATE TABLE supply (
    supply_id INT NOT NULL AUTO_INCREMENT,
    supply_name VARCHAR(75) NOT NULL,
    supply_quantity INT NOT NULL,
    supplier_id INT NOT NULL,

    PRIMARY KEY (supply_id),

    CONSTRAINT fk_supplier
    FOREIGN KEY (supplier_id)
    REFERENCES supplier (supplier_id)
);

-- create product table
CREATE TABLE product (
    product_id INT NOT NULL AUTO_INCREMENT,
    product_name VARCHAR(75) NOT NULL,
    product_amount INT NOT NULL,

    PRIMARY KEY (product_id)
);

-- create wine table
CREATE TABLE wine (
    wine_id INT NOT NULL AUTO_INCREMENT,
    wine_name VARCHAR(75) NOT NULL,
    wine_amount INT NOT NULL,

    PRIMARY KEY (wine_id)
);

-- create distributor table
CREATE TABLE distributor (
    distributor_id INT NOT NULL AUTO_INCREMENT,
    distributor_name VARCHAR(75) NOT NULL,
    wine_id INT NOT NULL,

    PRIMARY KEY (distributor_id),

    CONSTRAINT fk_wine
    FOREIGN KEY (wine_id)
    REFERENCES wine (wine_id)
);

-- insert employee records
INSERT INTO employee (employee_firstName, employee_lastName, employee_department, employee_hours)
VALUES ('Janet', 'Collins', 'Finance and Payroll', 0),
       ('Roz', 'Murphy', 'Marketing', 0),
       ('Bob', 'Ulrich', 'Marketing', 0),
       ('Henry', 'Doyle', 'Production', 0),
       ('Maria', 'Costanza', 'Distribution', 0),
       ('Stan', 'Bacchus', 'Owner', 0),
       ('Davis', 'Bacchus', 'Owner', 0);

-- insert supplier records
INSERT INTO supplier (supplier_name)
VALUES ('Supplier 1'),
       ('Supplier 2'),
       ('Supplier 3');

-- insert supply records
INSERT INTO supply (supply_name, supply_quantity, supplier_id)
SELECT 'bottles', 0, supplier_id FROM supplier WHERE supplier_name = 'Supplier 1'
UNION ALL
SELECT 'corks', 0, supplier_id FROM supplier WHERE supplier_name = 'Supplier 1'
UNION ALL
SELECT 'labels', 0, supplier_id FROM supplier WHERE supplier_name = 'Supplier 2'
UNION ALL
SELECT 'boxes', 0, supplier_id FROM supplier WHERE supplier_name = 'Supplier 2'
UNION ALL
SELECT 'vats', 0, supplier_id FROM supplier WHERE supplier_name = 'Supplier 3'
UNION ALL
SELECT 'tubing', 0, supplier_id FROM supplier WHERE supplier_name = 'Supplier 3';

-- insert product records
INSERT INTO product (product_name, product_amount)
VALUES ('grapes', 0);

-- insert wine records
INSERT INTO wine (wine_name, wine_amount)
VALUES ('merlot', 0),
       ('cabernet', 0),
       ('chablis', 0),
       ('chardonnay', 0);

-- insert distributor records
INSERT INTO distributor (distributor_name, wine_id)
SELECT 'Distributor 1', wine_id FROM wine WHERE wine_name = 'merlot'
UNION ALL
SELECT 'Distributor 2', wine_id FROM wine WHERE wine_name = 'cabernet'
UNION ALL
SELECT 'Distributor 3', wine_id FROM wine WHERE wine_name = 'chablis'
UNION ALL
SELECT 'Distributor 4', wine_id FROM wine WHERE wine_name = 'chardonnay';