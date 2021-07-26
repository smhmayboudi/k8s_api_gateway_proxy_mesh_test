# ARCH
# CARGO
# CARGO_RELEASE
# CARGO_TARGET
# OS
# PACKAGE_VERSION
# RUSTUP
# STRIP

RUSTUP ?= rustup
CARGO_TARGET ?= $(shell $(RUSTUP) show |sed -n 's/^Default host: \(.*\)/\1/p')
TARGET_DIR = target/$(CARGO_TARGET)/debug
ifdef CARGO_RELEASE
	RELEASE = --release
	TARGET_DIR = target/$(CARGO_TARGET)/release
endif
TARGET_BIN = $(TARGET_DIR)/linkerd-await

ARCH ?= x86_64
OS ?= macos
PACKAGE_VERSION ?= latest
STRIP ?= strip

PKG_ROOT = $(TARGET)/package
PKG_NAME = linkerd-await-$(PACKAGE_VERSION)-$(ARCH)
PKG_BASE = $(PKG_ROOT)/$(PKG_NAME)

SHASUM = shasum -a 256

CARGO ?= cargo
CARGO_AUDIT = $(CARGO) audit --target-arch $(ARCH) --target-os $(OS)
CARGO_BUILD = $(CARGO) build --all-features --frozen --no-default-features --target=$(CARGO_TARGET) $(RELEASE)
CARGO_CHECK = $(CARGO) check --all-features --frozen --no-default-features --target=$(CARGO_TARGET) $(RELEASE) --workspace
CARGO_CLIPPY = $(CARGO) clippy --all-features --all-targets -- -D warnings
CARGO_FMT = $(CARGO) fmt --all
CARGO_TEST = $(CARGO) test --all-features --frozen --no-default-features --target=$(CARGO_TARGET) $(RELEASE) --workspace

.PHONY: add-audit
add-audit:
	$(CARGO) install cargo-audit

.PHONY: add-clippy
add-clippy:
	$(RUSTUP) component add clippy

.PHONY: add-fmt
add-fmt:
	$(RUSTUP) component add rustfmt

.PHONY: all
all: fmt-check check

.PHONY: audit
audit:
	$(CARGO) audit

.PHONY: build
build: $(TARGET_BIN)

.PHONY: check
check: configure-target fetch
	$(CARGO_CHECK)

.PHONY: clean
clean:
	$(CARGO) clean --target-dir $(TARGET_DIR)

.PHONY: clippy
clippy: add-clippy
	$(CARGO_CLIPPY)

.PHONY: configure-target
configure-target:
	$(RUSTUP) target add $(CARGO_TARGET)

.PHONY: fetch
fetch: Cargo.lock
	$(CARGO) fetch --locked
$(TARGET_BIN): fetch configure-target
	$(CARGO_BUILD)

.PHONY: fmt
fmt: add-fmt
	$(CARGO_FMT)

.PHONY: fmt-check
fmt-check: add-fmt
	$(CARGO_FMT) -- --check

.PHONY: test
test: 
	$(CARGO_TEST)

.PHONY: release
release: $(TARGET_BIN)
	@mkdir -p release
	cp $(TARGET_BIN) release/$(PKG_NAME)
	$(STRIP) release/$(PKG_NAME)
	$(SHASUM) release/$(PKG_NAME) > release/$(PKG_NAME).shasum
