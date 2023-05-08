# Script Práctica 2 - Bases de Datos 2
# Fernando José Martínez Santana

# Importaciones necesarias
from sqlalchemy import create_engine, Table, Column, Integer, String, DateTime, Sequence, ForeignKey, inspect
from sqlalchemy.orm import sessionmaker, declarative_base, relationship
from datetime import datetime # Necesario para obtener la fecha y la hora de actualizacion en la base de datos
from sqlalchemy.exc import IntegrityError

# Conexión con la base de datos
engine = create_engine('mysql+pymysql://ferjose:1234@localhost/sakila')

# Necesario para definir las tablas de la base de datos
Base = declarative_base()

# Clase que representa a la tabla country de la base de datos
class Country(Base):
    __tablename__ = 'country'

    country_id = Column(Integer, Sequence('country_id_seq'), primary_key=True, autoincrement=True)
    country = Column(String(50))
    last_update = Column(DateTime)

# Clase que representa a la tabla city de la base de datos
class City(Base):
    __tablename__ = 'city'

    city_id = Column(Integer, Sequence('city_id_seq'), primary_key=True, autoincrement=True)
    city = Column(String(50))
    country_id = Column(Integer, ForeignKey('country.country_id'))
    country = relationship('Country')
    last_update = Column(DateTime)

# Clase que representa a la tabla users de la base de datos
class Users(Base):
    __tablename__ = 'users'

    id = Column(Integer, primary_key=True)
    nombre = Column(String(50))
    contrasenya = Column(String(100))

# Función main del programa. Configura el menu de la aplicacion
def main():
    while True:
        print("Menú principal:")
        print("1. Crear país")
        print("2. Listar países")
        print("3. Eliminar país")
        print("4. Crear ciudad")
        print("5. Listar ciudades")
        print("6. Eliminar ciudad")
        print("7. Crear tabla usuarios")
        print("8. Borrar tabla usuarios")
        print("9. Mostrar estructura tabla")
        print("0. Salir")

        opcion = input("Seleccione una opción: ")

        if opcion == "1":
            crear_pais()
        elif opcion == "2":
            listar_paises()
        elif opcion == "3":
            eliminar_pais()
        elif opcion == "4":
            crear_ciudad()
        elif opcion == "5":
            listar_ciudades()
        elif opcion == "6":
            eliminar_ciudad()
        elif opcion == "7":
            crear_tabla_usuarios()
        elif opcion == "8":
            borrar_tabla_usuarios()
        elif opcion == "9":
            mostrar_estructura_tabla_usuarios()
        elif opcion == "0":
            break
        else:
            print("Opción inválida. Por favor seleccione una opción válida.")


# Funcion para crear un nuevo pais en la base de datos
def crear_pais():

    nombre = input("Introduce el nombre del país: ") # Se recoge la cadena introducida por el usuario

    Session = sessionmaker(bind=engine)
    session = Session() # Necesario para interactuar con la base de datos

    nuevo_pais = Country(country=nombre, last_update=datetime.now())

    session.add(nuevo_pais) # Se agrega el nuevo pais a la sesion
    session.commit() # Confirmar los cambios en la base de datos
    session.close() # Se cierra la sesion

    print(f'Se ha insertado el país {nombre} en la base de datos.') # Mostrar mensaje de confirmacion de la operacion


# Funcion para listar los paises de la base de datos
def listar_paises():

    print('Países de la base de datos: ')

    Session = sessionmaker(bind=engine)
    session = Session()

    result = session.query(Country).all() # Se realiza una consulta que devuelva todos los paises existentes

    for country in result: # Se recorre el resultado de la consulta
        print(country.country_id, country.country, country.last_update)

    session.close()


# Funcion para eliminar un pais de la base de datos
def eliminar_pais():

    id_pais = input("Introduce el id del país que quieres eliminar: ")

    Session = sessionmaker(bind=engine)
    session = Session()

    try: # Se captura la operacion de borrado debido a la dependencia con la tabla city

        pais = session.query(Country).filter_by(country_id=id_pais).first() # Se busca el pais en la base de datos

        if pais: # Si existe el pais
            session.delete(pais) # Se elimina el pais devuelto por la consulta
            session.commit()

            print(f'Se ha eliminado el país {pais.country} de la base de datos.')

        else:
            print(f'No se ha encontrado ningún país con el id {id_pais}.')

    except IntegrityError as e:
        print("No se ha podido eliminar el país debido a un error de integridad")
        session.rollback() # Deshacer cambios en la base de datos
        
    session.close()


# Funcion para crear una nueva ciudad en la base de datos
def crear_ciudad():

    nombre_ciudad = input("Introduce el nombre de la ciudad: ")
    nombre_pais = input("Introduce el nombre del país donde está esa ciudad(en inglés): ")

    Session = sessionmaker(bind=engine)
    session = Session()

    fila_pais = session.query(Country).filter_by(country=nombre_pais).first()

    if not fila_pais: # Si no existe el pais en la base de datos
        print(f'Error: El país {nombre_pais} no existe en la base de datos.')
        session.close()
        return # No se puede crear al ciudad

    nueva_ciudad = City(city=nombre_ciudad, country_id=fila_pais.country_id, country=fila_pais, last_update=datetime.now()) # Si existe el pais

    session.add(nueva_ciudad)
    session.commit()
    session.close()

    print(f'Se ha insertado la ciudad {nombre_ciudad} en la base de datos.')


# Funcion para listar las ciudades de la base de datos
def listar_ciudades():

    print('Ciudades de la base de datos: ')

    Session = sessionmaker(bind=engine)
    session = Session()

    result = session.query(City).all()

    for city in result:
        print(city.city_id, city.city, city.country_id, city.last_update)

    session.close()

# Funcion para eliminar una ciudad de la base de datos
def eliminar_ciudad():

    id_ciudad = input("Introduce el id de la ciudad que quieres eliminar: ")

    Session = sessionmaker(bind=engine)
    session = Session()
    ciudad = session.query(City).filter_by(city_id=id_ciudad).first()

    if ciudad:
        session.delete(ciudad)
        session.commit()

        print(f'Se ha eliminado la ciudad {ciudad.city} de la base de datos.')

    else:
        print(f'No se ha encontrado ninguna ciudad con el id {id_ciudad}.')
        
    session.close()


# Funcion para crear la tabla usuarios en la base de datos
def crear_tabla_usuarios():

    Base.metadata.drop_all(engine, [Users.__table__]) # Se borra la tabla usuarios
    Base.metadata.create_all(engine) # Se crea la tabla

    print("La tabla usuarios ha sido creada exitosamente")


# Función para borrar la tabla usuarios de la base de datos
def borrar_tabla_usuarios():

    inspector = inspect(engine) # Necesario para inspeccionar la estructura de la base de datos

    if inspector.has_table('users'): # Se comprueba si la base de datos tiene la tabla usuarios

        Base.metadata.drop_all(engine, [Users.__table__])
        print('La tabla "usuarios" ha sido eliminada de la base de datos.')

    else:
        print('La tabla "usuarios" no existe en la base de datos.')


# Funcion para mostrar los campos de la tabla usuarios
def mostrar_estructura_tabla_usuarios():

    inspector = inspect(engine)

    if inspector.has_table('users'):
        usuarios_table = Users.__table__

        print("Estructura de la tabla 'usuarios': ")

        for column in inspector.get_columns('users'): # Se recorren las columnas de la tabla
            print(column['name'], column['type']) # Se muestra el nombre y el tipo del campo

    else:
        print('La tabla "usuarios" no existe en la base de datos.')


if __name__ == "__main__": # Para ejecutar el main cuando el archivo sea el programa principal
    main()