[![Build Status](__badge_image__)](__badge_url__)

# SSH Key

```sh
$ ssh-keygen -t ed25519 -C "${EMAIL_ADDRESS}"
$ ssh-keygen -t rsa -b 4096 -C "${EMAIL_ADDRESS}"
$ cat ~/.ssh/id_rsa.pub
```

# GPG Key

```sh
$ gpg --full-generate-key
$ gpg --list-secret-keys --keyid-format LONG ${EMAIL_ADDRESS}
$ gpg --armor --export ${SEC_ID}
$ git config --global commit.gpgsign true
$ git config --global gpg.program gpg
$ git config --global user.email "${EMAIL_ADDRESS}"
$ git config --global user.name "${FIRST_NAME} ${LAST_NAME}"
$ git config --global user.signingkey {SEC_ID}
```

# Rustup

```sh
$ curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
$ rustup toolchain install nightly
$ rustup component add \
    cargo \
    clippy \
    llvm-tools-preview \
    rls \
    rust-analysis \
    rust-docs \
    rust-src \
    rust-std \
    rustc \
    rustfmt
$ rustup +nightly component add miri
$ rustup update && rustup self update
```

# Cargo

## Sub Commands

### Install

```sh
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

```sh
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

```sh
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

```sh
$ cargo bench -- --save-baseline before
$ cargo bench -- --save-baseline change
$ critcmp before change
```

# Help

```sh
$ cargo watch -x "run | bunyan"

$ grpcurl \
    -d '{"id":"E5D86E1D-31A4-4964-9881-F160FC5B1073"}' \
    -import-path fip_api/proto \
    -plaintext \
    -proto api_api.proto \
    127.0.0.1:8080 fip.api.api.Api/HelloWorld
```

# Husky

```sh
$ CARGO_HUSKY_DONT_INSTALL_HOOKS=true cargo test
```

# TLS

https://dev.to/anshulgoyal15/a-beginners-guide-to-grpc-with-rust-3c7o

```sh
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

```sh
$ docker run -d -p6831:6831/udp -p6832:6832/udp -p16686:16686 jaegertracing/all-in-one:1.23.0
$ docker run -d -p 9411:9411 openzipkin/zipkin:2.23.2
```

# K8S

## K8S Cluster Create

```sh
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

```sh
$ brew install helm
$ brew install kube-ps1
$ brew install kubectx
$ brew install kubernetes-cli
```

## k8s Cluster Working with UI

```sh
$ brew cask install lens
$ brew cask install kui
```

## Walk Through

```sh
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
$ 
$ kubectl -n fip-api-namespace port-forward service/fip-api 8080:8080
$ 
$ kubectl get -n fip-api-namespace deployment -o yaml | linkerd inject - | kubectl apply -f -
$ linkerd -n fip-api-namespace check --proxy
$ linkerd -n fip-api-namespace viz stat deployment
```

# Docker

```sh
$ docker pull curlimages/curl:7.78.0
$ docker pull docker:20.10.7-dind-rootless
$ docker pull gcr.io/distroless/cc:nonroot
$ docker pull jaegertracing/all-in-one:1.24.0
$ docker pull materialize/materialized:v0.8.3
$ docker pull mcr.microsoft.com/vscode/devcontainers/rust:0.200.7-1
$ docker pull openzipkin/zipkin:2.23.2
$ docker pull registry:2.7.1
$ docker pull rust:1.54.0-buster
$ docker pull rustembedded/cross:x86_64-unknown-linux-musl-0.2.1
$ docker pull timberio/vector:0.15.1-distroless-static
$ docker pull vectorized/redpanda:v21.7.6
```

# Docker Content Trust

```sh
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

# Note

Created => 1970-01-01T00:00:00Z
"Metadata": {
    "LastTagTime": "0001-01-01T00:00:00Z"
}

# Extra

```sh
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

# Build
```sh
# 1st WAY
$ make release PACKAGE="fip_api" RELEASE="--release" TARGET="x86_64-unknown-linux-musl" VERSION="$(git describe --tags --abbrev=0)" -- RUSTFLAGS="-Clinker=lld"

# 2nd WAY
$ make release CARGO="cross" PACKAGE="fip_api" RELEASE="--release" TARGET="x86_64-unknown-linux-musl" VERSION="$(git describe --tags --abbrev=0)"

# 3rd WAY
$ docker run -it -v /var/run/docker.sock:/var/run/docker.sock -v $(pwd):/k8s_api_gateway_proxy_mesh_test --rm test sh
$ make release CARGO="cross" PACKAGE="fip_api" RELEASE="--release" TARGET="x86_64-unknown-linux-musl" VERSION="0.1.0"
```

# WHICH CRATE ?

CARGO_INCREMENTAL=0
RUSTDOCFLAGS="-Cpanic=abort"
RUSTFLAGS="-Zprofile -Ccodegen-units=1 -Copt-level=0 -Clink-dead-code -Coverflow-checks=off -Zpanic_abort_tests -Cpanic=abort"
RUST_BACKTRACE=FULL
RUST_LIB_BACKTRACE=FULL
RUST_LOG=INFO
RUST_LOG_STYLE=NEVER

# Scripts
```sh
$ GIT_COMMITTER_DATE=$(git log -n1 --pretty=%aD) git tag -a -m "Release 0.1.0" 0.1.0
$ git push --tags
$
$ rustc --print target-list
$ rustc --target ${TRIPLE} --print target-cpus
$ rustc --target ${TRIPLE} --print target-features
$
$ perf record --call-graph=dwarf ./target/release/fip_api
$ perf report --hierarchy -M intel
$
$ RUSTFLAGS="-Ctarget-cpu=native" cargo build --release
```