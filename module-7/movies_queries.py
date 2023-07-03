# DJ Trost | Assignment 7.2 | 2 July 2023

import mysql.connector
from mysql.connector import errorcode

config = {
    "user": "movies_user",
    "password": "popcorn",
    "host": "127.0.0.1",
    "database": "movies",
    "raise_on_warnings": True
}

try:
    db = mysql.connector.connect(**config)

    cursor = db.cursor()

    # Studio query
    cursor.execute("SELECT studio_ID, studio_name FROM studio")

    studios = cursor.fetchall()

    print("-- DISPLAYING Studio RECORDS --")

    for studio in studios:
        print("Studio ID: {}".format(studio[0]))
        print("Studio Name: {}\n".format(studio[1]))

    # Genre query
    cursor.execute("SELECT genre_ID, genre_name FROM genre")

    genres = cursor.fetchall()

    print("-- DISPLAYING Genre RECORDS --")

    for genre in genres:
        print("Genre ID: {}".format(genre[0]))
        print("Genre Name: {}\n".format(genre[1]))
    
    # Short Film query
    cursor.execute("SELECT film_name, film_runtime FROM film WHERE film_runtime < 120")

    short_films = cursor.fetchall()

    print("-- DISPLAYING Short Film RECORDS --")

    for short_film in short_films:
        print("Film Name: {}".format(short_film[0]))
        print("Runtime: {}\n".format(short_film[1]))
    
    # Director query
    cursor.execute("SELECT film_name, film_director FROM film ORDER BY film_director ASC;")

    directors = cursor.fetchall()

    print("-- DISPLAYING Director RECORDS in Order --")

    for director in directors:
        print("Film Name: {}".format(director[0]))
        print("Director: {}\n".format(director[1]))

except mysql.connector.Error as err:
    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print(" The supplied username or password are invalid")

    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print(" The specified database does not exist")

    else:
        print(err)