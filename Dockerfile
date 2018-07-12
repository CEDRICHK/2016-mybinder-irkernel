FROM andrewosh/binder-base

USER root
WORKDIR /tmp

COPY install-irkernel.R /tmp/install-irkernel.R

# Add R dependencies
RUN apt-get update
RUN apt-get install -y --no-install-recommends r-base \
            libssl-dev \
            libcairo2-dev \
            libcurl4-openssl-dev && \
            
    R --no-save < /tmp/install-irkernel.R && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    
RUN R --no-save < /tmp/install-irkernel.R

WORKDIR $DOCKER_HOME
