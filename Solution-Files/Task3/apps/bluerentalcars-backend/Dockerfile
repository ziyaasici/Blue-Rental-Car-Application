# # Stage 1: Build the application
# FROM maven:3.8.6-jdk-11 as build
# WORKDIR /app

# # Copy the source code and pom file into the image
# COPY src /app/src
# COPY pom.xml /app

# # Compile and package the application
# RUN mvn clean package -DskipTests

# # Stage 2: Create the final runtime image
# FROM openjdk:11-jre-slim
# WORKDIR /app

# # Copy only the artifacts we need from the first stage and discard the rest
# COPY --from=build /app/target/*.jar /app/app.jar

# # Expose the port the app runs on
# EXPOSE 8080

# # Define the command to run the application
# CMD ["java", "-jar", "app.jar"]


FROM maven:3.8.1-openjdk-11-slim AS build
RUN mkdir -p workspace
WORKDIR /workspace
COPY pom.xml /workspace/
COPY src /workspace/src
RUN mvn clean package -DskipTests



FROM adoptopenjdk:11-jre-hotspot
COPY --from=build /workspace/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]