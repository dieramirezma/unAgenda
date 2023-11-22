import mysql.connector
from werkzeug.security import generate_password_hash

MYSQL_PASSWORD = os.environ.get("MYSQL_PASSWORD_UNAGENDA")

conection = mysql.connector.connect(
    host = "bk9yaw96cgi2zyhqfvda-mysql.services.clever-cloud.com",
    user = "uu2geebwmidfiq4r",
    password = MYSQL_PASSWORD,
    database = "bk9yaw96cgi2zyhqfvda"

)
# Función para ejecutar un script SQL sin usar Mysql Workbench
def create_db(filename):
    """
    Execute an SQL script file using the provided MySQL connection.
    """
    # Open and read the SQL file
    with open(filename, 'r') as sql_file:
        sql_script = sql_file.read()

    # Split the script into individual statements
    sql_commands = sql_script.split(';')

    # Execute each statement
    cursor = conection.cursor()
    for command in sql_commands:
        try:
            cursor.execute(command)
        except Exception as e:
            print(f"Error executing SQL command: {e}")

    # Commit the changes
    conection.commit()

def insert_users(users):
    cursor = conection.cursor()
    for i in range(len(users)):
        cursor.execute("INSERT INTO `usuario`(nombre,correo,contrasena) VALUES (%s,%s,%s)", (users[i][0],users[i][1],users[i][2],))
    conection.commit()


users = [
    ['Usuario1','usuario1@example.com','pass1'],
    ['Usuario2','usuario2@example.com','pass2'],
    ['Usuario3','usuario3@example.com','pass3'],
    ['Usuario4','usuario4@example.com','pass4']
    ]

for i in range(len(users)):
    users[i][2] = generate_password_hash(users[i][2])



create_db('prflask.sql')
insert_users(users)