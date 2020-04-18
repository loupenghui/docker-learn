FROM centos:7
WORKDIR /root
COPY build/api .
RUN ["chmod","+x","api"]
ENTRYPOINT ["./api"]