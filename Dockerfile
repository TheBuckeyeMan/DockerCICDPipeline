FROM openjdk:17-jdk
ARG JAR_FILE=./target/DockerCICDPipeline-0.0.1-SNAPSHOT.jar
COPY target/DockerCICDPipeline-0.0.1-SNAPSHOT.jar cicdapp.jar
ENTRYPOINT ["java","-jar","cicdapp.jar"]




