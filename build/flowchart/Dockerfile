FROM centos:7
WORKDIR /root
COPY build/flowchart .
RUN ["chmod","+x","flowchart"]
ENTRYPOINT ["./flowchart"]
