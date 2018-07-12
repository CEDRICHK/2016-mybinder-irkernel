FROM jupyter/r-notebook:c3772fffc4aa4

# Install R
USER root
WORKDIR $DOCKER_HOME
