FROM adoptopenjdk/openjdk8:latest
WORKDIR /root
COPY build/basedefinition.jar .
RUN ["chmod","+x","basedefinition.jar"]
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","basedefinition.jar"]
