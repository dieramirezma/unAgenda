# Importación de los módulos necesarios
from flask import Flask, render_template, redirect, request, session, url_for, flash
import string
import random
from flask_mail import Mail, Message
from flask_mysqldb import MySQL, MySQLdb
from datetime import datetime, timedelta
from werkzeug.security import generate_password_hash, check_password_hash
import os
from functools import wraps
from flask import jsonify
import pytz

colombia_zona_horaria = pytz.timezone('America/Bogota')

actualizado_horario = False

# Cargar variables de entorno para las credenciales
MYSQL_PASSWORD = os.environ.get("MYSQL_PASSWORD_UNAGENDA")
EMAIL_PASSWORD = os.environ.get("EMAIL_PASSWORD_UNAGENDA")

# Crear una instancia de la aplicación Flask
app = Flask(__name__, template_folder="templates")

# Configuración de la conexión a la base de datos MySQL
app.config["MYSQL_HOST"] = "bk9yaw96cgi2zyhqfvda-mysql.services.clever-cloud.com"
app.config["MYSQL_USER"] = "uu2geebwmidfiq4r"
app.config["MYSQL_PASSWORD"] = MYSQL_PASSWORD
app.config["MYSQL_DB"] = "bk9yaw96cgi2zyhqfvda"
app.config["MYSQL_CURSORCLASS"] = "DictCursor"


# Configuración de Flask-Mail
app.config["MAIL_SERVER"] = "smtp.gmail.com"
app.config["MAIL_PORT"] = 587
app.config["MAIL_USE_TLS"] = True
app.config["MAIL_USE_SSL"] = False

app.config["MAIL_USERNAME"] = "unagenda.of@gmail.com"
app.config["MAIL_PASSWORD"] = EMAIL_PASSWORD
app.config["MAIL_DEFAULT_SENDER"] = "unagenda.of@gmail.com"

# Inicialización de la extensión MySQL
mysql = MySQL(app)

mail = Mail(app)

def fecha_hora():
    now = datetime.now(colombia_zona_horaria)
    formatted_date = now.strftime("%Y-%m-%d %H:%M:%S")
    currentYear = now.strftime("%Y")
    currentMonth = now.strftime("%m")
    currentDay = now.strftime("%d")
    currentHour = now.strftime("%H")
    currentMinute = now.strftime("%M")

    currentTime = (currentYear, currentMonth, currentDay, currentHour, currentMinute)

    return formatted_date, currentTime

def obtener_fecha_hora(sublista):
    return datetime(sublista[1], sublista[2], sublista[3], sublista[4], sublista[5])

def generate_random_token(length=32):
    characters = string.ascii_letters + string.digits
    token = "".join(random.choice(characters) for _ in range(length))
    return token


def login_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if "nombre" not in session or "idUsuario" not in session:
            return render_template("index.html")
        return f(*args, **kwargs)
    return decorated_function

@app.route("/recuperacion", methods=["GET", "POST"])
def recuperacion():
    if request.method == "POST":
        recipient = request.form["recipient"]
        token = generate_random_token()
        current_time = datetime.now(colombia_zona_horaria)
        expiration_time = current_time + timedelta(hours=24)
        cur = mysql.connection.cursor()
        cur.execute(
            "INSERT INTO password_reset_tokens (email, token, created_at, expiration) VALUES (%s, %s, %s, %s)",
            (recipient, token, current_time, expiration_time),
        )
        mysql.connection.commit()
        cur.close()

        reset_link = url_for("reset_password", token=token, _external=True)

        msg = Message(
            "Recuperación de contraseña",
            sender="unagenda.of@gmail.com",
            recipients=[recipient],
        )
        msg.body = f"Utilice este enlace para restablecer su contraseña: {reset_link}"
        mail.send(msg)

        flash(
            "Se ha enviado un enlace de recuperación por correo electrónico.", "success"
        )

    return render_template("recuperacion.html")


@app.route("/reset_password", methods=["GET", "POST"])
def reset_password():
    _token = request.args.get("token")
    data = None

    if _token is None:
        flash("Token no encontrado en la URL.", "danger")
        return render_template("reset.html", data=data)

    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM password_reset_tokens WHERE token = %s", [_token])
    data = cur.fetchone()

    if data is None:
        flash(
            f"Token no válido: {_token}. Por favor, solicita otro enlace de recuperación.",
            "danger",
        )
        cur.close()
        return render_template("reset.html", data=data)
    current_time = datetime.now(colombia_zona_horaria)
    token_validity_period = timedelta(hours=1)
    expiration_time = colombia_zona_horaria.localize(data["created_at"] + token_validity_period)

    if current_time > expiration_time:
        flash(
            "El token ha caducado. Por favor, solicita otro enlace de recuperación.",
            "danger",
        )
        cur.close()
        return render_template("reset.html", data=data)

    if request.method == "POST":
        new_password = request.form.get("new_password")
        email = data["email"]

        password_hash = generate_password_hash(new_password)

        cur.execute(
            "UPDATE usuario SET contrasena = %s WHERE correo = %s",
            (password_hash, email),
        )
        mysql.connection.commit()
        cur.close()
        return redirect("/")

    return render_template("reset.html", data=data)

@app.route("/logout", methods=["POST"])

def logout():
    session.clear()
    return render_template("index.html")  # Redirige al usuario a la página de inicio o a donde desees
    

@app.route("/")
def homepage():
    return render_template("index.html")


@app.route("/admin")
@login_required
def admin():
    print(session["nombre"])
    now = datetime.now(colombia_zona_horaria)
    formatted_date = now.strftime("%Y-%m-%d %H:%M:%S")
    currentYear = now.strftime("%Y")
    currentMonth = now.strftime("%m")
    currentDay = now.strftime("%d")
    currentHour = now.strftime("%H")
    currentMinute = now.strftime("%M")

    currentTime = (currentYear, currentMonth, currentDay, currentHour, currentMinute)

    cur = mysql.connection.cursor()
    _idUsuarioActual = session["idUsuario"]

    cur.execute("SELECT nombreRecordatorio FROM recordatorios WHERE idUsuario = %s", (_idUsuarioActual,))
    resultados = cur.fetchall()
    nombreRecordatorio = [resultado["nombreRecordatorio"] for resultado in resultados]

    cur.execute("SELECT y FROM recordatorios WHERE idUsuario = %s", (_idUsuarioActual,))
    resultados = cur.fetchall()
    year = [resultado["y"] for resultado in resultados]

    cur.execute("SELECT mm FROM recordatorios WHERE idUsuario = %s", (_idUsuarioActual,))
    resultados = cur.fetchall()
    month = [resultado["mm"] for resultado in resultados]

    cur.execute("SELECT d FROM recordatorios WHERE idUsuario = %s", (_idUsuarioActual,))
    resultados = cur.fetchall()
    day = [resultado["d"] for resultado in resultados]

    cur.execute("SELECT h FROM recordatorios WHERE idUsuario = %s", (_idUsuarioActual,))
    resultados = cur.fetchall()
    hour = [resultado["h"] for resultado in resultados]

    cur.execute("SELECT m FROM recordatorios WHERE idUsuario = %s", (_idUsuarioActual,))
    resultados = cur.fetchall()
    minute = [resultado["m"] for resultado in resultados]

    todayReminders = []
    tomorrowReminders = []
    otherReminders = []

    for i in range(len(year)):
        fecha = colombia_zona_horaria.localize(datetime(int(year[i]), int(month[i]), int(day[i]), int(hour[i]), int(minute[i])))
        if fecha >= now and abs(fecha-now) <= timedelta(days=7):
            if fecha.day == now.day:
                todayReminders.append([nombreRecordatorio[i], year[i], month[i], day[i], hour[i], minute[i]])
            elif abs(fecha-now) < timedelta(hours=24):
                tomorrowReminders.append([nombreRecordatorio[i], year[i], month[i], day[i], hour[i], minute[i]])
            else:
                otherReminders.append([nombreRecordatorio[i], year[i], month[i], day[i], hour[i], minute[i]])
    
    todayReminders = sorted(todayReminders, key=obtener_fecha_hora)
    tomorrowReminders = sorted(tomorrowReminders, key=obtener_fecha_hora)
    otherReminders = sorted(otherReminders, key=obtener_fecha_hora)

    # Redirigir al usuario a la página de administrador
    return render_template("admin.html", 
    username=session["nombre"],
    currentTimeList = currentTime,
    nombreRecordatorioList = nombreRecordatorio,
    yearList = year,
    monthList = month,
    dayList = day,
    hourList = hour,
    minuteList = minute ,
    todayReminders = todayReminders,
    tomorrowReminders = tomorrowReminders,
    otherReminders = otherReminders,
    )   


@app.route("/schedule")
@login_required
def schedule():

    _idUsuarioActual = session["idUsuario"]
    print(_idUsuarioActual)

    cur = mysql.connection.cursor()

    cur.execute("SELECT evento FROM horario WHERE idUsuario = %s", (_idUsuarioActual,))
    resultados = cur.fetchall()
    eventos = [resultado["evento"] for resultado in resultados]

    cur.execute(
        "SELECT horaInicio FROM horario WHERE idUsuario = %s", (_idUsuarioActual,)
    )
    resultados = cur.fetchall()
    horasInicio = [resultado["horaInicio"] for resultado in resultados]

    cur.execute("SELECT horaFin FROM horario WHERE idUsuario = %s", (_idUsuarioActual,))
    resultados = cur.fetchall()
    horasFin = [resultado["horaFin"] for resultado in resultados]

    cur.execute(
        "SELECT diaSemana FROM horario WHERE idUsuario = %s", (_idUsuarioActual,)
    )
    resultados = cur.fetchall()
    diasSemana = [resultado["diaSemana"] for resultado in resultados]

    return render_template(
        "schedule.html",
        eventosList=eventos,
        horaInicioList=horasInicio,
        horaFinList=horasFin,
        diaSemanaList=diasSemana,
        editEvent=0,
    )


@app.route("/eventAdd", methods=["GET", "POST"])
def addEvent():
    global actualizado_horario

    # Verificar si se ha enviado un formulario POST
    if (
        request.method == "POST"
        and "nombreEvento" in request.form
        and "diaSemanal" in request.form
    ):
        # Obtener el Evento, las horas de inicio y fin, y el día
        _nombreEvento = request.form["nombreEvento"]
        _diaSemana = request.form["diaSemanal"]
        _horaInicio = request.form["horaInicio"]
        _horaFin = request.form["horaFin"]

        formatted_date, currentTime = fecha_hora()

        # Crear un cursor para la base de datos MySQL
        cur = mysql.connection.cursor()

        # Insertar el nuevo Evento
        cur.execute(
            "INSERT INTO horario (idUsuario, evento, horaInicio, horaFin, diaSemana) VALUES (%s, %s, %s, %s, %s)",
            (session["idUsuario"], _nombreEvento, _horaInicio, _horaFin, _diaSemana),
        )
        mysql.connection.commit()

        if actualizado_horario:
            cur.execute(
                f"INSERT INTO Traza (id_Usuario, Nombre, Descripcion, Hora, Servicio) VALUES ({session['idUsuario']}, '{session['nombre']}', 'Ha editado el evento {_nombreEvento}', '{formatted_date}', 'Horario')"
            )
        else:
            cur.execute(
                f"INSERT INTO Traza (id_Usuario, Nombre, Descripcion, Hora, Servicio) VALUES ({session['idUsuario']}, '{session['nombre']}', 'Ha creado el evento {_nombreEvento}', '{formatted_date}', 'Horario')"
            )

        mysql.connection.commit()

        actualizado_horario = False

        # Recuperar los Eventos del Usuario

        _idUsuarioActual = session["idUsuario"]

        cur.execute(
            "SELECT evento FROM horario WHERE idUsuario = %s", (_idUsuarioActual,)
        )
        resultados = cur.fetchall()
        eventos = [resultado["evento"] for resultado in resultados]

        cur.execute(
            "SELECT horaInicio FROM horario WHERE idUsuario = %s", (_idUsuarioActual,)
        )
        resultados = cur.fetchall()
        horasInicio = [resultado["horaInicio"] for resultado in resultados]

        cur.execute(
            "SELECT horaFin FROM horario WHERE idUsuario = %s", (_idUsuarioActual,)
        )
        resultados = cur.fetchall()
        horasFin = [resultado["horaFin"] for resultado in resultados]

        cur.execute(
            "SELECT diaSemana FROM horario WHERE idUsuario = %s", (_idUsuarioActual,)
        )
        resultados = cur.fetchall()
        diasSemana = [resultado["diaSemana"] for resultado in resultados]

        # Recargar la Página.
        return render_template(
            "schedule.html",
            eventosList=eventos,
            horaInicioList=horasInicio,
            horaFinList=horasFin,
            diaSemanaList=diasSemana,
            editEvent=0,
        )


@app.route("/eventRemove", methods=["GET", "POST"])
def removeEvent():
    eventoSTR = request.args.get("eventoSTR")
    diaSTR = request.args.get("diaSTR")
    horaInicioSTR = request.args.get("horaInicioSTR")

    actualDay = 0
    _idUsuarioActual = session["idUsuario"]

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
    cur.execute(
        "DELETE FROM horario WHERE evento = %s AND horaInicio = %s AND diaSemana = %s AND idUsuario = %s",
        (
            eventoSTR,
            horaInicioSTR,
            actualDay,
            _idUsuarioActual,
        ),
    )
    mysql.connection.commit()

    formatted_date, currentTime = fecha_hora()

        # Crear un cursor para la base de datos MySQL
    cur = mysql.connection.cursor()

    cur.execute(
        f"INSERT INTO Traza (id_Usuario, Nombre, Descripcion, Hora, Servicio) VALUES ({session['idUsuario']}, '{session['nombre']}', 'Ha eliminado el evento {eventoSTR}', '{formatted_date}', 'Horario')"
    )

    mysql.connection.commit()

    # Recuperar los Eventos del Usuario
    cur.execute("SELECT evento FROM horario WHERE idUsuario = %s", (_idUsuarioActual,))
    resultados = cur.fetchall()
    eventos = [resultado["evento"] for resultado in resultados]

    cur.execute(
        "SELECT horaInicio FROM horario WHERE idUsuario = %s", (_idUsuarioActual,)
    )
    resultados = cur.fetchall()
    horasInicio = [resultado["horaInicio"] for resultado in resultados]

    cur.execute("SELECT horaFin FROM horario WHERE idUsuario = %s", (_idUsuarioActual,))
    resultados = cur.fetchall()
    horasFin = [resultado["horaFin"] for resultado in resultados]

    cur.execute(
        "SELECT diaSemana FROM horario WHERE idUsuario = %s", (_idUsuarioActual,)
    )
    resultados = cur.fetchall()
    diasSemana = [resultado["diaSemana"] for resultado in resultados]

    return render_template(
        "schedule.html",
        eventosList=eventos,
        horaInicioList=horasInicio,
        horaFinList=horasFin,
        diaSemanaList=diasSemana,
        editEvent=0,
    )


@app.route("/eventRemove2", methods=["GET", "POST"])
def removeEvent2():
    global actualizado_horario

    eventoSTR = request.args.get("eventoSTR")
    diaSTR = request.args.get("diaSTR")
    horaInicioSTR = request.args.get("horaInicioSTR")

    actualDay = 0
    _idUsuarioActual = session["idUsuario"]

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
    cur.execute(
        "DELETE FROM horario WHERE evento = %s AND horaInicio = %s AND diaSemana = %s AND idUsuario = %s",
        (
            eventoSTR,
            horaInicioSTR,
            actualDay,
            _idUsuarioActual,
        ),
    )
    mysql.connection.commit()

    # Recuperar los Eventos del Usuario
    cur.execute("SELECT evento FROM horario WHERE idUsuario = %s", (_idUsuarioActual,))
    resultados = cur.fetchall()
    eventos = [resultado["evento"] for resultado in resultados]

    cur.execute(
        "SELECT horaInicio FROM horario WHERE idUsuario = %s", (_idUsuarioActual,)
    )
    resultados = cur.fetchall()
    horasInicio = [resultado["horaInicio"] for resultado in resultados]

    cur.execute("SELECT horaFin FROM horario WHERE idUsuario = %s", (_idUsuarioActual,))
    resultados = cur.fetchall()
    horasFin = [resultado["horaFin"] for resultado in resultados]

    cur.execute(
        "SELECT diaSemana FROM horario WHERE idUsuario = %s", (_idUsuarioActual,)
    )
    resultados = cur.fetchall()
    diasSemana = [resultado["diaSemana"] for resultado in resultados]

    actualizado_horario = True

    return render_template(
        "schedule.html",
        eventosList=eventos,
        horaInicioList=horasInicio,
        horaFinList=horasFin,
        diaSemanaList=diasSemana,
        editEvent=1,
        editEventName=eventoSTR,
        editEventDay=actualDay,
    )


# Ruta para el proceso de inicio de sesión
@app.route("/loginAccess", methods=["GET", "POST"])
def login():
    # Verificar si se ha enviado un formulario POST
    if (
        request.method == "POST"
        and "txtEmail" in request.form
        and "txtPassword" in request.form
    ):
        # Obtener el correo y la contraseña proporcionados por el usuario
        _correo = request.form["txtEmail"]
        _contrasena = request.form["txtPassword"]

        # Crear un cursor para la base de datos MySQL

        cur = mysql.connection.cursor()

        # Ejecutar una consulta SQL para buscar un usuario con el correo y contrasena proporcionados
        cur.execute(
            "SELECT * FROM usuario WHERE correo = %s",
            (_correo,),
        )
        # Obtener la primera fila (si existe) que coincide con la consulta
        account = cur.fetchone()

        print(account)


        # Si se encuentra un usuario con éxito
        if account and check_password_hash(account["contrasena"], _contrasena):
            # Establecer una sesión de usuario marcándolo como logueado y almacenando su ID de usuario
            session["logueado"] = True
            session["idUsuario"] = account["idUsuario"]
            session["nombre"] = account["nombre"]

            now = datetime.now(colombia_zona_horaria)
            formatted_date = now.strftime("%Y-%m-%d %H:%M:%S")
            currentYear = now.strftime("%Y")
            currentMonth = now.strftime("%m")
            currentDay = now.strftime("%d")
            currentHour = now.strftime("%H")
            currentMinute = now.strftime("%M")

            currentTime = (currentYear, currentMonth, currentDay, currentHour, currentMinute)

            cur = mysql.connection.cursor()
            _idUsuarioActual = session["idUsuario"]

            # Agregar traza a la base de datos
            cur.execute(
            "INSERT INTO Traza (id_Usuario,nombre,descripcion, hora, servicio) VALUES (%s, %s, %s, %s,%s)",
            (session["idUsuario"],session["nombre"], "Ha iniciado sesión", formatted_date, "Login"),
            )
            mysql.connection.commit()

            cur.execute("SELECT nombreRecordatorio FROM recordatorios WHERE idUsuario = %s", (_idUsuarioActual,))
            resultados = cur.fetchall()
            nombreRecordatorio = [resultado["nombreRecordatorio"] for resultado in resultados]

            cur.execute("SELECT y FROM recordatorios WHERE idUsuario = %s", (_idUsuarioActual,))
            resultados = cur.fetchall()
            year = [resultado["y"] for resultado in resultados]

            cur.execute("SELECT mm FROM recordatorios WHERE idUsuario = %s", (_idUsuarioActual,))
            resultados = cur.fetchall()
            month = [resultado["mm"] for resultado in resultados]

            cur.execute("SELECT d FROM recordatorios WHERE idUsuario = %s", (_idUsuarioActual,))
            resultados = cur.fetchall()
            day = [resultado["d"] for resultado in resultados]

            cur.execute("SELECT h FROM recordatorios WHERE idUsuario = %s", (_idUsuarioActual,))
            resultados = cur.fetchall()
            hour = [resultado["h"] for resultado in resultados]

            cur.execute("SELECT m FROM recordatorios WHERE idUsuario = %s", (_idUsuarioActual,))
            resultados = cur.fetchall()
            minute = [resultado["m"] for resultado in resultados]

            todayReminders = []
            tomorrowReminders = []
            otherReminders = []

            for i in range(len(year)):
                fecha = colombia_zona_horaria.localize(datetime(int(year[i]), int(month[i]), int(day[i]), int(hour[i]), int(minute[i])))
                if fecha >= now and abs(fecha-now) <= timedelta(days=7):
                    if fecha.day == now.day:
                        todayReminders.append([nombreRecordatorio[i], year[i], month[i], day[i], hour[i], minute[i]])
                    elif abs(fecha-now) < timedelta(hours=24):
                        tomorrowReminders.append([nombreRecordatorio[i], year[i], month[i], day[i], hour[i], minute[i]])
                    else:
                        otherReminders.append([nombreRecordatorio[i], year[i], month[i], day[i], hour[i], minute[i]])
            
            todayReminders = sorted(todayReminders, key=obtener_fecha_hora)
            tomorrowReminders = sorted(tomorrowReminders, key=obtener_fecha_hora)
            otherReminders = sorted(otherReminders, key=obtener_fecha_hora)

            # Redirigir al usuario a la página de administrador
            return render_template("admin.html", 
            username=session["nombre"],
            currentTimeList = currentTime,
            nombreRecordatorioList = nombreRecordatorio,
            yearList = year,
            monthList = month,
            dayList = day,
            hourList = hour,
            minuteList = minute ,
            todayReminders = todayReminders,
            tomorrowReminders = tomorrowReminders,
            otherReminders = otherReminders,
            )   
        else:
            # Si no se encuentra un usuario, redirigir de nuevo a la página de inicio
            error_message = "Credenciales incorrectas"
            return render_template("index.html", error_message=error_message)


# Ruta para el proceso de registro
@app.route("/register", methods=["GET", "POST"])
def register():
    if (
        request.method == "POST"
        and "txtEmail" in request.form
        and "txtPassword" in request.form
    ):
        _correo = request.form["txtEmail"]
        _contrasena = request.form["txtPassword"]
        _nombre = request.form["txtNombre"]

        cur = mysql.connection.cursor()

        cur.execute("SELECT * FROM usuario WHERE correo = %s", [_correo])
        existing_user = cur.fetchone()

        if existing_user:
            error_message = "El correo ya está en uso"
            return render_template("register.html", error_message=error_message)

        password_hash = generate_password_hash(_contrasena)
        cur.execute(
            "INSERT INTO usuario (nombre, correo, contrasena) VALUES (%s, %s, %s)",
            (_nombre, _correo, password_hash),
        )
        mysql.connection.commit()

        #traza registro
        now = datetime.now(colombia_zona_horaria)
        formatted_date = now.strftime("%Y-%m-%d %H:%M:%S")
        

        cur = mysql.connection.cursor()
    

        cur.execute(
            "SELECT * FROM usuario WHERE correo = %s AND contrasena = %s",
            (_correo, password_hash),
        )
        new_user = cur.fetchone()

        session["logueado"] = True
        session["idUsuario"] = new_user["idUsuario"]
        session["nombre"] = new_user["nombre"]
        
        # Agregar traza a la base de datos
        cur.execute(
        "INSERT INTO Traza (id_Usuario,nombre,descripcion, hora, servicio) VALUES (%s, %s, %s, %s,%s)",
        (new_user["idUsuario"],_nombre, "Se ha Registrado Exitosamente", formatted_date, "Login"),
         )
        mysql.connection.commit()

        return redirect("/")  # Redirigir al usuario al index

    return render_template("register.html")


@app.route("/calculator", methods=["POST", "GET"])
@login_required
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
    deletedEvent = request.args.get("deletedEvent")
    delete_group = request.args.get("delete_group")
    lengthUl = request.args.get("lengthUl")
    percs = request.args.get("percs")
    id_groups = request.args.get("id_groups")
    id_group_del = request.args.get("id_group_del")
    porc_del = request.args.get("porc_del")
    len_ul = request.args.get("len")
    li_id = request.args.get("li_id")
    new_perc = request.args.get("new_perc")
    n_perc = request.args.get("n_perc")
    id_updt = request.args.get("id_updt")
    # if uuid == None:
    #     repeated = 0

    db = mysql.connection.cursor()
    # print(repeated)
    print(
        f"nota: {note} {type(note)} {note != 'None'}, porcentaje: {percentage} {type(percentage)} {percentage != None}, id: {id_group} {type(id_group)} {id_group != None}, id de usuario: {session['idUsuario']}, isUpdate: {is_update} {type(is_update)} isUpdateGroup: {is_update_group} {type(is_update_group)}"
    )

    if deletedEvent != None and delete_group == None:
        _idUsuarioActual = session["idUsuario"]
        db.execute(
            "DELETE FROM grupoNotas WHERE idNota = %s AND idUsuario = %s",
            (
                deletedEvent,
                _idUsuarioActual,
            ),
        )
        mysql.connection.commit()
    elif deletedEvent != None and delete_group != None and lengthUl != None:
        if int(delete_group) < int(lengthUl) - 1:
            _idUsuarioActual = session["idUsuario"]
            db.execute(
                "DELETE FROM grupoNotas WHERE idNota = %s AND idUsuario = %s",
                (
                    deletedEvent,
                    _idUsuarioActual,
                ),
            )
            mysql.connection.commit()
            
            for i in range(int(delete_group) + 1, int(lengthUl)):
                db.execute(
                    f'UPDATE grupoNotas set numGrupo = {i - 1} WHERE numGrupo = {i} AND idUsuario = {session["idUsuario"]}'
                )
                mysql.connection.commit()
                #traza registro
                now = datetime.now(colombia_zona_horaria)
                formatted_date = now.strftime("%Y-%m-%d %H:%M:%S")
        

                cur = mysql.connection.cursor()
        

                # Agregar traza a la base de datos
                cur.execute(
                "INSERT INTO Traza (id_Usuario,nombre,descripcion, hora, servicio) VALUES (%s, %s, %s, %s,%s)",
                (session["idUsuario"],session["nombre"], "Ha eliminado notas", formatted_date, "Calculadora"),
                )
                mysql.connection.commit()
            if int(delete_group) <= int(id_updt):
                db.execute(
                    f'UPDATE grupoNotas set porcentaje = {n_perc} WHERE numGrupo = {int(id_updt) - 1} AND idUsuario = {session["idUsuario"]}'
                )
                mysql.connection.commit()
            else:
                db.execute(
                    f'UPDATE grupoNotas set porcentaje = {n_perc} WHERE numGrupo = {int(id_updt)} AND idUsuario = {session["idUsuario"]}'
                )
                mysql.connection.commit()
        else:
            _idUsuarioActual = session["idUsuario"]
            db.execute(
                "DELETE FROM grupoNotas WHERE idNota = %s AND idUsuario = %s",
                (
                    deletedEvent,
                    _idUsuarioActual,
                ),
            )
            mysql.connection.commit()
            db.execute(
                f'UPDATE grupoNotas set porcentaje = {n_perc} WHERE numGrupo = {int(id_updt)} AND idUsuario = {session["idUsuario"]}'
            )
            mysql.connection.commit()
    elif id_group_del != None and porc_del != None and len_ul != None:
        _idUsuarioActual = session["idUsuario"]
        db.execute(
            "DELETE FROM grupoNotas WHERE numGrupo = %s AND idUsuario = %s",
            (
                id_group_del,
                _idUsuarioActual,
            ),
        )
        mysql.connection.commit()
        if int(id_group_del) < int(len_ul) - 1:
            for i in range(int(id_group_del) + 1, int(len_ul)):
                db.execute(
                    f'UPDATE grupoNotas set numGrupo = {i - 1} WHERE numGrupo = {i} AND idUsuario = {session["idUsuario"]}'
                )
                mysql.connection.commit()
            if int(id_group_del) <= int(id_updt):
                db.execute(
                    f'UPDATE grupoNotas set porcentaje = {n_perc} WHERE numGrupo = {int(id_updt) - 1} AND idUsuario = {session["idUsuario"]}'
                )
                mysql.connection.commit()
            else:
                db.execute(
                    f'UPDATE grupoNotas set porcentaje = {n_perc} WHERE numGrupo = {int(id_updt)} AND idUsuario = {session["idUsuario"]}'
                )
                mysql.connection.commit()

        else:
            db.execute(
                f'UPDATE grupoNotas set porcentaje = {n_perc} WHERE numGrupo = {int(id_updt)} AND idUsuario = {session["idUsuario"]}'
            )
            mysql.connection.commit()

    if (
        note != None
        and percentage != None
        and id_group != None
        and note != "None"
        and percentage != "None"
        and id_group != "None"
        and is_update != None
        and is_update != "None"
    ):
        #    if repeated != uuid:
        is_update = int(is_update)
        if is_update == 1:
            db.execute(
                f'UPDATE grupoNotas set nota = {note} WHERE idNota = {id_nota} AND idUsuario = {session["idUsuario"]}'
            )
            mysql.connection.commit()

            
            print(
                "--------------------- Actualizado con éxito -----------------------------"
            )
            
        elif li_id != None and new_perc != None:
            db.execute(
                f'INSERT INTO grupoNotas (idUsuario, numGrupo, porcentaje, nota) VALUES ({session["idUsuario"]}, {id_group}, {percentage}, {note})'
            )
            mysql.connection.commit()
            print(new_perc, li_id)
            db.execute(
                f'UPDATE grupoNotas set porcentaje = {new_perc} WHERE numGrupo = {li_id} AND idUsuario = {session["idUsuario"]}'
            )
            mysql.connection.commit()
            print(
                "--------------------- Actualizado e insertado con éxito -----------------------------"
            )
            #traza registro
            now = datetime.now(colombia_zona_horaria)
            formatted_date = now.strftime("%Y-%m-%d %H:%M:%S")
        

            cur = mysql.connection.cursor()
        

            # Agregar traza a la base de datos
            cur.execute(
            "INSERT INTO Traza (id_Usuario,nombre,descripcion, hora, servicio) VALUES (%s, %s, %s, %s,%s)",
            (session["idUsuario"],session["nombre"], "Ha actualizado notas", formatted_date, "Calculadora"),
            )
            mysql.connection.commit()
        else:
            db.execute(
                f'INSERT INTO grupoNotas (idUsuario, numGrupo, porcentaje, nota) VALUES ({session["idUsuario"]}, {id_group}, {percentage}, {note})'
            )
            mysql.connection.commit()
            print(
                "--------------------- Insertado con éxito -----------------------------"
            )

        # repeated = uuid
    elif percs != None and id_groups != None:
        percs = percs.split(",")
        id_groups = id_groups.split(",")
        for i in range(len(percs)):
            db.execute(
                f'UPDATE grupoNotas set porcentaje = {percs[i]} WHERE numGrupo = {id_groups[i]} AND idUsuario = {session["idUsuario"]}'
            )
            mysql.connection.commit()
        print(percs, type(percs))
        print(id_groups, type(id_groups))
        # is_update = int(is_update)
        # is_update_group = int(is_update_group)
        # if is_update == 0 and is_update_group == 1:
        #     db.execute(f'UPDATE grupoNotas set porcentaje = {percentage} WHERE numGrupo = {id_group} AND idUsuario = {session["idUsuario"]}')
        #     mysql.connection.commit()
        #     print("--------------------- Actualizado grupo con éxito -----------------------------")

    # Recuperar las notas
    db.execute(
        f"SELECT * FROM grupoNotas WHERE idUsuario = {session['idUsuario']} ORDER BY numGrupo"
    )
    notas = db.fetchall()

    # print("HHHHHHHHHHHHHHHHHHHHHHOOOOOOOOOOOOOOOOOOOOOOOOLLLLLLLLLLLLLLLLLLLLLAAAAAAAAAAAAAAAAAAAAA ", notas)

    group = -1
    nota_ordenadas = []
    for nota in notas:
        if group != nota["numGrupo"]:
            nota_ordenadas.append([])
            group = nota["numGrupo"]

        nota_ordenadas[nota["numGrupo"]].append(nota)

    # PROMEDIAR LAS NOTAS

    db.execute(
        f"SELECT * FROM grupoNotas WHERE idUsuario = {session['idUsuario']} ORDER BY numGrupo"
    )
    notas = db.fetchall()

    numGrupo = [resultado["numGrupo"] for resultado in notas]
    porcentaje = [resultado["porcentaje"] for resultado in notas]
    nota = [resultado["nota"] for resultado in notas]

    gruposSinDuplicados = list(set(numGrupo))

    n = 0

    arregloPromedio = []

    while n < len(gruposSinDuplicados):

        db.execute(
            f"SELECT * FROM grupoNotas WHERE idUsuario = {session['idUsuario']} AND numGrupo = {gruposSinDuplicados[n]} ORDER BY numGrupo"
        )
        nuevasnotas = db.fetchall()

        notaGrupo = [resultado["nota"] for resultado in nuevasnotas]
        porcentajeGrupo = [resultado["porcentaje"] for resultado in nuevasnotas]

        valorPorcentaje = porcentajeGrupo[0] / 100

        promedioInicial = (sum(notaGrupo)) / len(notaGrupo)
        promedioGrupo = promedioInicial * valorPorcentaje

        arregloPromedio.append(promedioGrupo)

        n = n + 1

    print(arregloPromedio)

    # print(nota_ordenadas)

    return render_template(
        "calculator.html",
        nota_ordenadas=nota_ordenadas,
        len_group=len(nota_ordenadas),
        promedioFinal=sum(arregloPromedio),
    )
dark_mode = False
@app.route("/cuaderno", methods=["POST", "GET"])
@login_required
def cuaderno():
    if (request.method == "POST"):
        formatted_date, currentTime = fecha_hora()
        # Obtener el Evento, las horas de inicio y fin, y el día
        _nombreCuaderno = request.form["nombreCuaderno"]
        # print("Nombre cauderno: ", _nombreCuaderno)

        # Crear un cursor para la base de datos MySQL
        cur = mysql.connection.cursor()

        cur.execute(
        f"SELECT * FROM cuaderno WHERE id_usuario = {session['idUsuario']} AND nombreCuaderno = '{_nombreCuaderno}'"
        )
        notebook = cur.fetchall()

        if len(notebook) <= 0:
            # Insertar el nuevo Cuaderno
            cur.execute(
                "INSERT INTO cuaderno (id_usuario, nombreCuaderno, contenido, modoOscuro) VALUES (%s, %s, %s, %s)",
                (session["idUsuario"], _nombreCuaderno, "Tus Nuevos Apuntes...", 0),
            )
            mysql.connection.commit()

            cur.execute(
            f"SELECT * FROM cuaderno WHERE id_usuario = {session['idUsuario']} AND nombreCuaderno = '{_nombreCuaderno}'"
            )
            notebook = cur.fetchall()

            # Agregar traza a la base de datos
            cur.execute(
                f"INSERT INTO Traza (id_Usuario,nombre,descripcion, hora, servicio) VALUES ({session['idUsuario']}, '{session['nombre']}', 'Ha creado el cuaderno {_nombreCuaderno}', '{formatted_date}', 'Cuaderno')"
            )
            mysql.connection.commit()

        return render_template("cuaderno.html",dark_mode=dark_mode, cuaderno=notebook[0])
        


    contenido = request.args.get("contenido")
    id_cuaderno = request.args.get("id")
    nombre_cuaderno = request.args.get("nombre")
    borrar = request.args.get("borrar")

    print(f'Contenido: {contenido}')
    print(f'Id: {id_cuaderno}')
    print(f'Nombre: {nombre_cuaderno}')
    print(f'Borrar: {borrar}')

    db = mysql.connection.cursor()
    # print("Contenido 1: ", contenido)
    if contenido != None and id_cuaderno != None and nombre_cuaderno != None and borrar == None:
        formatted_date, currentTime = fecha_hora()

        contenido = contenido.replace(',', '\n')
        contenido = contenido.replace('5hjis6754', '&')
        contenido = contenido.replace('5hjdf4754', ',')
        print("---------- ¡¡¡Entro!!! ----------")
        print(id_cuaderno, nombre_cuaderno)

        db.execute(
        f"SELECT * FROM cuaderno WHERE id_usuario = {session['idUsuario']} AND id_cuaderno = {id_cuaderno} AND nombreCuaderno = '{nombre_cuaderno}'"
        )
        comparacion = db.fetchall()

        if len(comparacion) > 0:
            db.execute(
                f'UPDATE cuaderno set contenido = "{contenido}" WHERE id_usuario = {session["idUsuario"]} AND id_cuaderno = {id_cuaderno} AND nombreCuaderno = "{nombre_cuaderno}"'
            )
            mysql.connection.commit()

            db.execute(
                f"INSERT INTO Traza (id_Usuario, nombre, descripcion, hora, servicio) VALUES ({session['idUsuario']}, '{session['nombre']}', 'Ha editado el cuaderno {nombre_cuaderno}', '{formatted_date}', 'Cuaderno')"
            )
            mysql.connection.commit()

            print("---------- Actualizado con éxito ----------")

        else:
            # print("Contenido 2: ", contenido)
            db.execute(
                    f'INSERT INTO cuaderno (id_usuario, nombreCuaderno, contenido, modoOscuro) VALUES ({session["idUsuario"]}, "{nombre_cuaderno}", "{contenido}", 0)'
            )
            mysql.connection.commit()

            print("---------- Se ha insertado exitosamente ----------")
    elif id_cuaderno != None and nombre_cuaderno != None and borrar != None:
        formatted_date, currentTime = fecha_hora()

        db.execute(
        f"DELETE FROM cuaderno WHERE id_usuario = {session['idUsuario']} AND id_cuaderno = {id_cuaderno} AND nombreCuaderno = '{nombre_cuaderno}'"
        )
        mysql.connection.commit()

        db.execute(
            f"INSERT INTO Traza (id_Usuario, nombre, descripcion, hora, servicio) VALUES ({session['idUsuario']}, '{session['nombre']}', 'Ha eliminado el cuaderno {nombre_cuaderno}', '{formatted_date}', 'Cuaderno')"
        )
        mysql.connection.commit()
    # print(contenido)

    db.execute(
        f"SELECT * FROM cuaderno WHERE id_usuario = {session['idUsuario']}"
    )
    cuaderno = db.fetchall()
    # print("Hola 1 ", cuaderno, len(cuaderno))
    if len(cuaderno) == 0:
        cuaderno = cuaderno + tuple({"contenido": ""})
    # print(cuaderno)

    # db.execute(f"SELECT * FROM cuaderno WHERE id_usuario = {session['idUsuario']}")
    # cuaderno = db.fetchall()

    db.execute(f"SELECT modoOscuro FROM cuaderno WHERE id_usuario = {session['idUsuario']}")
    modo_oscuro = db.fetchone()

    # if modo_oscuro:
    #     modo_oscuro = modo_oscuro[0]
    # else:
    #     modo_oscuro = 0  # O establece el valor predeterminado que desees si no se encuentra en la base de datos

    # print("Hola 2 ", cuaderno, len(cuaderno))

    return render_template("cuaderno.html",dark_mode=dark_mode, cuaderno=cuaderno[0])
@app.route('/obtener_cuadernos', methods=['GET'])
def obtener_cuadernos():
    formatted_date, currentTime = fecha_hora()

    # Realiza una consulta a la base de datos para obtener la lista de cuadernos
    cur = mysql.connection.cursor()
    cur.execute("SELECT nombreCuaderno, contenido, id_cuaderno  FROM cuaderno WHERE id_usuario = %s", (session['idUsuario'],))
    cuadernos = cur.fetchall()
    # Realiza una consulta a la base de datos para obtener la lista de cuadernos
    
    cuadernos_json = [{'nombreCuaderno': cuaderno['nombreCuaderno'],'contenido':cuaderno['contenido'], 'id_cuaderno':cuaderno['id_cuaderno'] } for cuaderno in cuadernos]

    # Devuelve la lista de cuadernos como JSON
    # return jsonify(cuadernos)

    cur.execute(
        f"INSERT INTO Traza (id_Usuario, nombre, descripcion, hora, servicio) VALUES ({session['idUsuario']}, '{session['nombre']}', 'Ha cambiado de cuaderno', '{formatted_date}', 'Cuaderno')"
    )
    mysql.connection.commit()
    cur.close()

    return jsonify(cuadernos_json)
@app.route('/toggle_dark_mode')
def toggle_dark_mode():
    global dark_mode
    dark_mode = not dark_mode
    return redirect(url_for('cuaderno', dark_mode=dark_mode))

@app.route('/actualizar_modo_oscuro', methods=['POST'])
def actualizar_modo_oscuro():
    data = request.get_json()
    modo_oscuro = data.get('modoOscuro')

    cur = mysql.connection.cursor()
    
    # Actualiza el valor de modo oscuro en la base de datos (cuaderno)
    cur.execute("UPDATE cuaderno SET modoOscuro = %s WHERE id_usuario = %s", (modo_oscuro, session['idUsuario']))
    mysql.connection.commit()
    
    cur.close()

    return jsonify({'message': 'Modo oscuro actualizado con éxito'})

@app.route("/cambiar_cuaderno", methods=['GET', 'POST'])
def cambiar_cuaderno():
    if request.method == 'POST':
        nuevo_cuaderno_id = request.form.get("nuevo_cuaderno")

        if nuevo_cuaderno_id:
            print()
            # Aquí debes escribir la lógica para cambiar al cuaderno seleccionado.
            # Puedes utilizar el nuevo_cuaderno_id para cargar el cuaderno desde la base de datos.
    # db = mysql.connection.cursor()
    db = mysql.connection.cursor()
    db.execute(f"SELECT * FROM cuaderno WHERE id_usuario = {session['idUsuario']}")
    cuadernos = db.fetchall()

    print("---------- Se ha cambiado el cuaderno ----------")    
    
    return render_template("cuaderno.html", cuadernos=cuadernos)


# Add reminder route
@app.route("/remindAdd", methods=["GET", "POST"])
def addRemind():
    # Verificar si se ha enviado un formulario POST
    if (
        request.method == "POST"
        and "nameRemind" in request.form
        and "dateRemind" in request.form
        and "timeRemind" in request.form
    ):  

        # Obtener el Evento, las horas de inicio y fin, y el día
        _nameRemind = request.form["nameRemind"]
        _dateRemind = request.form["dateRemind"]
        _timeRemind = request.form["timeRemind"]

        _dateRemind = _dateRemind.split("-")
        _timeRemind = _timeRemind.split(":")
        
        if _dateRemind[2][0] == "0":
            _dateRemind[2] = _dateRemind[2][1]
        if _timeRemind[0][0] == "0":
            _timeRemind[0] = _timeRemind[0][1]
        if _timeRemind[1][0] == "0":
            _timeRemind[1] = _timeRemind[1][1]

        # Crear un cursor para la base de datos MySQL
        cur = mysql.connection.cursor()

        # Insertar el nuevo Evento
        cur.execute(
            "INSERT INTO recordatorios (idUsuario, nombreRecordatorio, y, mm, d, h, m) VALUES (%s, %s, %s, %s, %s, %s, %s)",
            (session["idUsuario"], _nameRemind, _dateRemind[0], _dateRemind[1], _dateRemind[2], _timeRemind[0], _timeRemind[1]),
        )
        mysql.connection.commit()

        #traza recordatorio
        now = datetime.now(colombia_zona_horaria)
        formatted_date = now.strftime("%Y-%m-%d %H:%M:%S")
        

        cur = mysql.connection.cursor()
        

       # Agregar traza a la base de datos
        cur.execute(
        "INSERT INTO Traza (id_Usuario,nombre,descripcion, hora, servicio) VALUES (%s, %s, %s, %s,%s)",
        (session["idUsuario"],session["nombre"], "Ha añadido un recordatorio", formatted_date, "Recordatorio"),
         )
        mysql.connection.commit()
        
        return redirect(url_for('admin'))


@app.route("/remindRemove", methods=["GET", "POST"])
def removeRemind():
    yearSTR = request.args.get("yearSTR")
    monthSTR = request.args.get("monthSTR")
    daySTR = request.args.get("daySTR")
    hourSTR = request.args.get("hourSTR")
    minuteSTR = request.args.get("minuteSTR")
    remindSTR = request.args.get("remindSTR")

    _idUsuarioActual = session["idUsuario"]

    cur = mysql.connection.cursor()
    cur.execute(
        "DELETE FROM recordatorios WHERE nombreRecordatorio = %s AND y = %s AND mm = %s AND d = %s AND h = %s AND m = %s AND idUsuario = %s",
        (
            remindSTR,
            yearSTR,
            monthSTR,
            daySTR,
            hourSTR,
            minuteSTR,
            _idUsuarioActual,
        ),
    )
    mysql.connection.commit()

    #traza registro
    now = datetime.now(colombia_zona_horaria)
    formatted_date = now.strftime("%Y-%m-%d %H:%M:%S")
        

    cur = mysql.connection.cursor()
        

    # Agregar traza a la base de datos
    cur.execute(
    "INSERT INTO Traza (id_Usuario,nombre,descripcion, hora, servicio) VALUES (%s, %s, %s, %s,%s)",
    (session["idUsuario"],session["nombre"], "Ha Eliminado un recordatorio", formatted_date, "Recordatorio"),
    )
    mysql.connection.commit()

    
    return redirect(url_for("admin"))
        
# Edit reminder route
@app.route("/remindEdit", methods=["GET", "POST"])
def editRemind():
    # Verificar si se ha enviado un formulario POST
    if (
        request.method == "POST"
        and "nameRemind" in request.form
        and "dateRemind" in request.form
        and "timeRemind" in request.form
        and "yearSTR" in request.form
        and "monthSTR" in request.form
        and "daySTR" in request.form
        and "hourSTR" in request.form
        and "minuteSTR" in request.form
        and "remindSTR" in request.form
    ):  
        yearSTR = request.form["yearSTR"]
        monthSTR = request.form["monthSTR"]
        daySTR = request.form["daySTR"]
        hourSTR = request.form["hourSTR"]
        minuteSTR = request.form["minuteSTR"]
        remindSTR = request.form["remindSTR"]

        print(yearSTR, monthSTR, daySTR, hourSTR, minuteSTR, remindSTR)
        _idUsuarioActual = session["idUsuario"]

        _nameRemind = request.form["nameRemind"]
        _dateRemind = request.form["dateRemind"]
        _timeRemind = request.form["timeRemind"]

        _dateRemind = _dateRemind.split("-")
        _timeRemind = _timeRemind.split(":")
        
        if _dateRemind[2][0] == "0":
            _dateRemind[2] = _dateRemind[2][1]
        if _timeRemind[0][0] == "0":
            _timeRemind[0] = _timeRemind[0][1]
        if _timeRemind[1][0] == "0":
            _timeRemind[1] = _timeRemind[1][1]

        cur = mysql.connection.cursor()
        cur.execute("SELECT idRecordatorio FROM recordatorios WHERE nombreRecordatorio = %s AND y = %s AND mm = %s AND d = %s AND h = %s AND m = %s AND idUsuario = %s", 
        (
            remindSTR,
            yearSTR,
            monthSTR,
            daySTR,
            hourSTR,
            minuteSTR,
            _idUsuarioActual,
        ),
        )
        resultados = cur.fetchall()
        idRecordatorio = [resultado["idRecordatorio"] for resultado in resultados]
        # Crear un cursor para la base de datos MySQL
        cur = mysql.connection.cursor()

        # Insertar el nuevo Evento
        cur.execute(
            "UPDATE recordatorios SET nombreRecordatorio = %s, y = %s, mm = %s, d = %s, h = %s, m = %s WHERE idRecordatorio = %s AND idUsuario = %s",
            (_nameRemind, _dateRemind[0], _dateRemind[1], _dateRemind[2], _timeRemind[0], _timeRemind[1], idRecordatorio[0], _idUsuarioActual),
        )

        mysql.connection.commit()

        #traza Recordatorio
        now = datetime.now(colombia_zona_horaria)
        formatted_date = now.strftime("%Y-%m-%d %H:%M:%S")
        

        cur = mysql.connection.cursor()
        

        # Agregar traza a la base de datos
        cur.execute(
        "INSERT INTO Traza (id_Usuario,nombre,descripcion, hora, servicio) VALUES (%s, %s, %s, %s,%s)",
        (session["idUsuario"],session["nombre"], "Ha editado un recordatorio", formatted_date, "Recordatorio"),
         )
        mysql.connection.commit()
        
        return redirect(url_for('admin'))
    
#Interfaz Flashcards
@app.route("/flashcards", methods=["GET", "POST"])
@login_required
def flashcards():

    _idUsuarioActual = session["idUsuario"]
    cur = mysql.connection.cursor()

    cur.execute("SELECT nombreMazo, pista, respuesta, dia, mes, año FROM flashcards WHERE id_Usuario = %s", (_idUsuarioActual,))

    resultados = cur.fetchall()
    lista_de_listas = [list(fila.values()) for fila in resultados]

    return render_template("flashcards.html", flashcards = lista_de_listas)


#Agregar Mazo Flashcards
@app.route("/newDeck", methods=["GET", "POST"])
def newDeck():

    nameDeck = request.form["nameDeck"]
    questionFirstCard = request.form["questionFirstCard"]
    answerFirstCard = request.form["answerFirstCard"]

    _idUsuarioActual = session["idUsuario"]

    now = datetime.now(colombia_zona_horaria)
    formatted_date = now.strftime("%Y-%m-%d %H:%M:%S")

    cur = mysql.connection.cursor()

        # Insertar el nuevo Mazo
    cur.execute(
        "INSERT INTO flashcards(id_Usuario, nombreMazo, pista, respuesta, dia, mes, año) VALUES (%s,%s,%s,%s,%s,%s,%s)", 
        (_idUsuarioActual, nameDeck, questionFirstCard, answerFirstCard, 0, 0, 0,)
    )
    mysql.connection.commit()

    # Agregar traza a la base de datos
    cur.execute(
        "INSERT INTO Traza (id_Usuario,nombre,descripcion, hora, servicio) VALUES (%s, %s, %s, %s,%s)",
        (session["idUsuario"],session["nombre"], "Ha creado el mazo " + nameDeck, formatted_date, "Tarjetas Didácticas"),
    )
    mysql.connection.commit()


    return redirect(url_for('flashcards'))

#Borrar Tarjeta Flashcards
@app.route("/deleteFlashcard", methods=["GET", "POST"])
def deleteFlashcard():

    nombreMazo = request.args.get("nombreMazo")
    pregunta = request.args.get("pregunta")
    _idUsuarioActual = session["idUsuario"]

    cur = mysql.connection.cursor()

    now = datetime.now(colombia_zona_horaria)
    formatted_date = now.strftime("%Y-%m-%d %H:%M:%S")

    print(pregunta)

    #BORRAR LA TARJETA CUYA PREGUNTA Y MAZO COINCIDAN
    cur.execute(
        "DELETE FROM flashcards WHERE nombreMazo = %s AND pista = %s AND id_Usuario = %s", 
        (nombreMazo, pregunta, _idUsuarioActual,)
    )
    mysql.connection.commit()

    # Agregar traza a la base de datos
    cur.execute(
        "INSERT INTO Traza (id_Usuario,nombre,descripcion, hora, servicio) VALUES (%s, %s, %s, %s,%s)",
        (session["idUsuario"],session["nombre"], "Ha borrado una tarjeta del mazo " + nombreMazo, formatted_date, "Tarjetas Didácticas"),
    )
    mysql.connection.commit()

    return redirect(url_for('flashcards'))

#Editar Tarjeta Flashcards
@app.route("/editFlashcard", methods=["GET", "POST"])
def editFlashcard():

    nameDeck = request.form["nameDeck1"]
    questionFirstCard = request.form["questionFirstCard"]
    answerFirstCard = request.form["answerFirstCard"]
    previousQuestionFirstCard = request.form["questionFirstCard1"]
    previousAnswerFirstCard = request.form["answerFirstCard1"]

    _idUsuarioActual = session["idUsuario"]

    cur = mysql.connection.cursor()

    now = datetime.now(colombia_zona_horaria)
    formatted_date = now.strftime("%Y-%m-%d %H:%M:%S")

    #EDITAR TARJETA
    cur.execute(
        "UPDATE flashcards SET pista = %s, respuesta = %s WHERE nombreMazo = %s AND pista = %s AND respuesta = %s AND id_Usuario = %s", 
        (questionFirstCard, answerFirstCard, nameDeck, previousQuestionFirstCard, previousAnswerFirstCard, _idUsuarioActual,)
    )
    mysql.connection.commit()

    # Agregar traza a la base de datos
    cur.execute(
        "INSERT INTO Traza (id_Usuario,nombre,descripcion, hora, servicio) VALUES (%s, %s, %s, %s,%s)",
        (session["idUsuario"],session["nombre"], "Ha editado una tarjeta del mazo " + nameDeck, formatted_date, "Tarjetas Didácticas"),
    )
    mysql.connection.commit()

    return redirect(url_for('flashcards'))

@app.route("/cardAdd", methods=["GET", "POST"]) 
def addCard():
    nameDeck = request.form["nameDeckAdd"]
    question = request.form["questionCard"]
    answer = request.form["answerCard"]

    _idUsuarioActual = session["idUsuario"]

    cur = mysql.connection.cursor()

    now = datetime.now(colombia_zona_horaria)
    formatted_date = now.strftime("%Y-%m-%d %H:%M:%S")

    # ADD CARD TO DATABASE
    cur.execute(
        "INSERT INTO flashcards(id_Usuario, nombreMazo, pista, respuesta, dia, mes, año) VALUES (%s,%s,%s,%s,%s,%s,%s)", 
        (_idUsuarioActual, nameDeck, question, answer, 0, 0, 0,)
    )

    # Agregar traza a la base de datos
    cur.execute(
        "INSERT INTO Traza (id_Usuario,nombre,descripcion, hora, servicio) VALUES (%s, %s, %s, %s,%s)",
        (session["idUsuario"],session["nombre"], "Ha creado una tarjeta para el mazo " + nameDeck, formatted_date, "Tarjetas Didácticas"),
    )
    mysql.connection.commit()

    mysql.connection.commit()
    return redirect(url_for('flashcards'))

@app.route('/saveStudyDate', methods=['POST'])
def saveStudyDate():
    receivedDate = request.args.get('date')
    receivedDeck = request.args.get('deck')
    
    cur = mysql.connection.cursor()

    # Split date
    receivedDate = receivedDate.split("/")
    
    # Update study date of deck
    cur.execute(
        "UPDATE flashcards SET dia = %s, mes = %s, año = %s WHERE nombreMazo = %s", 
        (receivedDate[0], receivedDate[1], receivedDate[2], receivedDeck,)
    )

    mysql.connection.commit()
    
    return 'Fecha y mazo recibidos correctamente'

@app.route("/traza")
def traza():
    return render_template("traza.html")


@app.route('/trazaSelect', methods=['POST'])
def trazaSelect():
    data = request.json
    serviceSelected = data.get('serviceSelected')
    print(serviceSelected)

    cur = mysql.connection.cursor()


    # Select from Traza where Servicio=serviceSelected
    cur.execute(
        "SELECT Nombre,Descripcion,Hora,Servicio FROM Traza WHERE Servicio = %s", (serviceSelected,)
    )
    
    resultados = cur.fetchall()
    lista_de_listas = [list(fila.values()) for fila in resultados]
    mysql.connection.commit()
    return lista_de_listas

# Configuración de la clave secreta para las sesiones de usuario
if __name__ == "__main__":
    app.secret_key = "prFlask"
# Ejecución de la aplicación Flask
app.run(debug=True, host="0.0.0.0", port=5000, threaded=True)

