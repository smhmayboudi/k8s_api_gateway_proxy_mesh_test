# ARCH
# BIN
# CARGO
# CARGO_RELEASE
# CARGO_TARGET
# OS
# PACKAGE_VERSION
# RUSTUP
# STRIP

BIN ?= fip_api
RUSTUP ?= rustup
CARGO_TARGET ?= $(shell $(RUSTUP) show |sed -n 's/^Default host: \(.*\)/\1/p')
TARGET_DIR = target/$(CARGO_TARGET)/debug
ifdef CARGO_RELEASE
	RELEASE = --release
	TARGET_DIR = target/$(CARGO_TARGET)/release
endif
TARGET_BIN = $(TARGET_DIR)/$(BIN)

ARCH ?= x86_64
OS ?= macos
PACKAGE_VERSION ?= latest
STRIP ?= strip

PACKAGE_ROOT = $(TARGET)/package
PACKAGE_NAME = $(BIN)-$(PACKAGE_VERSION)-$(ARCH)
PACKAGE_BASE = $(PACKAGE_ROOT)/$(PACKAGE_NAME)

SHASUM = shasum -a 256

CARGO ?= cargo
CARGO_AUDIT = $(CARGO) audit --target-arch $(ARCH) --target-os $(OS)
CARGO_BUILD = $(CARGO) build --all-features --frozen --no-default-features $(RELEASE) --target=$(CARGO_TARGET)
CARGO_CHECK = $(CARGO) check --all-features --frozen --no-default-features $(RELEASE) --target=$(CARGO_TARGET) --workspace
CARGO_CLIPPY = $(CARGO) clippy --all-features --all-targets -- -D warnings
CARGO_FMT = $(CARGO) fmt --all
CARGO_TEST = $(CARGO) test --all-features --frozen --no-default-features --target=$(CARGO_TARGET) $(RELEASE) --workspace
CARGO_VENDOR = $(CARGO) vendor

$(TARGET_BIN): add-fmt add-target fetch
	$(CARGO_BUILD)

.PHONY: add-audit
add-audit:
	$(CARGO) install cargo-audit

.PHONY: add-clippy
add-clippy:
	$(RUSTUP) component add clippy

.PHONY: add-fmt
add-fmt:
	$(RUSTUP) component add rustfmt

.PHONY: add-target
add-target:
	$(RUSTUP) target add $(CARGO_TARGET)

.PHONY: all
all: fmt-check check

.PHONY: audit
audit:
	$(CARGO) audit

.PHONY: build
build: $(TARGET_BIN)

.PHONY: check
check: add-target fetch
	$(CARGO_CHECK)

.PHONY: clean
clean:
	$(CARGO) clean --target-dir $(TARGET_DIR)

.PHONY: clippy
clippy: add-clippy
	$(CARGO_CLIPPY)

.PHONY: fetch
fetch: Cargo.lock
	$(CARGO) fetch --locked

.PHONY: fmt
fmt: add-fmt
	$(CARGO_FMT)

.PHONY: fmt-check
fmt-check: add-fmt
	$(CARGO_FMT) -- --check

.PHONY: release
release: $(TARGET_BIN)
	@mkdir -p release
	cp $(TARGET_BIN) release/$(PACKAGE_NAME)
	$(STRIP) release/$(PACKAGE_NAME)
	$(SHASUM) release/$(PACKAGE_NAME) > release/$(PACKAGE_NAME).shasum

.PHONY: test
test: 
	$(CARGO_TEST)

.PHONY: vendor
vendor: 
	$(CARGO_VENDOR)
