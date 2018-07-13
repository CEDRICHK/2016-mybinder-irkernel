FROM ubuntu:xenial

# Install all necessary Ubuntu packages
RUN apt-get update && apt-get install -y python2.7 python-pip && rm -rf /var/lib/apt/lists/* \

# Install Jupyter notebook
RUN pip2 install jupyter
