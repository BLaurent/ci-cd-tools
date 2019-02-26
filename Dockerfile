FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y -qq clean && apt-get -y -qq update
RUN apt-get install -y -qq locales
RUN locale-gen "en_US.UTF-8"
RUN dpkg-reconfigure locales
RUN apt-get install -y -qq curl apt-transport-https
RUN apt-get install -y -qq \
      jq python3-pip iputils-ping httpie

RUN pip3 install \
      pandas \
      nbconvert \
      numpy

RUN mkdir -p /work/nvm
ENV NVM_DIR /work/nvm
ENV NODE_VERSION 10.15.1
ENV NVM_VERSION v0.34.0

# Install nvm with node and npm
RUN curl https://raw.githubusercontent.com/creationix/nvm/$NVM_VERSION/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default \
    && npm install -g fs jtest babel-cli babel-preset-env supertest superagent 

ENV VEGETA_VERSION 12.2.0

RUN mkdir vegeta && \
    curl -s -L https://github.com/tsenart/vegeta/releases/download/cli%2Fv$VEGETA_VERSION/vegeta-$VEGETA_VERSION-linux-amd64.tar.gz -o vegeta/vegeta-$VEGETA_VERSION-linux-amd64.tar.gz && \
    cd vegeta && \
    tar xvfz vegeta-$VEGETA_VERSION-linux-amd64.tar.gz && \
    mv vegeta /usr/bin/ && \
    rm -rf vegeta && \
    cd -

RUN apt-get -y -qq clean && \
  rm -rf /var/lib/apt/lists/*

RUN groupadd -g 1000 docker
RUN useradd -g 1000 -l -M -s /bin/false -u 1000 docker
RUN mkdir -p /work
WORKDIR /work

CMD ["/bin/sh"]
