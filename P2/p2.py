from sqlalchemy import create_engine, Table, Column, Integer, String, DateTime, Sequence
from sqlalchemy.orm import sessionmaker, declarative_base
from datetime import datetime

engine = create_engine('mysql+pymysql://ferjose:1234@localhost/sakila')

Base = declarative_base()

class Country(Base):
    __tablename__ = 'country'

    country_id = Column(Integer, Sequence('country_id_seq'), primary_key=True, autoincrement=True)
    country = Column(String(50))
    last_update = Column(DateTime)

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
            mostrar_estructura_tabla()
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
    pais = session.query(Country).filter_by(country_id=id_pais).first()

    if pais:
        session.delete(pais)
        session.commit()

        print(f'Se ha eliminado el país {pais.country} de la base de datos.')
    else:
        print(f'No se ha encontrado ningún país con el id {id_pais}.')
        
    session.close()

if __name__ == "__main__":
    main()