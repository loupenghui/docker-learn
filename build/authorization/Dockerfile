FROM adoptopenjdk/openjdk8:latest 
WORKDIR /root
COPY build/authorization.jar .
RUN ["chmod","+x","authorization.jar"]
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","authorization.jar"]
