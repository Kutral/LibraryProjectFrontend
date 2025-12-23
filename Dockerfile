# Stage 1: Build the application
FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app

# Copy the pom.xml and source code
COPY pom.xml .
COPY src ./src

# Build the WAR file
RUN mvn clean package -DskipTests

# Stage 2: Deploy to Tomcat
FROM tomcat:10.1-jdk21-openjdk-slim

# Remove default Tomcat applications
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the WAR file from the build stage
# According to pom.xml, the finalName is 'library'
COPY --from=build /app/target/library.war /usr/local/tomcat/webapps/ROOT.war

# Expose the default Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
