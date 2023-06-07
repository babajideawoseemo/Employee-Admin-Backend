#
# Build Stage
#

FROM maven:3.9.0-eclipse-temurin-17-alpine AS build
COPY . .
RUN mvn clean package -DskipTests

#
# Package stage
#
FROM openjdk:11-jre-slim
COPY --from=build /target/employee-system-api-0.0.1-SNAPSHOT.jar /usr/local/lib/employee-system-api-0.0.1-SNAPSHOT.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/usr/local/lib/employee-system-api-0.0.1-SNAPSHOT.jar"]

FROM mysql
MAINTAINER awoseemobabajide@gmail.com

ENV MYSQL_ROOT_PASSWORD Jide@123
ADD create-local-db.sql /docker-entrypoint-initdb.d

EXPOSE 3306