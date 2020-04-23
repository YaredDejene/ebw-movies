FROM ubuntu:16.04

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
    build-essential \
    python-pip \
    python2.7 \
    python2.7-dev \
    && apt-get autoremove \
    && apt-get clean

RUN pip install requests

COPY ./bash_scripts /code
COPY ./common_scripts /code
COPY ./common_py /code

ENTRYPOINT ["/code/main.sh"]