FROM compdatasci/base

# Install R
USER root
WORKDIR /tmp

COPY install-irkernel.R /tmp/install-irkernel.R 

RUN apt-get update && \
    apt-get upgrade -y -o Dpkg::Options::="--force-confold" && \
    apt-get install -y --no-install-recommends r-base \
            libssl-dev \
            libcairo2-dev \
            libcurl4-openssl-dev && \
    R --no-save < /tmp/install-irkernel.R
    
WORKDIR $DOCKER_HOME
