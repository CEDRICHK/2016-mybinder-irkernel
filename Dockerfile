FROM jupyter/r-notebook:3772fffc4aa4

# Install R
USER root
WORKDIR $DOCKER_HOME
