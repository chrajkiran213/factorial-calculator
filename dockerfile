# Use an official Maven image as the base image
FROM maven:3.8.3-openjdk-11 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the Maven project files to the container
COPY pom.xml .
COPY src ./src

# Build the application using Maven
RUN mvn clean package

# Use an official OpenJDK image as the base image for running the application
FROM openjdk:11-jre-slim

# Set the working directory in the container
WORKDIR /app

# Copy the built JAR file from the Maven build stage to the container
COPY --from=build /app/target/factorial-calculation-1.0-SNAPSHOT.jar .

# Command to run the application
CMD ["java", "-jar", "factorial-calculation-1.0-SNAPSHOT.jar"]

