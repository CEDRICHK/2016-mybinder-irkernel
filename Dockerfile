FROM andrewosh/binder-base

USER root
WORKDIR /tmp

# Add R dependencies
RUN apt-get update
RUN apt-get install -y --no-install-recommends r-base \
            libssl-dev \
            libcairo2-dev \
            libcurl4-openssl-dev && \
            
    R --no-save < /tmp/install_irkernel.R && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY install-irkernel.R /tmp/install-irkernel.R

RUN R --no-save < /tmp/install-irkernel.R

WORKDIR $DOCKER_HOME
