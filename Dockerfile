LABEL maintainer "Forest Gregg <fgregg@datamade.us>"
FROM rocker/verse:latest

RUN mkdir /app
WORKDIR /app
COPY . /app

RUN make install/R

ENTRYPOINT ["make"]