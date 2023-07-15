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
DROP TABLE IF EXISTS work_hours;
DROP TABLE IF EXISTS supplier;
DROP TABLE IF EXISTS supply;
DROP TABLE IF EXISTS delivery;
DROP TABLE IF EXISTS grapes;
DROP TABLE IF EXISTS wine;
DROP TABLE IF EXISTS inventory;
DROP TABLE IF EXISTS distributor;


-- create employee table
CREATE TABLE employee (
    employee_id INT NOT NULL AUTO_INCREMENT,
    employee_firstName VARCHAR(75) NOT NULL,
    employee_lastName VARCHAR(75) NOT NULL,
    employee_address1 VARCHAR(75) NOT NULL,
    employee_address2 VARCHAR(75) NULL,
    employee_city VARCHAR(75) NOT NULL,
    employee_state VARCHAR(75) NOT NULL,
    employee_postal VARCHAR(75) NOT NULL,
    employee_phone VARCHAR(75) NOT NULL,
    employee_email VARCHAR(75) NOT NULL,
    employee_department VARCHAR(75) NULL,

    PRIMARY KEY (employee_id),
);

-- create hours table
CREATE TABLE work_hours (
    hours_id INT NOT NULL AUTO_INCREMENT,
    employee_id INT NOT NULL,
    work_day VARCHAR(75) NOT NULL,
    clock_in INT NOT NULL,
    lunch_in INT NOT NULL,
    lunch_out INT NOT NULL,
    clock_out INT NOT NULL,

    PRIMARY KEY (hours_id),

    CONSTRAINT fk_employee
    FOREIGN KEY (employee_id)
    REFERENCES employee (employee_id)
);

-- create supplier table
CREATE TABLE supplier (
    supplier_id INT NOT NULL AUTO_INCREMENT,
    supplier_name VARCHAR(75) NOT NULL,
    supplier_contact_firstName VARCHAR(75) NOT NULL,
    supplier_contact_lastName VARCHAR(75) NOT NULL,
    supplier_address1 VARCHAR(75) NOT NULL,
    supplier_address2 VARCHAR(75) NULL,
    supplier_city VARCHAR(75) NOT NULL,
    supplier_state VARCHAR(75) NOT NULL,
    supplier_postal VARCHAR(75) NOT NULL,
    supplier_phone VARCHAR(75) NOT NULL,
    supplier_email VARCHAR(75) NOT NULL,
    

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

-- create delivery table
CREATE TABLE delivery (
    delivery_id INT NOT NULL AUTO_INCREMENT,
    delivery_date VARCHAR(75) NOT NULL,
    expected_date VARCHAR(75) NOT NULL,
    invoice_number INT NOT NULL,
    employee_id INT NOT NULL,   -- Receiving Employee marked by employee_id
    supplier_id INT NOT NULL,

    PRIMARY KEY (delivery_id),

    CONSTRAINT fk_supplier
    FOREIGN KEY (supplier_id)
    REFERENCES supplier (supplier_id),

    CONSTRAINT fk_employee
    FOREIGN KEY (employee_id)
    REFERENCES employee (employee_id)
);

-- create grapes table
CREATE TABLE grapes (
    grapes_id INT NOT NULL AUTO_INCREMENT,
    grapes_name VARCHAR(75) NOT NULL,
    harvest_season INT NOT NULL,
    vineyard INT NOT NULL,

    PRIMARY KEY (grapes_id),
);

-- create wine table
CREATE TABLE wine (
    wine_id INT NOT NULL AUTO_INCREMENT,
    wine_name VARCHAR(75) NOT NULL,
    wine_quantity INT NOT NULL,
    wine_price INT NOT NULL,

    PRIMARY KEY (wine_id)
);

-- create inventory table
CREATE TABLE inventory (
    inventory_id INT NOT NULL AUTO_INCREMENT,
    wine_id INT NOT NULL,
    grapes_id INT NOT NULL,      -- grapes used marked by grape_id
    barrel_id INT NOT NULL,
    batch_id INT NOT NULL,
    storage_location INT NOT NULL,      -- warehouse number
    PRIMARY KEY (inventory_id),

    CONSTRAINT fk_wine
    FOREIGN KEY (wine_id)
    REFERENCES wine (wine_id),

    CONSTRAINT fk_grapes
    FOREIGN KEY (grapes_id)
    REFERENCES grapes (grapes_id)
);

-- create distributor table
CREATE TABLE distributor (
    distributor_id INT NOT NULL AUTO_INCREMENT,
    distributor_name VARCHAR(75) NOT NULL,
    distributor_address1 VARCHAR(75) NOT NULL,
    distributor_address2 VARCHAR(75) NULL,
    distributor_city VARCHAR(75) NOT NULL,
    distributor_state VARCHAR(75) NOT NULL,
    distributor_postal VARCHAR(75) NOT NULL,
    distributor_phone VARCHAR(75) NOT NULL,
    distributor_email VARCHAR(75) NOT NULL,
    wine_id INT NOT NULL,

    PRIMARY KEY (distributor_id),

    CONSTRAINT fk_wine
    FOREIGN KEY (wine_id)
    REFERENCES wine (wine_id)
);

-- insert employee records
INSERT INTO employee (employee_firstName, employee_lastName, employee_address1, employee_address2, employee_city, employee_state, employee_postal, employee_phone, employee_email, employee_department)
VALUES ('Janet', 'Collins', '58 West Wood Ave', null, 'Sylmar', 'CA', '91342', '(593) 795-9803', 'jcollins@bacchus.com', 'finance and payroll'),
       ('Roz', 'Murphy', '8979 High Ridge Lane', null, 'Tustin', 'CA', '92780', '(832) 770-2257', 'rmurphy@bacchus.com', 'marketing'),
       ('Bob', 'Ulrich', '32 Sussex St', null, 'Van Nuys', 'CA', '91405', '(733) 839-9630', 'bulrich@bacchus.com', 'marketing'),
       ('Henry', 'Doyle', '9768 Grove Avenue', null, 'Hayward', 'CA', '94541', '(698) 294-3319', 'hdoyle@bacchus.com', 'production'),
       ('Maria', 'Costanza', '80 Baker Road', null, 'Lancaster', 'CA', '93535', '(752) 303-8233', 'mcostanza@bacchus.com', 'distribution'),
       ('Stan', 'Bacchus', '72 Plymouth Street', null, 'Los Angeles', 'CA', '90004', '(344) 975-3898', 'sbacchus@bacchus.com', 'owner'),
       ('Davis', 'Bacchus', '6 East Applegate St', null, 'Sunnyvale, CA', '94087', '(946) 609-2696', 'dbacchus@bacchus.com', 'owner');

-- insert work_hours records
INSERT INTO work_hours (employee_id, work_day, clock_in, lunch_out, lunch_in, clock_out)
VALUES (1, '2022-10-31', 8:59:30, 11:30:45, 12:30:23, 17:30:32),
        (2, '2022-10-31', 8:57:03, 11:00:12, 12:00:45, 17:30:12),
        (3, '2022-10-31', 9:00:57, 12:30:32, 13:30:29, 17:30:58),
        (4, '2022-10-31', 8:55:03, 1:05:32, 14:05:56, 17:29:59),
        (5, '2022-10-31', 8:58:09, 11:30:23, 12:30:17, 17:30:02),
        (3, '2022-11-1', 9:01:01, 12:30:12, 13:30:58, 17:30:45);

-- insert supplier records
INSERT INTO supplier (supplier_name, supplier_contact_firstName, supplier_contact_lastName, supplier_address1, supplier_address2, supplier_city, supplier_state, supplier_postal, supplier_phone, supplier_email)
VALUES ('Supplier 1', 'Odell', 'Boyer', '6 East Greenview Road', 'Galloway', 'OH', '43119', '(504) 899-9970', 'oboyer@sup1.com'),
        ('Supplier 2', 'Saylor', 'Woods', '363 North Bay Meadows Road', 'Chesterton', 'IN', '46304', '(536) 822-7091', 'swoods@sup2.com'),
        ('Supplier 3', 'Lincoln', 'Whitaker', '9130 Delaware Street', 'Columbus', 'GA', '31904', '(835) 624-4092', 'lwhitaker@sup3.com');

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

-- insert grapes records
INSERT INTO grapes (grapes_name, harvest_season, vineyard)
VALUES ('merlot', 2022, 1),
        ('cabernet sauvignon', 2022, 1),
        ('chardonnay', 2022, 2);

-- insert wine records
INSERT INTO wine (wine_name, wine_quantity, wine_price, grapes_id)
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