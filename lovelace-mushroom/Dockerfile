ARG BUILD_FROM
FROM $BUILD_FROM

RUN mkdir -p /root
WORKDIR /root

COPY ./static/* .

CMD ["cp", "./mushroom.js", "/config/www/mushroom.js"]
