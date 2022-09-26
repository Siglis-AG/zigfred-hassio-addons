ARG BUILD_FROM
FROM $BUILD_FROM

RUN adduser -D static
USER static
WORKDIR /home/static

COPY ./static/* .

CMD ["cp", "./mushroom.js", "/config/www/mushroom.js"]
