FROM centos:7
WORKDIR /root
COPY build/sdk .
RUN ["chmod","+x","sdk"]
ENTRYPOINT ["./sdk"]
