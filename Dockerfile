# Docker Build Stage
#FROM openjdk:17-jdk-alpine-slim as build
FROM maven:3.8.3-openjdk-17 as build

# Build Stage
WORKDIR /workspace/app

COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .
COPY src src

RUN ./mvnw install -DskipTests
RUN mkdir -p target/dependency && (cd target/dependency; jar -xf ../*.jar)


# Docker Build Stage
FROM maven:3.8.3-openjdk-17
VOLUME /tmp
ARG DEPENDENCY=/workspace/app/target/dependency
COPY --from=build ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY --from=build ${DEPENDENCY}/META-INF /app/META-INF
COPY --from=build ${DEPENDENCY}/BOOT-INF/classes /app
#ENTRYPOINT ["java","-Dserver.port=8000:8000","-cp","app:app/lib/*","com.example.demo.DemoApplication"]
ENV PORT 9000
EXPOSE $PORT

ENTRYPOINT ["java","-jar","-Xmx1024M","-Dserver.port=${PORT}","app.jar"]
