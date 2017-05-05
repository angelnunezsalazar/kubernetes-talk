FROM mhart/alpine-node:7.8.0
RUN apk add --update curl && \
    rm -rf /var/cache/apk/*
EXPOSE 8080
COPY server.js .
CMD node server.js