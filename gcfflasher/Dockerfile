ARG BUILD_FROM
FROM $BUILD_FROM

RUN install_packages pkg-config build-essential libgpiod-dev git

RUN mkdir -p /app
WORKDIR /app

RUN git clone --depth 1 https://github.com/dresden-elektronik/gcfflasher.git
RUN cd ./gcfflasher && ./build_posix.sh

WORKDIR /app
COPY ./firmwares .

CMD ["./gcfflasher/GCFFlasher", "-f", "deCONZ_ConBeeII_0x26780700.bin.GCF", "-d", "/dev/ttyACM0"]
