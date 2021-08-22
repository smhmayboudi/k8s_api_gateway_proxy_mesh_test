[![Build Status](__badge_image__)](__badge_url__)

[![coverage](https://shields.io/endpoint?url=https://sample.github.io/awesome/coverage.json)](https://sample.github.io/awesome/index.html)

[![coverage](https://sample.github.io/awesome/badges/flat.svg)](https://sample.github.io/awesome/index.html)

# SSH Key

```shell
$ ssh-keygen -t ed25519 -C "${EMAIL_ADDRESS}"
$ ssh-keygen -t rsa -b 4096 -C "${EMAIL_ADDRESS}"
$ cat ~/.ssh/id_rsa.pub
```

# GPG Key

```shell
$ gpg --full-generate-key
$ gpg --list-secret-keys --keyid-format LONG ${EMAIL_ADDRESS}
$ gpg --armor --export ${SEC_ID}
$ git config --global commit.gpgsign true
$ git config --global gpg.program gpg
$ git config --global user.email "${EMAIL_ADDRESS}"
$ git config --global user.name "${FIRST_NAME} ${LAST_NAME}"
$ git config --global user.signingkey ${SEC_ID}
```

# Git Config

```shell
$ git config --global branch.autoSetupRebase always
$ git config --global color.branch true
$ git config --global color.diff true
$ git config --global color.interactive true
$ git config --global color.status true
$ git config --global color.ui true
$ git config --global commit.gpgSign true
$ git config --global core.editor "code -w"
$ git config --global difftool.code.cmd "code --wait --diff $LOCAL $REMOTE"
$ git config --global gpg.program gpg
$ git config --global init.defaultBranch main
$ git config --global log.date relative
$ git config --global pull.default current
$ git config --global pull.rebase true
$ git config --global push.default current
$ git config --global rebase.autoStash true
$ git config --global rerere.enabled true
$ git config --global stash.showPatch true
```

# Rustup

```shell
$ curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
$ rustup toolchain install nightly
$ rustup +nightly component add \
    cargo \
    clippy \
    llvm-tools-preview \
    miri \
    rls \
    rust-analysis \
    rust-analyzer-preview \
    rust-docs \
    rust-src \
    rust-std \
    rustc \
    rustc-dev \
    rustfmt
$ rustup self update && \
  rustup update && \
  rustup update nightly
```

# Cargo

## Sub Commands

### Install

```shell
$ cargo install --locked \
    cargo-audit \
    cargo-cache \
    cargo-deny \
    cargo-diet \
    cargo-edit \
    cargo-expand \
    cargo-inspect \
    cargo-make \
    cargo-modules \
    cargo-outdated \
    cargo-readme \
    cargo-spellcheck \
    cargo-watch
```

### Run

```shell
$ cargo bench
$ cargo cache --autoclean
$ cargo check
$ cargo doc
$ cargo fix
$ cargo inspect
$ cargo package
$ cargo publish
$ cargo readme > README.md
$ cargo run
$ cargo rustc
$ cargo spellcheck check
$ cargo spellcheck fix
$ cargo test
$ cargo update
$ cargo upgrade --workspace
$ cargo vendor
```

## Tools

```shell
$ cargo install --locked \
    bunyan \
    critcmp \
    flamegraph \
    grcov \
    mdbook \
    ripgrep \
    rustscan \
    sqlx-cli
```

```shell
$ cargo bench -- --save-baseline before
$ cargo bench -- --save-baseline change
$ critcmp before change
```

# Help

```shell
$ cargo watch -x "run | bunyan"

$ grpcurl \
    -d '{"id":"E5D86E1D-31A4-4964-9881-F160FC5B1073"}' \
    -import-path fip_api/proto \
    -plaintext \
    -proto api_api.proto \
    127.0.0.1:8080 fip.api.api.Api/HelloWorld
```

# Husky

```shell
$ CARGO_HUSKY_DONT_INSTALL_HOOKS=true cargo test
```

# TLS

https://dev.to/anshulgoyal15/a-beginners-guide-to-grpc-with-rust-3c7o

```shell
$ openssl genrsa -des3 -out my_ca.key 2048
$ openssl req -x509 -new -nodes -key my_ca.key -sha256 -days 1825 -out my_ca.pem
$ openssL genrsa -out server.key 2048
$ openssl req -new -sha256 -key server.key -out server.csr
# authorityKeyIdentifier=keyid,issuer
# basicConstraints=CA:FALSE
# keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
# subjectAltName = @alt_names
# 
# [alt_names]
# DNS.1 = localhost
$ openssl x509 -req -in server.csr -CA my_ca.pem -CAkey my_ca.key -CAcreateserial -out server.pem -days 1825 -sha256 -extfile server.ext
```

# Jaeger Tracing

```shell
$ docker run -d -p6831:6831/udp -p6832:6832/udp -p16686:16686 jaegertracing/all-in-one:1.23.0
$ docker run -d -p 9411:9411 openzipkin/zipkin:2.23.2
```

# K8S

## K8S Cluster Create

```shell
# 1st WAY
$ brew install kind
$ ./kind-with-registry.sh

# 2nd WAY
$ Docker for Desktop

# 3rd WAY
$ brew install ubuntu/microk8s/microk8s
$ microk8s install

# 4th WAY
$ brew cask install virtualbox
$ brew install minikube
$ minikube start

# 5th WAY
$ brew install k3d
```

## K8S Cluster Working

```shell
$ brew install helm
$ brew install kube-ps1
$ brew install kubectx
$ brew install kubernetes-cli
```

## k8s Cluster Working with UI

```shell
$ brew cask install lens
$ brew cask install kui
```

## Walk Through

```shell
$ brew install linkerd
$ curl https://kind.sigs.k8s.io/examples/kind-with-registry.sh > ./script/kind-with-registry.sh
$ chmod 777 ./script/kind-with-registry.sh
$ ./script/kind-with-registry.sh
 
# [https://linkerd.io/2.10/getting-started/]
$ kubectl version --short
$ curl -sL https://run.linkerd.io/install | sh [BY PASS IF YOU USED BREW]
$ linkerd version
$ linkerd check --pre
$ linkerd install | kubectl apply -f -
$ linkerd check
$ linkerd viz install | kubectl apply -f -

## optional
$ linkerd jaeger install | kubectl apply -f -
$ linkerd multicluster install | kubectl apply -f -
$ linkerd check
$ linkerd viz dashboard &
$ linkerd -n linkerd-viz viz top deployment/web [ERROR]

$ docker build . -f ./fip_api/Dockerfile -t fip-api:0.1.0-nonroot
$ docker tag fip-api:0.1.0-nonroot localhost:5000/fip-api:0.1.0-nonroot
$ docker push localhost:5000/fip-api:0.1.0-nonroot
$ cat ./fip_api/fip-api.yml | kubectl apply -f -

$ kubectl -n fip-api-namespace port-forward service/fip-api 8080:8080

$ kubectl get -n fip-api-namespace deployment -o yaml | linkerd inject - | kubectl apply -f -
$ linkerd -n fip-api-namespace check --proxy
$ linkerd -n fip-api-namespace viz stat deployment
```

# Docker

```shell
$ docker pull curlimages/curl:7.78.0
$ docker pull gcr.io/distroless/cc:nonroot
$ docker pull jaegertracing/all-in-one:1.25.0
$ docker pull materialize/materialized:v0.8.3
$ docker pull mcr.microsoft.com/vscode/devcontainers/rust:0.200.7-1
$ docker pull openzipkin/zipkin:2.23.2
$ docker pull registry:2.7.1
$ docker pull rust:1.54.0-buster
$ docker pull rustembedded/cross:aarch64-unknown-linux-musl-0.2.1 && \
$ docker pull rustembedded/cross:armv7-unknown-linux-musleabihf-0.2.1 && \
$ docker pull rustembedded/cross:x86_64-unknown-linux-musl-0.2.1 && \
$ docker pull timberio/vector:0.15.1-distroless-static
$ docker pull vectorized/redpanda:v21.7.6
```

# Docker Content Trust

```shell
$ docker trust key generate {NAME}

# LOAD
$ docker trust key load {NAME}.pem --name {NAME}

$ docker trust signer add --key {NAME}.pem {NAME} localhost:5000/fip-api
$ docker trust sign localhost:5000/fip-api:0.1.0-nonroot
$ export DOCKER_CONTENT_TRUST=1
$ docker push localhost:5000/fip-api:0.1.0-nonroot

# TEST
$ docker trust inspect --pretty localhost:5000/fip-api:0.1.0-nonroot

# REMOVE
$ docker trust revoke localhost:5000/fip-api:0.1.0-nonroot
```

# Extra

```shell
$ rustup target add \
    aarch64-unknown-linux-musl \
    armv7-unknown-linux-musleabihf \
    x86_64-unknown-linux-musl
$ cargo build --package fip_api --release --target x86_64-unknown-linux-musl

$ docker build . -f ./fip_api/Dockerfile -t fip-api:0.1.0-nonroot
$ docker run -e LINKERD_AWAIT_DISABLED=TRUE -i -p 8080:8080 --rm fip-api:0.1.0-nonroot

$ shasum -a 256 target/release/fip_api

$ brew install upx
$ upx --ultra-brute ./target/x86_64-unknown-linux-musl/release/fip_api
```

# Cross Build

```shell
# 1st WAY
$ make release CARGO="cross" PACKAGE="fip_api" RELEASE="--release" STRIP="strip" TARGET="x86_64-unknown-linux-musl" VERSION="$(git describe --tags --abbrev=0)"

# 2nd WAY
$ docker build . -t rust-build:1.54.0-buster
$ docker run -v $(pwd):/project -v /var/run/docker.sock:/var/run/docker.sock -w /project --rm rust-build:1.54.0-buster make release CARGO="cross" PACKAGE="fip_api" RELEASE="--release" STRIP="strip" TARGET="x86_64-unknown-linux-musl" VERSION="$(git describe --tags --abbrev=0)"
```

# Scripts

```shell
$ GIT_COMMITTER_DATE=$(git log -n1 --pretty=%aD) git tag -a -m "Release 0.1.0" 0.1.0
$ git push --tags

$ rustc --print target-list
$ rustc --target ${TRIPLE} --print target-cpus
$ rustc --target ${TRIPLE} --print target-features

$ perf record --call-graph=dwarf ./target/release/fip_api
$ perf report --hierarchy -M intel

$ RUSTFLAGS="-C target-cpu=native" cargo build --release
```

# Test

```shell
$ export CARGO_INCREMENTAL=0
$ export RUSTDOCFLAGS="-Cpanic=abort"
$ export RUSTFLAGS="-Zprofile -Ccodegen-units=1 -Copt-level=0 -Clink-dead-code -Coverflow-checks=off -Zpanic_abort_tests -Cpanic=abort"
```
