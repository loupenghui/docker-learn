FROM alpine:latest
WORKDIR /root
COPY build/serviceapi .
RUN ["chmod","+x","serviceapi"]
ENTRYPOINT ["./serviceapi"]