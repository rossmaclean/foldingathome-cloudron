FROM cloudron/base:3.0.0@sha256:455c70428723e3a823198c57472785437eb6eab082e79b3ff04ea584faf46e92

WORKDIR /app/code

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -y && \
    apt-get install -y expect && \
    rm -r /var/cache/apt /var/lib/apt/lists

ARG FAH_MAJOR_VERSION=7.6
ARG FAH_MINOR_VERSION=21
ARG FAH_VERSION=${FAH_MAJOR_VERSION}.${FAH_MINOR_VERSION}
ARG FAH_INSTALL_FILE="fahclient_${FAH_MAJOR_VERSION}.${FAH_MINOR_VERSION}_amd64.deb"
ARG MONGO_INSTALL_DIR=/app/code/mongo
RUN wget "https://download.foldingathome.org/releases/public/release/fahclient/debian-stable-64bit/v${FAH_MAJOR_VERSION}/${FAH_INSTALL_FILE}"

ADD install-fah-with-expect .
RUN expect install-fah-with-expect

ARG DATA_DIR=/app/data
ARG CODE_DIR=/app/code

COPY start.sh ${CODE_DIR}/
COPY config.xml ${DATA_DIR}/

RUN chown -R cloudron:cloudron ${DATA_DIR}

CMD [ "/app/code/start.sh", "${DATA_DIR}/config.xml"]