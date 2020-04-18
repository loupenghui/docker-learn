FROM adoptopenjdk/openjdk8:latest
WORKDIR /root
COPY build/easytong.jar .
RUN ["chmod","+x","easytong.jar"]
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","easytong.jar"]
