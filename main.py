# Importación de los módulos necesarios
from flask import Flask, render_template, redirect, request, session, url_for

from flask_mysqldb import MySQL, MySQLdb
import secrets

# Crear una instancia de la aplicación Flask
app = Flask(__name__, template_folder='templates')
# Configuración de la conexión a la base de datos MySQL
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'AMUnae54'
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


    return render_template('schedule.html', eventosList = eventos, horaInicioList = horasInicio, horaFinList = horasFin, diaSemanaList = diasSemana, editEvent = 0)

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
        return render_template('schedule.html', eventosList = eventos, horaInicioList = horasInicio, horaFinList = horasFin, diaSemanaList = diasSemana, editEvent = 0)
    
@app.route('/eventRemove', methods = ["GET", "POST"])
def removeEvent():
    eventoSTR = request.args.get('eventoSTR')
    diaSTR = request.args.get('diaSTR')
    horaInicioSTR = request.args.get('horaInicioSTR')

    actualDay = 0
    _idUsuarioActual = session['idUsuario']
    
    if diaSTR == "LUNES ":
        actualDay = 1
    elif diaSTR == "MARTES ":
        actualDay = 2
    elif diaSTR == "MIÉRCOLES ":
        actualDay = 3
    elif diaSTR == "JUEVES ":
        actualDay = 4
    elif diaSTR == "VIERNES ":
        actualDay = 5
    elif diaSTR == "SÁBADO ":
        actualDay = 6
    elif diaSTR == "DOMINGO ":
        actualDay = 7

    cur = mysql.connection.cursor()
    cur.execute('DELETE FROM horario WHERE evento = %s AND horaInicio = %s AND diaSemana = %s AND idUsuario = %s', (eventoSTR, horaInicioSTR, actualDay, _idUsuarioActual,))
    mysql.connection.commit()
    

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


    return render_template('schedule.html', eventosList = eventos, horaInicioList = horasInicio, horaFinList = horasFin, diaSemanaList = diasSemana, editEvent = 0)


@app.route('/eventRemove2', methods = ["GET", "POST"])
def removeEvent2():
    eventoSTR = request.args.get('eventoSTR')
    diaSTR = request.args.get('diaSTR')
    horaInicioSTR = request.args.get('horaInicioSTR')

    actualDay = 0
    _idUsuarioActual = session['idUsuario']
    
    if diaSTR == "LUNES ":
        actualDay = 1
    elif diaSTR == "MARTES ":
        actualDay = 2
    elif diaSTR == "MIÉRCOLES ":
        actualDay = 3
    elif diaSTR == "JUEVES ":
        actualDay = 4
    elif diaSTR == "VIERNES ":
        actualDay = 5
    elif diaSTR == "SÁBADO ":
        actualDay = 6
    elif diaSTR == "DOMINGO ":
        actualDay = 7

    cur = mysql.connection.cursor()
    cur.execute('DELETE FROM horario WHERE evento = %s AND horaInicio = %s AND diaSemana = %s AND idUsuario = %s', (eventoSTR, horaInicioSTR, actualDay, _idUsuarioActual,))
    mysql.connection.commit()
    

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


    return render_template('schedule.html', eventosList = eventos, horaInicioList = horasInicio, horaFinList = horasFin, diaSemanaList = diasSemana, editEvent = 1, editEventName = eventoSTR, editEventDay = actualDay)

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

@app.route('/preguntas')
def preguntas():
    return render_template('preguntas.html')
    

# Ruta para el proceso de registro
@app.route('/register', methods=["GET", "POST"])
def register():
    if request.method == 'POST' and 'txtEmail' in request.form and 'txtPassword' in request.form:
        # Obtener el nombre, correo y contraseña proporcionados por el usuario
        _correo = request.form['txtEmail']
        _contraseña = request.form['txtPassword']
        _nombre = request.form['txtNombre']

        cur = mysql.connection.cursor()

        cur.execute('SELECT * FROM usuario WHERE correo = %s', [_correo])
        existing_user = cur.fetchone()

        if existing_user:
            return render_template('register.html', message='El correo ya está en uso.')

        cur.execute('INSERT INTO usuario (nombre, correo, contraseña) VALUES (%s, %s, %s)', (_nombre, _correo, _contraseña))
        mysql.connection.commit()

        cur.execute('SELECT * FROM usuario WHERE correo = %s AND contraseña = %s', (_correo, _contraseña))
        new_user = cur.fetchone()

        session['logueado'] = True
        session['idUsuario'] = new_user['idUsuario']
        session['nombre'] = new_user['nombre']

        return render_template('preguntas.html')

    return render_template('register.html')

@app.route('/procesar_preguntas', methods=["POST"])
def procesar_preguntas():
    if request.method == 'POST':
        respuesta1 = request.form['respuesta1']
        respuesta2 = request.form['respuesta2']
        respuesta3 = request.form['respuesta3']

        idUsuario = session.get('idUsuario')

        if idUsuario:
            cur = mysql.connection.cursor()

            cur.execute('INSERT INTO respuestas_seguridad (idUsuario, respuesta1, respuesta2, respuesta3) VALUES (%s, %s, %s, %s)',
                        (idUsuario, respuesta1, respuesta2, respuesta3))

            mysql.connection.commit()

            return redirect(url_for('homepage'))

    return render_template('error.html')


@app.route('/recuperar_contraseña', methods=["GET", "POST"])
def recuperar_contraseña():
    if request.method == 'POST':
        _nombreUsuario = request.form['nombreUsuario']
        _respuesta1 = request.form['respuesta1']
        _respuesta2 = request.form['respuesta2']
        _respuesta3 = request.form['respuesta3']
        _nuevaContraseña = request.form['nuevaContraseña']  # Nueva contraseña ingresada por el usuario

        cur = mysql.connection.cursor()

        cur.execute('SELECT idUsuario FROM respuestas_seguridad WHERE idUsuario = (SELECT idUsuario FROM usuario WHERE nombre = %s) AND respuesta1 = %s AND respuesta2 = %s AND respuesta3 = %s',
                    (_nombreUsuario, _respuesta1, _respuesta2, _respuesta3))
        usuario_coincidente = cur.fetchone()

        if usuario_coincidente:
            cur.execute('UPDATE usuario SET contraseña = %s WHERE nombre = %s', (_nuevaContraseña, _nombreUsuario))
            mysql.connection.commit()
            return redirect(url_for('homepage'))  # Redirige al usuario a la página de inicio
        else:
            return render_template('error_recuperación_contraseña.html')

    return render_template('recuperar_contraseña.html')


@app.route('/calculator', methods=['POST', 'GET'])
def calculator():
    # if request.method == 'POST':
    #     print("--------------------- Entro -----------------------------")
    #     print(request.form)
    # repeat = 0

    note = request.args.get("note")
    percentage = request.args.get("percentage")
    id_group = request.args.get("id_group")
    uuid = request.args.get("uuid")
    is_update = request.args.get("isUpdate")
    is_update_group = request.args.get("isUpdateGroup")
    id_nota = request.args.get("id_nota")
    # if uuid == None:
    #     repeated = 0

    db = mysql.connection.cursor()
    # print(repeated)
    print(f"nota: {note} {type(note)} {note != 'None'}, porcentaje: {percentage} {type(percentage)} {percentage != None}, id: {id_group} {type(id_group)} {id_group != None}, id de usuario: {session['idUsuario']}, isUpdate: {is_update} {type(is_update)} isUpdateGroup: {is_update_group} {type(is_update_group)}")

    if note != None and percentage != None and id_group != None and note != "None" and percentage != "None" and id_group != "None" and is_update != None and is_update != "None":
    #    if repeated != uuid:
        is_update = int(is_update)
        if is_update == 1:
            db.execute(f'UPDATE grupoNotas set nota = {note} WHERE idNota = {id_nota} AND idUsuario = {session["idUsuario"]}')
            mysql.connection.commit()
            print("--------------------- Actualizado con éxito -----------------------------")
        else:
            db.execute(f'INSERT INTO grupoNotas (idUsuario, numGrupo, porcentaje, nota) VALUES ({session["idUsuario"]}, {id_group}, {percentage}, {note})')
            mysql.connection.commit()
            print("--------------------- Insertado con éxito -----------------------------")
        # repeated = uuid
    elif note == "None" and percentage != "None" and id_group != "None" and id_nota == "None" and is_update != "None" and is_update_group != "None":
        is_update = int(is_update)
        is_update_group = int(is_update_group)
        if is_update == 0 and is_update_group == 1:
            db.execute(f'UPDATE grupoNotas set porcentaje = {percentage} WHERE numGrupo = {id_group} AND idUsuario = {session["idUsuario"]}')
            mysql.connection.commit()
            print("--------------------- Actualizado grupo con éxito -----------------------------")

    # Recuperar las notas
    db.execute(f"SELECT * FROM grupoNotas WHERE idUsuario = {session['idUsuario']} ORDER BY numGrupo")
    notas = db.fetchall()

    #print("HHHHHHHHHHHHHHHHHHHHHHOOOOOOOOOOOOOOOOOOOOOOOOLLLLLLLLLLLLLLLLLLLLLAAAAAAAAAAAAAAAAAAAAA ", notas)

    group = -1
    nota_ordenadas = []
    for nota in notas:
        if group != nota["numGrupo"]:
            nota_ordenadas.append([])
            group = nota["numGrupo"]
        
        nota_ordenadas[nota["numGrupo"]].append(nota)


    #print(nota_ordenadas)

    return render_template('calculator.html', nota_ordenadas=nota_ordenadas, len_group=len(nota_ordenadas))

# Configuración de la clave secreta para las sesiones de usuario
if __name__ == '__main__':
    app.secret_key = "prFlask"

# Ejecución de la aplicación Flask
app.run(debug=True, host='0.0.0.0', port=5000, threaded=True)
