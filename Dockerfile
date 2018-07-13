FROM ubuntu:xenial

# Install all necessary Ubuntu packages
RUN apt-get update && apt-get install -y python2.7 python-pip && rm -rf /var/lib/apt/lists/* \

# Install Jupyter notebook
RUN pip2 install jupyter

ENV LANG en_US.UTF-8
ENV NB_USER jovyan
ENV NB_UID 1000
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}

CMD ["jupyter", "notebook", "--ip", "0.0.0.0"]
