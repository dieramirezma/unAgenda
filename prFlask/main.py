# Importación de los módulos necesarios
from flask import Flask, render_template, redirect, request, session
from flask_mysqldb import MySQL, MySQLdb

# Crear una instancia de la aplicación Flask
app = Flask(__name__, template_folder='templates')

# Configuración de la conexión a la base de datos MySQL
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'root'
app.config['MYSQL_DB'] = 'prFlask'
app.config['MYSQL_CURSORCLASS'] = 'DictCursor'

# Inicialización de la extensión MySQL
mysql = MySQL(app)

# Definición de la ruta para la página de inicio
@app.route('/')
def homepage():
    return render_template('index.html')

# Definición de la ruta para la página de administrador
# @app.route('/admin')
# def admin():
#     return render_template('admin.html')
@app.route('/admin')
def admin():
    if 'logueado' in session and session['logueado']:
        user_id = session['idUsuario']  # Obtener el ID del usuario de la sesión

        try:
            # Crear una conexión a la base de datos MySQL
            cursor = mysql.connection.cursor()

            # Consulta SQL para obtener los datos del usuario
            cursor.execute("SELECT nombre, correo FROM usuario WHERE idUsuario = %s", (user_id,))
            user_data = cursor.fetchone()

            if user_data:
                nombre_usuario = user_data['nombre']
                correo_usuario = user_data['correo']
            else:
                nombre_usuario = "Usuario no encontrado"
                correo_usuario = "Correo no encontrado"

            # Resto del código para obtener las notas del usuario
            # ...

            cursor.close()

            return render_template('admin.html', nombre_usuario=nombre_usuario, correo_usuario=correo_usuario)
        except Exception as e:
            return str(e)
    else:
        return redirect('/')
    
# Definición de la ruta para la página de horario
@app.route('/schedule')
def schedule():
    return render_template('schedule.html')

# Ruta para el proceso de inicio de sesión
@app.route('/loginAccess', methods=["GET", "POST"])
def login():
    # Verificar si se ha enviado un formulario POST
    if request.method == 'POST' and 'txtEmail' in request.form and 'txtPassword' in request.form:
        # Obtener el correo y la contraseña proporcionados por el usuario
        _correo = request.form['txtEmail']
        _contraseña = request.form['txtPassword']

        # Crear un cursor para la base de datos MySQL
        cur = mysql.connection.cursor()

        # Ejecutar una consulta SQL para buscar un usuario con el correo y contraseña proporcionados
        
        cur.execute('SELECT idUsuario, nombre FROM usuario WHERE correo = %s AND contraseña = %s', (_correo, _contraseña))

        
        # Obtener la primera fila (si existe) que coincide con la consulta
        account = cur.fetchone()
        
        
        # Si se encuentra un usuario con éxito
        if account:
            
            # Establecer una sesión de usuario marcándolo como logueado y almacenando su ID de usuario
            session['logueado'] = True
            session['idUsuario'] = account['idUsuario']
            # nombre_usuario = user_data['nombre']
            session['nombreUsuario'] = account['nombre']
            
            # Redirigir al usuario a la página de administrador
            # return render_template('admin.html')
            return redirect('/admin')
        else:
            # Si no se encuentra un usuario, redirigir de nuevo a la página de inicio
            return render_template('index.html')

# Ruta para el proceso de registro
@app.route('/register', methods=["GET", "POST"])
def register():
    if request.method == 'POST' and 'txtEmail' in request.form and 'txtPassword' in request.form:
        # Obtener el nombre, correo y contraseña proporcionados por el usuario
        _correo = request.form['txtEmail']
        _contraseña = request.form['txtPassword']
        _nombre = request.form['txtNombre']

        # Crear un cursor para la base de datos MySQL
        cur = mysql.connection.cursor()

        # Verificar si el correo ya está en uso
        cur.execute('SELECT * FROM usuario WHERE correo = %s', [_correo])
        existing_user = cur.fetchone()

        # Si el correo ya está en uso, mostrar un mensaje de error
        if existing_user:
            return render_template('register.html', message='El correo ya está en uso.')

        # Si el correo no está en uso, insertar el nuevo usuario en la base de datos
        cur.execute('INSERT INTO usuario (nombre, correo, contraseña) VALUES (%s, %s, %s)', (_nombre, _correo, _contraseña))
        mysql.connection.commit()

        # Establecer una sesión de usuario para el nuevo usuario registrado
        session['logueado'] = True
        session['idUsuario'] = cur.lastrowid
        session['nombreUsuario'] = _nombre

        # Redirigir al usuario a la página de administrador
        # return render_template('admin.html')
        return redirect('/admin')


    # Si se accede al registro por GET o no se proporcionan datos válidos, mostrar el formulario de registro
    return render_template('register.html')

# Configuración de la clave secreta para las sesiones de usuario
if __name__ == '__main__':
    app.secret_key = "prFlask"

# Ejecución de la aplicación Flask
app.run(debug=True, host='0.0.0.0', port=5000, threaded=True)
