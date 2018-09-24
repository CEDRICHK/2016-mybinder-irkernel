FROM rocker/tidyverse:3.4.2

#pip3 install --no-cache-dir notebook==5.2 && \
RUN apt-get update && \
    apt-get -y install python2.7 python-pip && \
    apt-get -y install python-dev build-essential && \
    apt-get -y install db5.3-util && \
    apt-get -y install libssl-dev libbz2-dev libmcpp-dev libdb++-dev libdb-dev && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 5E6DA83306132997
    apt-add-repository "deb http://zeroc.com/download/apt/ubuntu`lsb_release -rs` stable main" && \
    apt-get update && \
    apt-get -y install zeroc-ice-all-runtime && \
    pip install "zeroc-ice>3.5,<3.7" && \
    pip install jupyter && \
    pip install omego && \
    apt-get purge && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
    
RUN useradd omero
WORKDIR /home/omero
USER omero
RUN omego download python --ice 3.6 --sym OMERO.py

ENV NB_USER rstudio
ENV NB_UID 1000
ENV HOME /home/rstudio
WORKDIR ${HOME}

USER ${NB_USER}

# Set up R Kernel for Jupyter
# RUN R --quiet -e "install.packages(c('repr', 'IRdisplay', 'evaluate', 'crayon', 'pbdZMQ', 'devtools', 'uuid', 'digest'))"
RUN R --quiet -e "devtools::install_github('IRkernel/IRkernel')"
RUN R --quiet -e "IRkernel::installspec()"

# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}
USER root
RUN chown -R ${NB_UID}:${NB_UID} ${HOME}
USER ${NB_USER}

# Run install.r if it exists
RUN if [ -f install.r ]; then R --quiet -f install.r; fi

CMD ["jupyter", "notebook", "--port=8888", "--ip=0.0.0.0"]
