FROM centos:centos7
MAINTAINER ome-devel@lists.openmicroscopy.org.uk

RUN yum -y -q install bzip2
RUN curl -s -o /tmp/miniconda.sh https://repo.continuum.io/miniconda/Miniconda2-4.3.11-Linux-x86_64.sh && \
    [[ $(md5sum /tmp/miniconda.sh) == 'd573980fe3b5cdf80485add2466463f5  /tmp/miniconda.sh' ]] && \
    sh /tmp/miniconda.sh -b -p /opt/conda && \
    rm /tmp/miniconda.sh

RUN /opt/conda/bin/conda config --add channels bioconda && \
/opt/conda/bin/conda install -q python-omero

FROM rocker/tidyverse:3.4.2

#pip3 install --no-cache-dir notebook==5.2 && \
RUN apt-get update && \
    apt-get -y install python2.7 python-pip && \
    pip install jupyter && \
    apt-get purge && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

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
