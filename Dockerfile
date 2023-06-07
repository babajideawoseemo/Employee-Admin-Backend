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

COPY ./employeedb.sql/tmp

CMD [ "mysqld", "--init-file=/tmp/create-local-db.sql" ]