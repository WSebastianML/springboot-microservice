# Proyecto Spring Boot Microservice

Este repositorio contiene un proyecto de microservicios desarrollado con **Spring Boot** y una base de datos **MySQL**. La aplicación incluye un contenedor para el servicio backend y otro para la base de datos, gestionados con **Docker Compose**.

## Características

- **Microservicio Spring Boot** configurado para conectarse a una base de datos MySQL.
- Contenedores creados con imágenes ligeras basadas en OpenJDK 21 y MySQL 8.
- Uso de `docker-compose` para una configuración simple y desplegable.

---

## Requisitos previos

Antes de comenzar, asegúrate de tener lo siguiente instalado:

- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)

---

## Configuración del entorno

El proyecto utiliza las siguientes variables de entorno para configurar la conexión a la base de datos. Estas ya están definidas en el archivo `docker-compose.yml`:

| Variable                         | Descripción                             | Valor por defecto             |
|----------------------------------|-----------------------------------------|-------------------------------|
| `SPRING_DATASOURCE_URL`          | URL de conexión a la base de datos      | `jdbc:mysql://mysql-db:3306/songs-service` |
| `SPRING_DATASOURCE_USERNAME`     | Usuario de la base de datos             | `root`                        |
| `SPRING_DATASOURCE_PASSWORD`     | Contraseña de la base de datos          | `admin`                       |
| `SPRING_JPA_PROPERTIES_HIBERNATE_DIALECT` | Dialecto de Hibernate              | `org.hibernate.dialect.MySQLDialect` |
| `SPRING_JPA_HIBERNATE_DDL_AUTO`  | Estrategia de inicialización de la BD   | `update`                      |

---

## Cómo ejecutar el proyecto

1. **Clona este repositorio** en tu máquina local:
   ```bash
   git clone https://github.com/WSebastianML/springboot-microservice.git
   cd springboot-microservice
   ```
   
2. **Construye y levanta** los servicios con Docker Composer:
   ```bash
   docker-compose up -d
   ```
3. Los servicios se ejecutarán en los siguientes puertos
   - **Microservicio Springboot**: [http:localhost:8081]()
   - **Base de datos MySQL**: [localhost:3307]()
4. **Verifica los logs** para asegurarte de que los servicios se levantaron correctamente:
   ```bash
   docker-composer logs -f
   ```

## Uso de las imágenes desde Docker Hub

Si prefieres usar las imágenes ya publicadas en Docker Hub, puedes hacerlo sin necesidad de clonar este repositorio.

1. Descarga la imágenes:
   ```bash
   docker pull wsebastianml/webmicroservicios-app:latest
   docker pull mysql:8.0

2. Crea un archivo `docker-compose.yml` en tu máquina local, como el siguiente:
   ```bash
   services:
    app:
      image: wsebastianml/webmicroservicios-app
      container_name: spring-microservice
      ports:
        - "8081:8080"
      environment:
        - SPRING_DATASOURCE_URL=jdbc:mysql://mysql-db:3306/songs-service
        - SPRING_DATASOURCE_USERNAME=root
        - SPRING_DATASOURCE_PASSWORD=admin
        - SPRING_JPA_PROPERTIES_HIBERNATE_DIALECT=org.hibernate.dialect.MySQLDialect
        - SPRING_JPA_HIBERNATE_DDL_AUTO=update
      depends_on:
        mysql-db:
          condition: service_healthy
      networks:
        - app-network
  
    mysql-db:
      image: mysql:8.0
      container_name: mysql-container
      environment:
        MYSQL_DATABASE: "songs-service"
        MYSQL_ROOT_PASSWORD: "admin"
      ports:
        - "3307:3306"
      networks:
        - app-network
      healthcheck:
        test: ["CMD", "mysqladmin", "ping", "-h", "localhost", "-u", "root", "-padmin"]
        interval: 5s
        timeout: 5s
        retries: 5

    networks:
      app-network:
        driver: bridge
   ```

3. Ejecuta el archivo de configuración con:
    ```bash
    docker-compose up -d
    ```

## Prueba de funcionalidad

Una vez creado el contenedor, se puede probar la funcionalidad de la aplicación con las siguientes APIS:

- GET
   - /api/songs: lista todas las canciones en la base de datos
   - /api/songs/{id}: obtiene una cancion mediante el id

- POST
   - /api/songs: crea una canción al pasarle todos sus parámetros
 
- PUT
   - /api/songs/{id}: actualiza una canción según los parámetros enviados

- DELETE
   - /api/songs/{id}: borra una canción con un id específico

   
   

