FROM andrewosh/binder-base

USER root
WORKDIR /tmp

# Add R dependencies
RUN apt-get update
RUN apt-get install -y r-base libzmq3-dev

COPY install-irkernel.R /tmp/install-irkernel.R

RUN R --no-save < /tmp/install-irkernel.R
USER main

WORKDIR $DOCKER_HOME
