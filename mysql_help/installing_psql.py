#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# -----------------------------------------------
#         FILE : psql.py
#      CREATED : 08-November-2019
#       AUTHOR : daBve, dabve@outlook.fr
#         DESC : Installing PostgreSQL
# -----------------------------------------------


# import sys
# sys.path.extend([''])
# import pauseFunction


def installing_postgres():
    print("""
+---------------------------------------------------------------------------------------------
| » Installing PostgreSQL
|------------------------
| $ sudo apt install postgresql postgresql-contrib
| $ sudo -i -u postgres
|
| # Create new roles from command line
| # You can read the manual of createuser (man createuser)
| postgres@server:~$ createuser --interactive
| Enter name of role to add: dabve
| Shall the new role be a superuser? (y/n) y
|
| # The postgres authentication system makes by default is that for any role (user) used to login,
|   that role will have a database with the same name wich it can access.
| postgres@server:~$ createdb dabve
|
| # If you want your user to connect to a different database, you can do so by specifying the database
| postres@server:~$ psql -d db_name
|
| # Now you can use the command line of PostgreSQL and execute SQL statement
| $ psql
|_____________________________________________________________________________________________
    """)


if __name__ == '__main__':
    installing_postgres()
