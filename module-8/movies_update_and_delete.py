# DJ Trost | CSD310 | Assignment 8.2 | 7 July 2023
# Py script to INSERT, UPDATE, and DELETE data in the movies database

import mysql.connector
from mysql.connector import errorcode

config = {
    "user": "movies_user",
    "password": "popcorn",
    "host": "127.0.0.1",
    "database": "movies",
    "raise_on_warnings": True
}

# Method to execute INNER JOIN and print results
def show_films(cursor, title):
    # INNER JOIN SQL query
    cursor.execute("SELECT film_name AS Name, film_director AS Director, genre_name AS Genre, studio_name AS 'Studio Name' "
                   "FROM film "
                   "INNER JOIN genre ON film.genre_id = genre.genre_id "
                   "INNER JOIN studio ON film.studio_id = studio.studio_id;")
        
    films = cursor.fetchall()       # Gets the results from query

    print("\n  --  {}  --".format(title))       # Prints section title

    # Iterates over the film data set and prints results
    for film in films:
        print("Film Name: {}\nDirector {}\nGenre Name ID: {}\nStudio Name: {}\n".format(film[0], film[1], film[2], film[3]))

try:
    db = mysql.connector.connect(**config)

    cursor = db.cursor()

    # Initial display of films data set before edits
    show_films(cursor, "DISPLAYING FILMS")

    # INSERT SQL command to insert row for The Invisible Man
    cursor.execute("INSERT INTO film "
                   "(film_id, film_name, film_releaseDate, film_runtime, film_director, studio_id, genre_id) "
                   "VALUES "
                   "(4, 'The Invisible Man', '1933', 70, 'James Whale', 3, 1);")
    
    # Display films data set after INSERT
    show_films(cursor, "DISPLAYING FILMS AFTER INSERT")

    # UPDATE SQL command to update Alien's genre
    cursor.execute("UPDATE film "
                   "SET genre_id = 1 "
                   "WHERE film_id = 2;")
    
    # Display films data set after UPDATE
    show_films(cursor, "DISPLAYING FILMS AFTER UPDATE- Changed Alien to Horror")

    # DELETE SQL command to remove Gladiator row
    cursor.execute("DELETE "
                   "FROM film "
                   "WHERE film_name = 'Gladiator';")
    
    # Display films data set after DELETE
    show_films(cursor, "DISPLAY FILMS AFTER DELETE")

except mysql.connector.Error as err:
    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print(" The supplied username or password are invalid")

    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print(" The specified database does not exist")

    else:
        print(err)

finally:
    db.close()