# Importación de los módulos necesarios
from flask import Flask, render_template, redirect, request, session
from flask_mysqldb import MySQL, MySQLdb

# Crear una instancia de la aplicación Flask
app = Flask(__name__, template_folder='templates')

# Configuración de la conexión a la base de datos MySQL
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'db12dieramirezma'
app.config['MYSQL_DB'] = 'prFlask'
app.config['MYSQL_CURSORCLASS'] = 'DictCursor'

# Inicialización de la extensión MySQL
mysql = MySQL(app)

# Definición de la ruta para la página de inicio
@app.route('/')
def homepage():
    return render_template('index.html')

# Definición de la ruta para la página de administrador
@app.route('/admin')
def admin():
    print (session['nombre'])
    return render_template('admin.html', username = session['nombre'])
    

# Definición de la ruta para la página de horario
@app.route('/schedule')
def schedule():

    _idUsuarioActual = session['idUsuario']
    print(_idUsuarioActual)

    cur = mysql.connection.cursor()

    #Recuperar los Eventos del Usuario
    cur.execute('SELECT evento FROM horario WHERE idUsuario = %s', (_idUsuarioActual,))
    resultados = cur.fetchall()
    eventos = [resultado['evento'] for resultado in resultados]

    cur.execute('SELECT horaInicio FROM horario WHERE idUsuario = %s', (_idUsuarioActual,))
    resultados = cur.fetchall()
    horasInicio = [resultado['horaInicio'] for resultado in resultados]
    
    cur.execute('SELECT horaFin FROM horario WHERE idUsuario = %s', (_idUsuarioActual,))
    resultados = cur.fetchall()
    horasFin = [resultado['horaFin'] for resultado in resultados]

    cur.execute('SELECT diaSemana FROM horario WHERE idUsuario = %s', (_idUsuarioActual,))
    resultados = cur.fetchall()
    diasSemana = [resultado['diaSemana'] for resultado in resultados]


    return render_template('schedule.html', eventosList = eventos, horaInicioList = horasInicio, horaFinList = horasFin, diaSemanaList = diasSemana)

@app.route('/eventAdd', methods = ["GET", "POST"])
def addEvent():
    # Verificar si se ha enviado un formulario POST
    if request.method == 'POST'and 'nombreEvento' in request.form and 'diaSemanal' in request.form:
        # Obtener el Evento, las horas de inicio y fin, y el día
        _nombreEvento = request.form['nombreEvento']
        _diaSemana = request.form['diaSemanal']
        _horaInicio = request.form['horaInicio']
        _horaFin = request.form['horaFin']

        # Crear un cursor para la base de datos MySQL
        cur = mysql.connection.cursor()

        #Insertar el nuevo Evento
        cur.execute('INSERT INTO horario (idUsuario, evento, horaInicio, horaFin, diaSemana) VALUES (%s, %s, %s, %s, %s)', (session['idUsuario'], _nombreEvento, _horaInicio, _horaFin, _diaSemana))
        mysql.connection.commit()

        #Recuperar los Eventos del Usuario

        _idUsuarioActual = session['idUsuario']

        cur.execute('SELECT evento FROM horario WHERE idUsuario = %s', (_idUsuarioActual,))
        resultados = cur.fetchall()
        eventos = [resultado['evento'] for resultado in resultados]

        cur.execute('SELECT horaInicio FROM horario WHERE idUsuario = %s', (_idUsuarioActual,))
        resultados = cur.fetchall()
        horasInicio = [resultado['horaInicio'] for resultado in resultados]
    
        cur.execute('SELECT horaFin FROM horario WHERE idUsuario = %s', (_idUsuarioActual,))
        resultados = cur.fetchall()
        horasFin = [resultado['horaFin'] for resultado in resultados]

        cur.execute('SELECT diaSemana FROM horario WHERE idUsuario = %s', (_idUsuarioActual,))
        resultados = cur.fetchall()
        diasSemana = [resultado['diaSemana'] for resultado in resultados]

        #Recargar la Página. 
        return render_template('schedule.html', eventosList = eventos, horaInicioList = horasInicio, horaFinList = horasFin, diaSemanaList = diasSemana)

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
        cur.execute('SELECT * FROM usuario WHERE correo = %s AND contraseña = %s', (_correo, _contraseña))
        
        # Obtener la primera fila (si existe) que coincide con la consulta
        account = cur.fetchone()
        
        # Si se encuentra un usuario con éxito
        if account:
            # Establecer una sesión de usuario marcándolo como logueado y almacenando su ID de usuario
            session['logueado'] = True
            session['idUsuario'] = account['idUsuario']
            session['nombre'] = account['nombre']
            
            # Redirigir al usuario a la página de administrador
            return render_template('admin.html', username = session['nombre'])
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

        # Redirigir al usuario a la página de administrador
        return render_template('admin.html')

    # Si se accede al registro por GET o no se proporcionan datos válidos, mostrar el formulario de registro
    return render_template('register.html')

# Configuración de la clave secreta para las sesiones de usuario
if __name__ == '__main__':
    app.secret_key = "prFlask"

# Ejecución de la aplicación Flask
app.run(debug=True, host='0.0.0.0', port=5000, threaded=True)
