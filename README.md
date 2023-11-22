## unAgenda - Ingesoft
Proyecto junto con actividades a realizar; Ingeniería de Software, Universidad Nacional de Colombia. Desarrollado por:
Iván Rengifo, John  Cortés, Sergio Perez, Diego Ramírez, Anderson Chila & Andrés Hernández


# Instalación
Asegurarse de contar con v3.9 -> en adelante de Python. Importar la Base de Datos en algún gestor (recomentable MySQL Workbench), y que los datos para conexión sean los mismos:

```python
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'root'
app.config['MYSQL_DB'] = 'prFlask'
app.config['MYSQL_CURSORCLASS'] = 'DictCursor'
```

```bash
gh repo clone dieramirezma/Agenda-Ingesoft
```

Instalación de modulos requeridos para la ejecución apropiada del código

```bash
pip install -r requirements.txt
```

# Lanzamiento
```bash
python main.py
```
E ir finalmente a `http://127.0.0.1:5000`

