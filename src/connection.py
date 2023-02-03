import configparser
import mysql.connector

class Connection:

    config = configparser.ConfigParser()
    config.read('bin/config.ini')

    user = config['database']['user']
    password = config['database']['password']
    host = config['database']['host']
    database = config['database']['database']

    mydb = mysql.connector.connect(
        host=host,
        user=user,
        password=password,
        database=database,
    )
