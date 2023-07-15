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
DROP TABLE IF EXISTS work_hours;
DROP TABLE IF EXISTS distributor;
DROP TABLE IF EXISTS inventory;
DROP TABLE IF EXISTS supply;
DROP TABLE IF EXISTS delivery;
DROP TABLE IF EXISTS grapes;
DROP TABLE IF EXISTS wine;
DROP TABLE IF EXISTS supplier;
DROP TABLE IF EXISTS employee;

-- create employee table
CREATE TABLE employee (
    employee_id INT NOT NULL AUTO_INCREMENT,
    employee_firstName VARCHAR(75) NOT NULL,
    employee_lastName VARCHAR(75) NOT NULL,
    employee_address_one VARCHAR(75) NOT NULL,
    employee_address_two VARCHAR(75) NULL,
    employee_city VARCHAR(75) NOT NULL,
    employee_state VARCHAR(75) NOT NULL,
    employee_postal VARCHAR(75) NOT NULL,
    employee_phone VARCHAR(75) NOT NULL,
    employee_email VARCHAR(75) NOT NULL,
    employee_department VARCHAR(75) NULL,

    PRIMARY KEY (employee_id)
);

-- create hours table
CREATE TABLE work_hours (
    hours_id INT NOT NULL AUTO_INCREMENT,
    employee_id INT NOT NULL,
    work_day DATE NOT NULL,
    clock_in TIME NOT NULL,
    lunch_in TIME NOT NULL,
    lunch_out TIME NOT NULL,
    clock_out TIME NOT NULL,

    PRIMARY KEY (hours_id),

    CONSTRAINT fk_hours_employee
    FOREIGN KEY (employee_id)
    REFERENCES employee (employee_id)
);

-- create supplier table
CREATE TABLE supplier (
    supplier_id INT NOT NULL AUTO_INCREMENT,
    supplier_name VARCHAR(75) NOT NULL,
    supplier_contact_firstName VARCHAR(75) NOT NULL,
    supplier_contact_lastName VARCHAR(75) NOT NULL,
    supplier_address_one VARCHAR(75) NOT NULL,
    supplier_address_two VARCHAR(75) NULL,
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

    CONSTRAINT fk_supply_supplier
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

    CONSTRAINT fk_delivery_supplier
    FOREIGN KEY (supplier_id)
    REFERENCES supplier (supplier_id),

    CONSTRAINT fk_delivery_employee
    FOREIGN KEY (employee_id)
    REFERENCES employee (employee_id)
);

-- create grapes table
CREATE TABLE grapes (
    grapes_id INT NOT NULL AUTO_INCREMENT,
    grapes_name VARCHAR(75) NOT NULL,
    harvest_season INT NOT NULL,
    vineyard INT NOT NULL,

    PRIMARY KEY (grapes_id)
);

-- create wine table
CREATE TABLE wine (
    wine_id INT NOT NULL AUTO_INCREMENT,
    wine_name VARCHAR(75) NOT NULL,
    wine_quantity INT NOT NULL,
    wine_price INT NOT NULL,
    grapes_id INT NOT NULL,

    PRIMARY KEY (wine_id)
);

-- create inventory table
CREATE TABLE inventory (
    inventory_id INT NOT NULL AUTO_INCREMENT,
    wine_id INT NOT NULL,
    grapes_id INT NOT NULL,
    barrel_id VARCHAR(75) NOT NULL,
    batch_id INT NOT NULL,
    storage_location VARCHAR(75) NOT NULL,
    PRIMARY KEY (inventory_id),

    CONSTRAINT fk_inventory_wine
    FOREIGN KEY (wine_id)
    REFERENCES wine (wine_id),

    CONSTRAINT fk_inventory_grapes
    FOREIGN KEY (grapes_id)
    REFERENCES grapes (grapes_id)
);

-- create distributor table
CREATE TABLE distributor (
    distributor_id INT NOT NULL AUTO_INCREMENT,
    distributor_name VARCHAR(75) NOT NULL,
    distributor_address_one VARCHAR(75) NOT NULL,
    distributor_address_two VARCHAR(75) NULL,
    distributor_city VARCHAR(75) NOT NULL,
    distributor_state VARCHAR(75) NOT NULL,
    distributor_postal VARCHAR(75) NOT NULL,
    distributor_phone VARCHAR(75) NOT NULL,
    distributor_email VARCHAR(75) NOT NULL,
    wine_id INT NOT NULL,

    PRIMARY KEY (distributor_id),

    CONSTRAINT fk_distributor_wine
    FOREIGN KEY (wine_id)
    REFERENCES wine (wine_id)
);

-- insert employee records
INSERT INTO employee (employee_firstName, employee_lastName, employee_address_one, employee_address_two, employee_city, employee_state, employee_postal, employee_phone, employee_email, employee_department)
VALUES ('Janet', 'Collins', '58 West Wood Ave', null, 'Sylmar', 'CA', '91342', '(593) 795-9803', 'jcollins@bacchus.com', 'finance and payroll'),
       ('Roz', 'Murphy', '8979 High Ridge Lane', null, 'Tustin', 'CA', '92780', '(832) 770-2257', 'rmurphy@bacchus.com', 'marketing'),
       ('Bob', 'Ulrich', '32 Sussex St', null, 'Van Nuys', 'CA', '91405', '(733) 839-9630', 'bulrich@bacchus.com', 'marketing'),
       ('Henry', 'Doyle', '9768 Grove Avenue', null, 'Hayward', 'CA', '94541', '(698) 294-3319', 'hdoyle@bacchus.com', 'production'),
       ('Maria', 'Costanza', '80 Baker Road', null, 'Lancaster', 'CA', '93535', '(752) 303-8233', 'mcostanza@bacchus.com', 'distribution'),
       ('Stan', 'Bacchus', '72 Plymouth Street', null, 'Los Angeles', 'CA', '90004', '(344) 975-3898', 'sbacchus@bacchus.com', 'owner'),
       ('Davis', 'Bacchus', '6 East Applegate St', null, 'Sunnyvale', 'CA', '94087', '(946) 609-2696', 'dbacchus@bacchus.com', 'owner');

-- insert work_hours records
INSERT INTO work_hours (employee_id, work_day, clock_in, lunch_out, lunch_in, clock_out)
VALUES ((SELECT employee_id FROM employee WHERE employee_firstName = 'Janet'), STR_TO_DATE("2022-10-31", "%Y-%m-%d"), 085930, 113045, 123023, 173032),
        ((SELECT employee_id FROM employee WHERE employee_firstName = 'Roz'), STR_TO_DATE("2022-10-31", "%Y-%m-%d"), 085703, 110012, 120045, 173012),
        ((SELECT employee_id FROM employee WHERE employee_firstName = 'Bob'), STR_TO_DATE("2022-10-31", "%Y-%m-%d"), 090057, 123032, 133029, 173058),
        ((SELECT employee_id FROM employee WHERE employee_firstName = 'Henry'), STR_TO_DATE("2022-10-31", "%Y-%m-%d"), 085503, 10532, 140556, 172959),
        ((SELECT employee_id FROM employee WHERE employee_firstName = 'Maria'), STR_TO_DATE("2022-10-31", "%Y-%m-%d"), 085809, 113023, 123017, 173002),
        ((SELECT employee_id FROM employee WHERE employee_firstName = 'Bob'), STR_TO_DATE("2022-11-01", "%Y-%m-%d"), 090101, 123012, 133058, 173045);

-- insert supplier records
INSERT INTO supplier (supplier_name, supplier_contact_firstName, supplier_contact_lastName, supplier_address_one, supplier_address_two, supplier_city, supplier_state, supplier_postal, supplier_phone, supplier_email)
VALUES ('Supplier 1', 'Odell', 'Boyer', '6 East Greenview Road', null, 'Galloway', 'OH', '43119', '(504) 899-9970', 'oboyer@sup1.com'),
        ('Supplier 2', 'Saylor', 'Woods', '363 North Bay Meadows Road', null, 'Chesterton', 'IN', '46304', '(536) 822-7091', 'swoods@sup2.com'),
        ('Supplier 3', 'Lincoln', 'Whitaker', '9130 Delaware Street', null, 'Columbus', 'GA', '31904', '(835) 624-4092', 'lwhitaker@sup3.com');

-- insert supply records
INSERT INTO supply (supply_name, supply_quantity, supplier_id)
VALUES ('bottles', 0, (SELECT supplier_id FROM supplier WHERE supplier_name = 'Supplier 1')),
        ('corks', 0, (SELECT supplier_id FROM supplier WHERE supplier_name = 'Supplier 1')),
        ('labels', 0, (SELECT supplier_id FROM supplier WHERE supplier_name = 'Supplier 2')),
        ('boxes', 0, (SELECT supplier_id FROM supplier WHERE supplier_name = 'Supplier 2')),
        ('vats', 0, (SELECT supplier_id FROM supplier WHERE supplier_name = 'Supplier 3')),
        ('tubing', 0, (SELECT supplier_id FROM supplier WHERE supplier_name = 'Supplier 3'));

-- insert delivery records
INSERT INTO delivery (delivery_date, expected_date, invoice_number, employee_id, supplier_id)
VALUES ('2022-10-15', '2022-10-15', 274930, (SELECT employee_id FROM employee WHERE employee_firstName = 'Henry'), (SELECT supplier_id FROM supplier WHERE supplier_name = 'Supplier 1')),
        ('2022-10-02', '2022-10-01', 293847, (SELECT employee_id FROM employee WHERE employee_firstName = 'Henry'), (SELECT supplier_id FROM supplier WHERE supplier_name = 'Supplier 2')),
        ('2022-10-25', '2022-10-25', 293872, (SELECT employee_id FROM employee WHERE employee_firstName = 'Henry'), (SELECT supplier_id FROM supplier WHERE supplier_name = 'Supplier 3')),
        ('2022-10-15', '2022-10-15', 293821, (SELECT employee_id FROM employee WHERE employee_firstName = 'Henry'), (SELECT supplier_id FROM supplier WHERE supplier_name = 'Supplier 1')),
        ('2022-10-07', '2022-10-01', 283742, (SELECT employee_id FROM employee WHERE employee_firstName = 'Henry'), (SELECT supplier_id FROM supplier WHERE supplier_name = 'Supplier 2')),
        ('2022-10-23', '2022-10-25', 293728, (SELECT employee_id FROM employee WHERE employee_firstName = 'Henry'), (SELECT supplier_id FROM supplier WHERE supplier_name = 'Supplier 3'));

-- insert grapes records
INSERT INTO grapes (grapes_name, harvest_season, vineyard)
VALUES ('merlot', 2022, 1),
        ('cabernet sauvignon', 2022, 1),
        ('chardonnay', 2022, 2);

-- insert wine records
INSERT INTO wine (wine_name, wine_quantity, wine_price, grapes_id)
VALUES ('merlot', 0, 15, (SELECT grapes_id FROM grapes WHERE grapes_name = 'merlot')),
        ('cabernet', 0, 17, (SELECT grapes_id FROM grapes WHERE grapes_name = 'cabernet sauvignon')),
        ('chablis', 0, 17, (SELECT grapes_id FROM grapes WHERE grapes_name = 'chardonnay')),
        ('chardonnay', 0, 25, (SELECT grapes_id FROM grapes WHERE grapes_name = 'chardonnay'));

-- insert inventory records
INSERT INTO inventory (wine_id, grapes_id, barrel_id, batch_id, storage_location)
VALUES ((SELECT wine_id FROM wine WHERE wine_name = 'merlot'), (SELECT grapes_id FROM grapes WHERE grapes_name = 'merlot'), 'mer001', 3982, 'a1'),
        ((SELECT wine_id FROM wine WHERE wine_name = 'cabernet'), (SELECT grapes_id FROM grapes WHERE grapes_name = 'cabernet sauvignon'), 'cab001', 2983, 'a1'),
        ((SELECT wine_id FROM wine WHERE wine_name = 'chablis'), (SELECT grapes_id FROM grapes WHERE grapes_name = 'chardonnay'), 'cha001', 1726, 'a2'),
        ((SELECT wine_id FROM wine WHERE wine_name = 'chardonnay'), (SELECT grapes_id FROM grapes WHERE grapes_name = 'chardonnay'), 'char001', 3028, 'a3'),
        ((SELECT wine_id FROM wine WHERE wine_name = 'merlot'), (SELECT grapes_id FROM grapes WHERE grapes_name = 'merlot'), 'mer002', 3817, 'b1'),
        ((SELECT wine_id FROM wine WHERE wine_name = 'cabernet'), (SELECT grapes_id FROM grapes WHERE grapes_name = 'cabernet sauvignon'), 'cab002', 2732, 'b1');


-- insert distributor records
INSERT INTO distributor (distributor_name, distributor_address_one, distributor_address_two, distributor_city, distributor_state, distributor_postal, distributor_phone, distributor_email, wine_id)
VALUES ('Distributor 1', '578 S Wintergreen Dr', null, 'North Augusta', 'SC', '29841', '(718) 454-7750', 'warehouse@dist1.com', (SELECT wine_id FROM wine WHERE wine_name = 'merlot')),
        ('Distributor 2', '6 Marconi Rd', null, 'Huntsville', 'AL', '35803', '(303) 285-4509', 'warehouse@dist2.com', (SELECT wine_id FROM wine WHERE wine_name = 'chablis')),
        ('Distributor 3', '17 Talbot St', null, 'Muskegon', 'MI', '49441', '(872) 204-4116', 'warehouse@dist3.com', (SELECT wine_id FROM wine WHERE wine_name = 'cabernet')),
        ('Distributor 4', '320 W Wilson St', null, 'Oviedo', 'FL', '32765', '(471) 439-1185', 'warehouse@dist4.com', (SELECT wine_id FROM wine WHERE wine_name = 'chardonnay')),
        ('Distributor 5', '9263 S Logan Lane', null, 'Quincy', 'MA', '02169', '(298) 364-9179', 'warehouse@dist5.com', (SELECT wine_id FROM wine WHERE wine_name = 'cabernet')),
        ('Distributor 6', '424 Garfield Street', null, 'Clementon', 'NJ', '08201', '(733) 230-4119', 'warehouse@dist6.com',  (SELECT wine_id FROM wine WHERE wine_name = 'chablis'));