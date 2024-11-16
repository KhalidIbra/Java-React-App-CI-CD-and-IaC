FROM openjdk:21

WORKDIR /app

COPY backend/target/*.jar /app/app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
