FROM gradle:jdk8  AS builder
WORKDIR /app
COPY .  /app
RUN ./gradlew clean build  -x test

FROM openjdk:8-jdk-alpine
COPY --from=builder /app/build/libs/intranet_app_manager*.jar /app.jar
CMD ["java","-jar","/app.jar","-Dspring.config.location=/config.properties"]
