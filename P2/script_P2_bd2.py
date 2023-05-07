# Script Práctica 2 - Bases de Datos 2
# Fernando José Martínez Santana

from sqlalchemy import create_engine, Table, Column, Integer, String, DateTime, Sequence, ForeignKey, inspect
from sqlalchemy.orm import sessionmaker, declarative_base, relationship
from datetime import datetime
from sqlalchemy.exc import IntegrityError

engine = create_engine('mysql+pymysql://ferjose:1234@localhost/sakila')

Base = declarative_base()

class Country(Base):
    __tablename__ = 'country'

    country_id = Column(Integer, Sequence('country_id_seq'), primary_key=True, autoincrement=True)
    country = Column(String(50))
    last_update = Column(DateTime)

class City(Base):
    __tablename__ = 'city'

    city_id = Column(Integer, Sequence('city_id_seq'), primary_key=True, autoincrement=True)
    city = Column(String(50))
    country_id = Column(Integer, ForeignKey('country.country_id'))
    country = relationship('Country')
    last_update = Column(DateTime)

class Users(Base):
    __tablename__ = 'users'

    id = Column(Integer, primary_key=True)
    nombre = Column(String(50))
    contrasenya = Column(String(100))

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

def crear_pais():
    nombre = input("Introduce el nombre del país: ")
    Session = sessionmaker(bind=engine)
    session = Session()
    nuevo_pais = Country(country=nombre, last_update=datetime.now())
    session.add(nuevo_pais)
    session.commit()
    session.close()

    print(f'Se ha insertado el país {nombre} en la base de datos.')

def listar_paises():
    print('Países de la base de datos: ')
    Session = sessionmaker(bind=engine)
    session = Session()
    result = session.query(Country).all()
    for country in result:
        print(country.country_id, country.country, country.last_update)
    session.close()

def eliminar_pais():
    id_pais = input("Introduce el id del país que quieres eliminar: ")
    Session = sessionmaker(bind=engine)
    session = Session()
    try:
        pais = session.query(Country).filter_by(country_id=id_pais).first()

        if pais:
            session.delete(pais)
            session.commit()

            print(f'Se ha eliminado el país {pais.country} de la base de datos.')
        else:
            print(f'No se ha encontrado ningún país con el id {id_pais}.')
    except IntegrityError as e:
        print("No se ha podido eliminar el país debido a un error de integridad")
        session.rollback()
        
    session.close()

def crear_ciudad():
    nombre_ciudad = input("Introduce el nombre de la ciudad: ")
    nombre_pais = input("Introduce el nombre del país donde está esa ciudad(en inglés): ")
    Session = sessionmaker(bind=engine)
    session = Session()

    fila_pais = session.query(Country).filter_by(country=nombre_pais).first()

    if not fila_pais:
        print(f'Error: El país {nombre_pais} no existe en la base de datos.')
        session.close()
        return

    nueva_ciudad = City(city=nombre_ciudad, country_id=fila_pais.country_id, country=fila_pais, last_update=datetime.now())

    session.add(nueva_ciudad)
    session.commit()
    session.close()

    print(f'Se ha insertado la ciudad {nombre_ciudad} en la base de datos.')

def listar_ciudades():
    print('Ciudades de la base de datos: ')
    Session = sessionmaker(bind=engine)
    session = Session()
    result = session.query(City).all()
    for city in result:
        print(city.city_id, city.city, city.country_id, city.last_update)
    session.close()

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

def crear_tabla_usuarios():
    Base.metadata.drop_all(engine, [Users.__table__])
    Base.metadata.create_all(engine)
    print("La tabla usuarios ha sido creada exitosamente")

def borrar_tabla_usuarios():
    inspector = inspect(engine)
    if inspector.has_table('users'):
        Base.metadata.drop_all(engine, [Users.__table__])
        print('La tabla "usuarios" ha sido eliminada de la base de datos.')
    else:
        print('La tabla "usuarios" no existe en la base de datos.')

def mostrar_estructura_tabla_usuarios():
    inspector = inspect(engine)
    if inspector.has_table('users'):
        usuarios_table = Users.__table__
        print("Estructura de la tabla 'usuarios': ")
        for column in inspector.get_columns('users'):
            print(column['name'], column['type'])
    else:
        print('La tabla "usuarios" no existe en la base de datos.')

if __name__ == "__main__":
    main()