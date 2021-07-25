# SSH Key

```bash
$ ssh-keygen -t ed25519 -C "${EMAIL_ADDRESS}"
$ ssh-keygen -t rsa -b 4096 -C "${EMAIL_ADDRESS}"
$ cat ~/.ssh/id_rsa.pub
```

# GPG Key

```bash
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

```bash
$ curl https://sh.rustup.rs -sSf | sh -s
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

```bash
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

```bash
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

```bash
$ cargo install --locked \
    critcmp \
    flamegraph \
    grcov \
    mdbook \
    ripgrep \
    rustscan \
    sqlx-cli
```

```bash
$ cargo bench -- --save-baseline before
$ cargo bench -- --save-baseline change
$ critcmp before change
```

# Help

```bash
$ cargo watch -x "run | bunyan"

$ grpcurl \
    -d '{"id":"E5D86E1D-31A4-4964-9881-F160FC5B1073"}' \
    -import-path fip_api/proto \
    -plaintext \
    -proto api_api.proto \
    127.0.0.1:8080 fip.api.api.Api/HelloWorld
```

# Husky

```bash
$ CARGO_HUSKY_DONT_INSTALL_HOOKS=true cargo test
```

# TLS

https://dev.to/anshulgoyal15/a-beginners-guide-to-grpc-with-rust-3c7o

```bash
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

```bash
$ docker run -d -p6831:6831/udp -p6832:6832/udp -p16686:16686 jaegertracing/all-in-one:1.23.0
$ docker run -d -p 9411:9411 openzipkin/zipkin:2.23.2
```

# K8S

## K8S Cluster Create

```bash
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

```bash
$ brew install helm
$ brew install kube-ps1
$ brew install kubectx
$ brew install kubernetes-cli
```

## k8s Cluster Working with UI

```bash
$ brew cask install lens
$ brew cask install kui
```

## Walk Through

```bash
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

$ docker build . -f ./fip_api/Dockerfile -t fip-api-service:0.1.0-nonroot
$ docker tag fip-api-service:0.1.0-nonroot localhost:5000/fip-api-service:0.1.0-nonroot
$ docker push localhost:5000/fip-api-service:0.1.0-nonroot
$ cat ./fip_api/fip-api-service.yml | kubectl apply -f -
$ 
$ kubectl -n fip-api-namespace port-forward service/fip-api-service 8080:8080
$ 
$ kubectl get -n fip-api-namespace deployment -o yaml | linkerd inject - | kubectl apply -f -
$ linkerd -n fip-api-namespace check --proxy
$ linkerd -n fip-api-namespace viz stat deployment
```

# Docker

```bash
$ docker pull debian:stable-slim
$ docker pull jaegertracing/all-in-one:1.23.0
$ docker pull materialize/materialized:v0.8.0
$ docker pull registry:2.7.1
$ docker pull rust:1.53.0
$ docker pull timberio/vector:0.14.X-distroless-static
$ docker pull vectorized/redpanda:v21.6.2
```

# Docker Content Trust

```bash
$ docker trust key generate {NAME}

# LOAD
$ docker trust key load {NAME}.pem --name {NAME}

$ docker trust signer add --key {NAME}.pem {NAME} localhost:5000/fip-api-service
$ docker trust sign localhost:5000/fip-api-service:0.1.0-nonroot
$ export DOCKER_CONTENT_TRUST=1
$ docker push localhost:5000/fip-api-service:0.1.0-nonroot

# TEST
$ docker trust inspect --pretty localhost:5000/fip-api-service:0.1.0-nonroot

# REMOVE
$ docker trust revoke localhost:5000/fip-api-service:0.1.0-nonroot
```

# Note

Created => 1970-01-01T00:00:00Z
"Metadata": {
    "LastTagTime": "0001-01-01T00:00:00Z"
}

# Extra

```bash
$ rustup target add \
    aarch64-unknown-linux-musl \
    armv7-unknown-linux-musleabihf \
    x86_64-unknown-linux-musl
$ cargo build --package fip_api --release --target=x86_64-unknown-linux-musl

$ docker build . -f ./fip_api/Dockerfile -t fip-api-service:0.1.0-nonroot
$ docker run -e LINKERD_AWAIT_DISABLED=TRUE -i -p 8080:8080 --rm fip-api-service:0.1.0-nonroot

$ shasum -a 256 target/release/fip_api

$ brew install upx
$ upx --ultra-brute ./target/x86_64-unknown-linux-musl/release/fip_api
```

# WHICH CRATE ?

CARGO_INCREMENTAL=0
RUSTDOCFLAGS="-Cpanic=abort"
RUSTFLAGS="-Zprofile -Ccodegen-units=1 -Copt-level=0 -Clink-dead-code -Coverflow-checks=off -Zpanic_abort_tests -Cpanic=abort"
RUST_BACKTRACE=FULL
RUST_LIB_BACKTRACE=FULL
RUST_LOG=INFO
RUST_LOG_STYLE=NEVER

# Tag the current commit
GIT_COMMITTER_DATE=$(git log -n1 --pretty=%aD) git tag -a -m "Release 0.3.0" 0.3.0
git push --tags

rustc --print target-list
rustc --target=${TRIPLE} --print target-cpus
rustc --target=${TRIPLE} --print target-features

perf record --call-graph=dwarf ./target/release/fpi_api
perf report --hierarchy -M intel

$ RUSTFLAGS="-C target-cpu=native" cargo build --release
