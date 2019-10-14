FROM ubuntu:16.04

RUN apt-get update && apt-get install -y sudo

COPY Gerris /Gerris

RUN export uid=1000 gid=1000 && \
    mkdir -p /home/gerris && \
    echo "gerris:x:${uid}:${gid}:gerris,,,:/home/gerris:/bin/bash" >> /etc/passwd && \
    echo "gerris:x:${uid}:" >> /etc/group && \
    echo "gerris ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/gerris && \
    chmod 0440 /etc/sudoers.d/gerris && \
    chown ${uid}:${gid} -R /home/gerris

RUN apt install -y /Gerris/*.deb

USER gerris
ENV HOME /home/gerris
WORKDIR /home/gerris
