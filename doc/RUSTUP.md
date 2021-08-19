# RUSTUP

## RUSTUP

```sh
$ curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

$ rustup show

$ rustup self update && \
  rustup update && \
  rustup update nightly

$ rustup default

$ rustup toolchain list
$ rustup toolchain install nightly

$ rustup target list
$ rustup target add aarch64-apple-darwin

$ rustup component list
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

$ rustup doc
$ rustup man
```

## CREATE

```sh
$ cargo --list
$ cargo -Z help

$ cargo bench
$ cargo build --release
$ cargo check
$ cargo clean
$ cargo doc
$ cargo fetch
$ cargo fix
$ cargo generate-lockfile
$ cargo init

$ cargo new
$ cargo package
$ cargo run
$ cargo search
$ cargo test
$ cargo tree
$ cargo update
$ cargo vendor

$ cargo clippy
$ cargo fmt
$ cargo miri

$ cargo install --list
$ cargo install --locked \
    cargo-audit \
    cargo-deny \
    grcov
$ cargo uninstall

$ cargo audit
$ cargo deny
$ cargo grcov
```

## PROJECT

```sh
$ cargo new --bin rust_bin_test
$ cargo new --lib rust_lib_test

$ cargo doc --open
```
