FROM alpine:3.10

RUN apk update
RUN apk add bash
RUN apk add py-pip
RUN apk add openjdk7-jre

RUN pip install requests

COPY ./bash_scripts /code
COPY ./common_scripts /code
COPY ./common_py /code

ENTRYPOINT ["/code/main.sh"]