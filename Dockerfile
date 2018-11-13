FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y -qq clean && apt-get -y -qq update
RUN apt-get install -y -qq locales
RUN locale-gen "en_US.UTF-8"
RUN dpkg-reconfigure locales
RUN apt-get install -y -qq curl apt-transport-https
RUN apt-get install -y -qq \
      jq python3-pip iputils-ping

RUN pip3 install && \
      httpie && \
      nbconvert && \
      pandas && \
      numpy

RUN apt-get -y -qq clean && \
  rm -rf /var/lib/apt/lists/*

RUN groupadd -g 1000 docker
RUN useradd -g 1000 -l -M -s /bin/false -u 1000 docker
RUN mkdir -p /work
WORKDIR /work

CMD ["/bin/sh"]
