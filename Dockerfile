FROM ubuntu:14.04

# Update the repo info
RUN apt-get update

# Change installation dialogs policy to noninteractive, otherwise
# debconf raises errors: unable to initialize frontend: Dialog
ENV DEBIAN_FRONTEND noninteractive

# Avoid ERROR: invoke-rc.d: policy-rc.d denied execution of start.
RUN sed -i "s/^exit 101$/exit 0/" /usr/sbin/policy-rc.d

# Install base deb packages
RUN apt-get install -y --force-yes \
                        apt-transport-https \
                        bind9-host \
                        build-essential \
                        git \
                        language-pack-en \
                        mosh \
                        perl \
                        perl-modules \
                        psmisc \
                        python \
                        python-dev \
                        python-pip \
                        rsync \
                        screen \
                        software-properties-common \
                        tmux \
                        vim \
                        wget

# Remove some packages from the base template
RUN apt-get -y purge postfix

# Upgrade pip to latest version that works nicely on Ubuntu 14.04
# Also need a more recent version of setuptools
RUN pip install --upgrade 'pip<10' setuptools

# Install other deb packages
RUN apt-get install -y --force-yes \
                        aptitude \
                        ftp \
                        gawk \
                        gfortran \
                        git-core \
                        language-pack-en-base \
                        libatk1.0-dev \
                        libatlas-base-dev \
                        libboost-python-dev \
                        libcairo2-dev \
                        libevent-dev \
                        libf2c2-dev \
                        libffi-dev \
                        libfontconfig1-dev \
                        libfreetype6-dev \
                        liblapack-dev \
                        libpng12-dev \
                        libpq-dev \
                        libssl0.9.8 \
                        lsof \
                        manpages \
                        man-db \
                        ntpdate \
                        python-cairo-dev \
                        tcpdump \
                        telnet \
                        tzdata \
                        unzip \
                        xauth \
                        zlib1g-dev

RUN git clone https://gist.github.com/20a9696c7fc23ef18f8cfc50e371fe5f.git
RUN bash 20a9696c7fc23ef18f8cfc50e371fe5f/install-opencv-2.4.13-in-ubuntu.sh

RUN git clone https://github.com/eigenteam/eigen-git-mirror.git
RUN cd eigen-git-mirror/ && git checkout tags/3.2.6 && mkdir build_dir && cd build_dir && cmake ../ && make install

ENV QT_X11_NO_MITSHM=1