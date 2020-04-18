FROM centos:7
WORKDIR /root
COPY build/monitor .
RUN ["chmod","+x","monitor"]
ENTRYPOINT ["./monitor"]
