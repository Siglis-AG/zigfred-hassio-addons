ARG BUILD_FROM
FROM $BUILD_FROM

RUN mkdir -p /static
WORKDIR /static

COPY ./static/* .

CMD ["cp", "./mushroom.js", "/config/www/mushroom.js"]
