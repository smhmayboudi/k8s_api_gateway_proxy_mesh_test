ARG BASE_IMAGE=rust:1.53.0-buster
FROM $BASE_IMAGE
WORKDIR /fip
RUN apt-get update && \
    apt-get install -y \
        binutils-aarch64-linux-gnu \
        binutils-arm-linux-gnueabihf \
        binutils-x86-64-linux-gnu \
        docker.io \
        jq \
        musl-tools \
        && \
    apt-get clean && \
    rm -rf \
        /var/lib/apt/lists/* \
        /tmp/* \
        /var/tmp/
RUN cargo install cross
