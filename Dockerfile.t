ARG BASE_IMAGE=rust:1.53.0-buster

FROM $BASE_IMAGE
WORKDIR /linkerd
RUN apt-get update && \
    apt-get install -y \
        docker.io \
        gcc-aarch64-linux-gnu \
        gcc-arm-linux-gnueabihf \
        gcc-x86-64-linux-gnu \
        jq \
        musl-tools \
        && \
    apt-get clean && \
    rm -rf \
        /var/lib/apt/lists/* \
        /tmp/* \
        /var/tmp/
RUN cargo install cross
