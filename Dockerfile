FROM rocker/verse:latest
LABEL maintainer "Forest Gregg <fgregg@datamade.us>"

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
     libudunits2-dev \
     libgdal-dev \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/ \
  && install2.r --error --deps TRUE \
    tidycensus srvyr lwgeom \
  && tlmgr install \
    amsmath \
    latex-amsmath-dev \
    iftex kvoptions \
    ltxcmds \
    kvsetkeys \
    etoolbox \
    xcolor \
    auxhook \
    bigintcalc \
    bitset \
    etexcmds \
    gettitlestring \
    hycolor \
    hyperref \
    intcalc \
    kvdefinekeys \
    letltxmacro \
    pdfescape \
    refcount \
    rerunfilecheck \
    stringenc \
    uniquecounter \
    zapfding \
    pdftexcmds \
    infwarerr \
    geometry \
    booktabs \
    mdwtools \
    epstopdf-pkg


RUN mkdir /app
WORKDIR /app
COPY . /app

ENTRYPOINT ["make"]