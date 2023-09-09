## unAgenda-Ingesoft
Proyecto junto con actividades a realizar; Ingeniería de Software, Universidad Nacional de Colombia

Desarrollado por:
- Iván Felipe Ayala Rengifo
- John Andrés Rua Cortés
- Sergio Alejandro Nova Perez
- Juan Sebastian Gordillo Medina
- Diego Nicolas Ramirez Maldonado
- Anderson David Morales Chila
- Andrés Hernández


## Instalación
Asegurarse de contar con v3.9 -> en adelante de Python. Importar la Base de Datos en algún gestor (recomentable MySQL Workbench), y que los datos para conexión sean los mismos:

```python
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'root'
app.config['MYSQL_DB'] = 'prFlask'
app.config['MYSQL_CURSORCLASS'] = 'DictCursor'
```

## Clonación del repositorio localmente

```bash
git clone <repo-url>
```

## Modulos requeridos para ejecución

```bash
pip install -r requirements.txt
```

## Lanzamiento

```bash
python main.py
```

## Visualización

Ir a `http://127.0.0.1:5000`

