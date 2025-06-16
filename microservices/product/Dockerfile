FROM openjdk:17-jdk-slim

WORKDIR /app
COPY pom.xml ./
COPY ProductApplication.java ./

RUN mkdir -p /app/target

RUN apt-get update && \
    apt-get install -y maven && \
    mvn clean package -DskipTests

CMD ["java", "-cp", "target/classes", "ProductApplication"]

