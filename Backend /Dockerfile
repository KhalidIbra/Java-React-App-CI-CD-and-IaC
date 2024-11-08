# Use an official JDK runtime as a parent image
FROM openjdk:21.0.5
# Set the working directory
WORKDIR /app
# Copy the Maven build files and dependencies
COPY target/*.jar app.jar
# Expose the backend port
EXPOSE 8080
# Command to run the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]
