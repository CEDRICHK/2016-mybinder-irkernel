FROM ubuntu:xenial

# Install all necessary Ubuntu packages
RUN apt-get update && apt-get install -y python2.7 python-pip && rm -rf /var/lib/apt/lists/* \

# Install Jupyter notebook
RUN pip2 install jupyter

ENV LANG en_US.UTF-8
ENV NB_USER jovyan
ENV NB_UID 1000
ENV HOME /home/${NB_USER}

WORKDIR ${HOME}

USER root
COPY . ${HOME}
RUN chown -R ${NB_USER} ${HOME}
USER ${NB_USER}

CMD jupyter notebook --ip 0.0.0.0
