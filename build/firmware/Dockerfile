FROM centos:7
WORKDIR /root
COPY build/firmware .
RUN ["chmod","+x","firmware"]
ENTRYPOINT ["./firmware"]
