''' 
    Emanuel Pagan, Wendy Rzechula, Sheila Smallwood, Dj Trost, Corey Ward
    Assignment 10.1 | Milestone #2
    9 July 2023 
'''

import mysql.connector
from mysql.connector import errorcode

config = {
    "user": "bacchus_user",
    "password": "winery",
    "host": "127.0.0.1",
    "database": "bacchus",
    "raise_on_warnings": True
}

try:
    db = mysql.connector.connect(**config)

    cursor = db.cursor()

    # employee query
    cursor.execute("SELECT employee_id, employee_firstName, employee_lastName, employee_address_one, employee_city, employee_state, employee_postal, employee_phone, employee_email, employee_department FROM employee")

    employees = cursor.fetchall()

    print("-- DISPLAYING Employee RECORDS --")

    for employee in employees:
        print("Employee ID: {}".format(employee[0]))
        print("Employee Name: {} {}".format(employee[1], employee[2]))
        print("Employee Address: {}, {}, {} {}".format(employee[3], employee[4], employee[5], employee[6]))
        print("Employee Phone: {}".format(employee[7]))
        print("Employee Email: {}".format(employee[8]))
        print("Employee Department: {}\n".format(employee[9]))  

    # work_hours query
    cursor.execute("SELECT hours_id AS ID, employee_firstName AS 'Employee First', employee_lastName AS 'Employee Last', work_day AS Date, clock_in AS 'Punch In', lunch_out AS 'Lunch Out', lunch_in AS 'Lunch In', clock_out AS 'Punch Out' " 
                   "FROM work_hours "
                   "INNER JOIN employee ON work_hours.employee_id = employee.employee_id;")

    hours = cursor.fetchall()

    print("-- DISPLAYING Work Hours RECORDS --")

    for hour in hours:
        print("Hours ID: {}".format(hour[0]))
        print("Employee: {} {}".format(hour[1], hour[2]))
        print("Date: {}".format(hour[3]))
        print("Clock In: {}".format(hour[4]))
        print("Lunch Out: {}".format(hour[5]))
        print("Lunch In: {}".format(hour[6]))
        print("Clock Out: {}\n".format(hour[7]))

    # supplier query
    cursor.execute("SELECT supplier_ID, supplier_name, supplier_contact_firstName, supplier_contact_lastName, supplier_address_one, supplier_city, supplier_state, supplier_postal, supplier_phone, supplier_email FROM supplier")

    suppliers = cursor.fetchall()

    print("-- DISPLAYING Supplier RECORDS --")

    for supplier in suppliers:
        print("Supplier ID: {}".format(supplier[0]))
        print("Supplier Name: {}".format(supplier[1]))
        print("Supplier Contact: {} {}".format(supplier[2], supplier[3]))
        print("Supplier Address: {}, {}, {} {}".format(supplier[4], supplier[5], supplier[6], supplier[7]))
        print("Supplier Phone: {}".format(supplier[8]))
        print("Supplier Email: {}\n".format(supplier[9]))

    # supply query
    cursor.execute("SELECT supply_id AS ID, supply_name AS Name, supply_quantity AS Quantity, supplier_name AS Supplier " 
                   "FROM supply "
                   "INNER JOIN supplier ON supply.supplier_id = supplier.supplier_id;")

    supplies = cursor.fetchall()

    print("-- DISPLAYING Supply RECORDS --")

    for supply in supplies:
        print("Supply ID: {}".format(supply[0]))
        print("Supply Name: {}".format(supply[1]))
        print("Supply Quantity: {}".format(supply[2]))
        print("Supplier: {}\n".format(supply[3]))

    # delivery query
    cursor.execute("SELECT delivery_id AS ID, delivery_date AS 'Delivery Date', expected_date AS 'Expected Date', invoice_number AS Invoice, employee_firstName AS 'Employee First', employee_lastName AS 'Employee Last', supplier_name AS Supplier " 
                   "FROM delivery "
                   "INNER JOIN employee ON delivery.employee_id = employee.employee_id "
                   "INNER JOIN supplier ON delivery.supplier_id = supplier.supplier_id;")

    deliveries = cursor.fetchall()

    print("-- DISPLAYING Delivery RECORDS --")

    for delivery in deliveries:
        print("Delivery ID: {}".format(delivery[0]))
        print("Delivery Date: {}".format(delivery[1]))
        print("Expected Date: {}".format(delivery[2]))
        print("Invoice Number: {}".format(delivery[3]))
        print("Receiving Employee: {} {}".format(delivery[4], delivery[5]))
        print("Supplier: {}\n".format(delivery[6]))

    # grape query
    cursor.execute("SELECT grapes_ID, grapes_name, harvest_season, vineyard FROM grapes")

    grapes = cursor.fetchall()

    print("-- DISPLAYING Grape RECORDS --")

    for grape in grapes:
        print("Grape ID: {}".format(grape[0]))
        print("Grape Name: {}".format(grape[1]))
        print("Harvest Season: {}".format(grape[2]))
        print("Vineyard: {}\n".format(grape[3]))

    # wine query
    cursor.execute("SELECT wine_id AS ID, wine_name AS Name, wine_quantity AS Quantity, wine_price AS Price, grapes_name AS Grapes " 
                   "FROM wine "
                   "INNER JOIN grapes ON wine.grapes_id = grapes.grapes_id;")

    wines = cursor.fetchall()

    print("-- DISPLAYING Wine RECORDS --")

    for wine in wines:
        print("Wine ID: {}".format(wine[0]))
        print("Wine Name: {}".format(wine[1]))
        print("Quantity: {}".format(wine[2]))
        print("Price: {}".format(wine[3]))
        print("Grapes: {}\n".format(wine[4]))

    # inventory query
    cursor.execute("SELECT inventory_id AS ID, wine_name AS Wine, grapes_name AS Grapes, barrel_id AS Barrel, batch_id AS Batch, storage_location AS Warehouse " 
                   "FROM inventory "
                   "INNER JOIN wine ON inventory.wine_id = wine.wine_id "
                   "INNER JOIN grapes ON inventory.grapes_id = grapes.grapes_id;")

    inventories = cursor.fetchall()

    print("-- DISPLAYING Delivery RECORDS --")

    for inventory in inventories:
        print("Inventory ID: {}".format(inventory[0]))
        print("Wine: {}".format(inventory[1]))
        print("Grapes: {}".format(inventory[2]))
        print("Barrel: {}".format(inventory[3]))
        print("Batch: {}".format(inventory[4]))
        print("Warehouse: {}\n".format(inventory[5]))

    # distributor query
    cursor.execute("SELECT distributor_id AS ID, distributor_name AS Name, distributor_address_one AS Street, distributor_city AS City, distributor_state AS State, distributor_postal AS Postal, distributor_phone AS Phone, distributor_email AS Email, wine_name as Wine " 
                   "FROM distributor "
                   "INNER JOIN wine ON distributor.wine_id = wine.wine_id;")

    distributors = cursor.fetchall()

    print("-- DISPLAYING distributor RECORDS --")

    for distributor in distributors:
        print("Distributor ID: {}".format(distributor[0]))
        print("Distributor Name: {}".format(distributor[1]))
        print("Distributor Address: {}, {}, {} {}".format(distributor[2], distributor[3], distributor[4], distributor[5]))
        print("Distributor Phone: {}".format(distributor[6]))
        print("Distributor Email: {}".format(distributor[7]))
        print("Wine Carried: {}\n".format(distributor[8]))
    
except mysql.connector.Error as err:
    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print(" The supplied username or password are invalid")

    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print(" The specified database does not exist")

    else:
        print(err)
