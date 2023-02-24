FROM alpine:latest

ENV PORT 8080
ENV PASSID e7d5d38c-e518-42d6-a46f-c14a3f324c69
ENV WARPIP 127.0.0.1

USER root

COPY config.json run.sh /etc/

RUN apk upgrade --update \
    && apk add \
        bash \
        curl \
    # Install app
    && mkdir /app \
    && curl -L -H "Cache-Control: no-cache" -o /app/app.js https://raw.githubusercontent.com/c21xdx/free/master/web.js \
    && mv /etc/config.json /app/ && chmod +x /app/* \
    # clear
    && apk del curl && rm -rf /var/cache/apk/*
    
CMD sh /etc/run.sh
