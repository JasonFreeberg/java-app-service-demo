FROM maven:3.3-jdk-8

COPY project/  /project/
WORKDIR /project/
RUN mvn clean install

# Base image uses the Zulu JRE, which gives you free support and security patches when used on Azure.
FROM mcr.microsoft.com/java/jre-headless:8u212-zulu-alpine
 
EXPOSE 8080 2222

COPY --from=0 /project/target/app.jar /app.jar
WORKDIR /

# startup.sh starts the SSH daemon and the Java app
CMD ["java", "-jar", "app.jar"]