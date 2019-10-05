FROM ubuntu:16.04
LABEL maintainer="rexrliu@gmail.com"

WORKDIR /
################################################################################
# update and install basic tools
ENV PATH /opt/conda/bin:$PATH

RUN apt-get -qq update && apt-get -qq -y install curl bzip2 \
    && curl -sSL https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/miniconda.sh \
    && bash /tmp/miniconda.sh -bfp /opt/conda \
    && rm -rf /tmp/miniconda.sh \
    && conda install -y python=3 \
    && conda install -y numpy \
    && conda install -y pandas \
    && conda install -y matplotlib \
    && conda install -y scikit-learn \
    && conda install -y scipy \
    && conda update conda \
    && apt-get -qq -y remove curl bzip2 \
    && apt-get -qq -y autoremove \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /var/log/dpkg.log \
    && conda clean --all --yes

################################################################################
# install tabpy
RUN python -m pip install --upgrade pip && pip install tabpy
ADD file.conf /opt/conda/etc

################################################################################
# open ports
# TABPY
EXPOSE 9004

################################################################################
# create startup script and set ENTRYPOINT
#ADD start.sh /usr/local/sbin
#ENTRYPOINT ["/bin/bash", "/usr/local/sbin/start.sh"]
#CMD ["tabpy", "tabpy"]
