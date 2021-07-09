# RUSTUP

```bash
$ curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# از حالت پیش فرض نصب استفاده نمایید بخاطر اینکه یکسریی از کامپوننت ها در ورژن های راست موجود نیست.

$ rustup show

$ rustup update &&\
  rustup self update &&\
  rustup update nightly

$ rustup default

$ rustup toolchain list
$ rustup toolchain install nightly

$ rustup target list
$ rustup target add x86_64-apple-darwin

$ rustup component list
$ rustup component add \
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
    rustc-docs \
    rustfmt

$ rustup doc
$ rustup man
```

# CREATE

```bash
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

$ cargo install --list
# $ cargo install \
#     cargo-audit \
#     cargo-benchcmp \
#     cargo-expand \
#     cargo-readme \
#     cargo-watch \
#     flamegraph \
#     grcov

$ cargo uninstall

$ cargo new
$ cargo package
$ cargo run
$ cargo search
$ cargo test
$ cargo tree
$ cargo update
$ cargo vendor

# $ cargo audit
# $ cargo benchcmp
# $ cargo clippy
# $ cargo expand
# $ cargo fmt
# $ cargo miri
# $ cargo readme
# $ cargo watch
```

# PROJECT

```bash
$ cargo new --bin rust_bin_test
$ cargo new --lib rust_lib_test

$ cargo doc --open
```
