# Utiliza una imagen base con OpenJDK 21
FROM eclipse-temurin:21-jdk-alpine as builder

# Establece el directorio de trabajo dentro del contenedor
WORKDIR /app

# Establece la codificación
ENV LANG=C.UTF-8

# Copia el archivo de configuración Maven y las dependencias para mejorar el cacheo
COPY pom.xml mvnw ./
COPY .mvn .mvn

# Da permisos de ejecución al mvnw
RUN chmod +x mvnw

# Descarga las dependencias necesarias sin construir el proyecto aún
RUN ./mvnw dependency:resolve

# Copia todo el proyecto en el contenedor
COPY src ./src

# Construye la aplicación usando Maven con codificación explícita
RUN ./mvnw clean package -DskipTests -Dfile.encoding=UTF-8

# Crea una segunda etapa para el contenedor final (imagen más liviana)
FROM eclipse-temurin:21-jre-alpine

# Establece el directorio de trabajo
WORKDIR /app

# Copia el archivo JAR generado desde la etapa de construcción
COPY --from=builder /app/target/webMicroservicios-0.0.1-SNAPSHOT.jar app.jar

# Expone el puerto que usa tu aplicación
EXPOSE 8080

# Comando para ejecutar la aplicación
ENTRYPOINT ["java", "-Dfile.encoding=UTF-8", "-jar", "app.jar"]