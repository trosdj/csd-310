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
    cursor.execute("SELECT employee_ID, employee_firstName, employee_lastName, employee_department, employee_hours FROM employee")

    employees = cursor.fetchall()

    print("-- DISPLAYING Employee RECORDS --")

    for employee in employees:
        print("Employee ID: {}".format(employee[0]))
        print("Employee Name: {} {}".format(employee[1], employee[2]))
        print("Employee Department: {}".format(employee[3]))
        print("Employee Hours: {}\n".format(employee[4]))

    # supplier query
    cursor.execute("SELECT supplier_ID, supplier_name FROM supplier")

    suppliers = cursor.fetchall()

    print("-- DISPLAYING Supplier RECORDS --")

    for supplier in suppliers:
        print("Supplier ID: {}".format(supplier[0]))
        print("Supplier Name: {}\n".format(supplier[1]))

    # supply query
    cursor.execute("SELECT supply_ID, supply_name, supply_quantity FROM supply")

    supplies = cursor.fetchall()

    print("-- DISPLAYING Supply RECORDS --")

    for supply in supplies:
        print("Supply ID: {}".format(supply[0]))
        print("Supply Name: {}".format(supply[1]))
        print("Supply Quantity: {}\n".format(supply[2]))

    # product query
    cursor.execute("SELECT product_ID, product_name, product_amount FROM product")

    products = cursor.fetchall()

    print("-- DISPLAYING Product RECORDS --")

    for product in products:
        print("Product ID: {}".format(product[0]))
        print("Product Name: {}".format(product[1]))
        print("Product Amount: {}\n".format(product[2]))

    # wine query
    cursor.execute("SELECT wine_ID, wine_name, wine_amount FROM wine")

    wines = cursor.fetchall()

    print("-- DISPLAYING Wine RECORDS --")

    for wine in wines:
        print("Wine ID: {}".format(wine[0]))
        print("Wine Name: {}".format(wine[1]))
        print("Wine Amount: {}\n".format(wine[2]))

    # distributor query
    cursor.execute("SELECT distributor_ID, distributor_name FROM distributor")

    distributors = cursor.fetchall()

    print("-- DISPLAYING distributor RECORDS --")

    for distributor in distributors:
        print("distributor ID: {}".format(distributor[0]))
        print("distributor Name: {}\n".format(distributor[1]))
    
except mysql.connector.Error as err:
    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print(" The supplied username or password are invalid")

    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print(" The specified database does not exist")

    else:
        print(err)