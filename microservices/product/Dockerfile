FROM openjdk:11-jdk-slim
VOLUME /tmp
COPY target/product-service-1.0.0.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]

