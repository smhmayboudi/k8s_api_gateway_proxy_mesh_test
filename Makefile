.DEFAULT_GOAL := help

# ARCH
# CARGO
# OS
# PACKAGE
# RELEASE
# STRIP
# TARGET
# VERSION

ARCH ?= x86_64 # aarch64, arm, asmjs, mips, mips64, msp430, nvptx64, powerpc, powerpc64, riscv, s390x, sparc, sparc64, thumbv6, thumbv7, wasm32, x86, x86_64, unknown
CARGO ?= cargo
OS ?= macos # android, cuda, dragonfly, emscripten, freebsd, fuchsia, haiku, hermit, illumos, ios, linux, macos, netbsd, openbsd, redox, solaris, tvos, wasi, windows, vxworks, unknown
PACKAGE ?= fip_api
# RELEASE ?= --release
STRIP ?= strip # strip, aarch64-linux-gnu-strip, arm-linux-gnueabihf-strip
TARGET ?= $(shell rustup show | sed -n 's/^Default host: \(.*\)/\1/p')
VERSION ?= v0.1.0

TARGET_DIR = target/$(TARGET)/debug
ifdef RELEASE
	RELEASE = --release
	TARGET_DIR = target/$(TARGET)/release
endif
BIN = $(TARGET_DIR)/$(PACKAGE)

# PACKAGE_ROOT = $(__TARGET__)/package
BIN_NAME = $(PACKAGE)-$(VERSION)-$(TARGET)
# PACKAGE_BASE = $(PACKAGE_ROOT)/$(BIN_NAME)

CARGO_BENCH = $(CARGO) bench --all-features --frozen --no-default-features --package $(PACKAGE) --target $(TARGET) #--target-dir $(TARGET_DIR)
CARGO_BUILD = $(CARGO) build --all-features --frozen --no-default-features --package $(PACKAGE) $(RELEASE) --target $(TARGET) #--target-dir $(TARGET_DIR)
CARGO_CHECK = $(CARGO) check --all-features --frozen --no-default-features --package $(PACKAGE) $(RELEASE) --target $(TARGET) #--target-dir $(TARGET_DIR)
CARGO_CLEAN = $(CARGO) clean --frozen --package $(PACKAGE) $(RELEASE) --target $(TARGET) #--target-dir $(TARGET_DIR)
CARGO_DOC = $(CARGO) doc --all-features --document-private-items --frozen --no-default-features --package $(PACKAGE) $(RELEASE) --target $(TARGET) #--target-dir $(TARGET_DIR)
CARGO_FETCH = $(CARGO) fetch --locked --target $(TARGET)
CARGO_FIX = $(CARGO) fix --all-features --frozen --no-default-features --package $(PACKAGE) $(RELEASE) --target $(TARGET) #--target-dir $(TARGET_DIR)
CARGO_RUN = $(CARGO) run --all-features --frozen --no-default-features --package $(PACKAGE) $(RELEASE) --target $(TARGET) #--target-dir $(TARGET_DIR)
CARGO_TEST = $(CARGO) test --all-features --frozen --no-default-features --package $(PACKAGE) $(RELEASE) --target $(TARGET) #--target-dir $(TARGET_DIR)

CARGO_AUDIT = $(CARGO) audit --target-arch $(ARCH) --target-os $(OS)
CARGO_CLIPPY = $(CARGO) clippy --all-features --frozen --no-default-features --package $(PACKAGE) $(RELEASE) --target $(TARGET) -- -D warnings #--target-dir $(TARGET_DIR)
CARGO_DENY = $(CARGO) deny --all-features --no-default-features --target $(TARGET) --workspace
CARGO_FMT = $(CARGO) fmt --package $(PACKAGE)

$(BIN): add-fmt add-target fetch
	$(CARGO_BUILD)

.PHONY: add-audit
add-audit: ## Add the audit
	$(CARGO) install cargo-audit

.PHONY: add-clippy
add-clippy: ## Add the clippy
	rustup component add clippy

.PHONY: add-deny
add-deny: ## Add the deny
	$(CARGO) install cargo-deny

.PHONY: add-fmt
add-fmt: ## Add the fmt
	rustup component add rustfmt

.PHONY: add-target
add-target: ## Add a target
	rustup target add $(TARGET)

.PHONY: help
help: ## Help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: audit
audit: add-audit ## Audit
	$(CARGO_AUDIT)

.PHONY: bench
bench: add-fmt add-target fetch ## Bench
	$(CARGO_BENCH)

.PHONY: build
build: $(BIN) ## Build

.PHONY: check
check: add-fmt add-target fetch ## Check
	$(CARGO_CHECK)

.PHONY: clean
clean: add-target ## Clean
	$(CARGO_CLEAN)

.PHONY: clean-doc
clean-doc: add-target ## Clean doc
	$(CARGO_CLEAN) --doc

.PHONY: clippy
clippy: add-clippy add-fmt fetch  ## Clippy
	$(CARGO_CLIPPY)

.PHONY: deny-check
deny-check: add-deny fetch ## Deny check
	$(CARGO_DENY) check

.PHONY: deny-fetch
deny-fetch: add-deny fetch ## Deny fetch
	$(CARGO_DENY) fetch

.PHONY: deny-fix
deny-fix: add-deny fetch ## Deny fix
	$(CARGO_DENY) fix

.PHONY: doc
doc: add-fmt add-target fetch ## Doc
	$(CARGO_DOC)

.PHONY: fetch
fetch: Cargo.lock ## Fetch
	$(CARGO_FETCH)

.PHONY: fix
fix: ## Fix
	$(CARGO_FIX)

.PHONY: run
run: ## Run
	$(CARGO_RUN)

.PHONY: fmt
fmt: add-fmt ## FMT
	$(CARGO_FMT)

.PHONY: fmt-check
fmt-check: add-fmt ## FMT check
	$(CARGO_FMT) -- --check

.PHONY: release
release: $(BIN) ## Release
	@mkdir -p release
	cp $(BIN) release/$(BIN_NAME)
	$(STRIP) release/$(BIN_NAME)
	shasum -a 256 release/$(BIN_NAME) | cut -d " " -f 1  > release/$(BIN_NAME).sha256

.PHONY: test
test: add-fmt add-target fetch ## Test
	$(CARGO_TEST)



# CARGO_RUSTC = $(CARGO) rustc --all-features --frozen --no-default-features --package $(PACKAGE) $(RELEASE) --target $(TARGET) #--target-dir $(TARGET_DIR)

# Usage: rustc [OPTIONS] INPUT
#
# Options:
#     -h, --help          Display this message
#         --cfg SPEC      Configure the compilation environment
#     -L [KIND=]PATH      Add a directory to the library search path. The
#                         optional KIND can be one of dependency, crate, native,
#                         framework, or all (the default).
#     -l [KIND=]NAME      Link the generated crate(s) to the specified native
#                         library NAME. The optional KIND can be one of
#                         static, framework, or dylib (the default).
#         --crate-type [bin|lib|rlib|dylib|cdylib|staticlib|proc-macro]
#                         Comma separated list of types of crates
#                         for the compiler to emit
#         --crate-name NAME
#                         Specify the name of the crate being built
#         --edition 2015|2018|2021
#                         Specify which edition of the compiler to use when
#                         compiling code.
#         --emit [asm|llvm-bc|llvm-ir|obj|metadata|link|dep-info|mir]
#                         Comma separated list of types of output for the
#                         compiler to emit
#         --print [crate-name|file-names|sysroot|target-libdir|cfg|target-list|target-cpus|target-features|relocation-models|code-models|tls-models|target-spec-json|native-static-libs]
#                         Compiler information to print on stdout
#     -g                  Equivalent to -C debuginfo=2
#     -O                  Equivalent to -C opt-level=2
#     -o FILENAME         Write output to <filename>
#         --out-dir DIR   Write output to compiler-chosen filename in <dir>
#         --explain OPT   Provide a detailed explanation of an error message
#         --test          Build a test harness
#         --target TARGET Target triple for which the code is compiled
#     -W, --warn OPT      Set lint warnings
#     -A, --allow OPT     Set lint allowed
#     -D, --deny OPT      Set lint denied
#     -F, --forbid OPT    Set lint forbidden
#         --cap-lints LEVEL
#                         Set the most restrictive lint level. More restrictive
#                         lints are capped at this level
#     -C, --codegen OPT[=VALUE]
#                         Set a codegen option
#     -V, --version       Print version info and exit
#     -v, --verbose       Use verbose output
#
# Additional help:
#     -C help             Print codegen options
#     -W help             Print 'lint' options and default settings
#     --help -v           Print the full set of options rustc accepts



# CARGO_RUSTDOC = $(CARGO) rustdoc --all-features --frozen --no-default-features --package $(PACKAGE) $(RELEASE) --target $(TARGET) #--target-dir $(TARGET_DIR)

# rustdoc [options] <input>
#
# Options:
#     -h, --help          show this help message
#     -V, --version       print rustdoc's version
#     -v, --verbose       use verbose output
#     -r, --input-format [rust]
#                         the input type of the specified file
#     -w, --output-format [html]
#                         the output type to write
#     -o, --output PATH   where to place the output
#         --crate-name NAME
#                         specify the name of this crate
#         --crate-type [bin|lib|rlib|dylib|cdylib|staticlib|proc-macro]
#                         Comma separated list of types of crates
#                         for the compiler to emit
#     -L, --library-path DIR
#                         directory to add to crate search path
#         --cfg           pass a --cfg to rustc
#         --extern NAME[=PATH]
#                         pass an --extern to rustc
#         --extern-html-root-url NAME=URL
#                         base URL to use for dependencies; for example,
#                         "std=/doc" links std::vec::Vec to
#                         /doc/std/vec/struct.Vec.html
#         --plugin-path DIR
#                         removed
#     -C, --codegen OPT[=VALUE]
#                         pass a codegen option to rustc
#         --passes PASSES list of passes to also run, you might want to pass it
#                         multiple times; a value of `list` will print available
#                         passes
#         --plugins PLUGINS
#                         removed
#         --no-defaults   don't run the default passes
#         --document-private-items 
#                         document private items
#         --document-hidden-items 
#                         document items that have doc(hidden)
#         --test          run code examples as tests
#         --test-args ARGS
#                         arguments to pass to the test runner
#         --test-run-directory PATH
#                         The working directory in which to run tests
#         --target TRIPLE target triple to document
#         --markdown-css FILES
#                         CSS files to include via <link> in a rendered Markdown
#                         file
#         --html-in-header FILES
#                         files to include inline in the <head> section of a
#                         rendered Markdown file or generated documentation
#         --html-before-content FILES
#                         files to include inline between <body> and the content
#                         of a rendered Markdown file or generated documentation
#         --html-after-content FILES
#                         files to include inline between the content and
#                         </body> of a rendered Markdown file or generated
#                         documentation
#         --markdown-before-content FILES
#                         files to include inline between <body> and the content
#                         of a rendered Markdown file or generated documentation
#         --markdown-after-content FILES
#                         files to include inline between the content and
#                         </body> of a rendered Markdown file or generated
#                         documentation
#         --markdown-playground-url URL
#                         URL to send code snippets to
#         --markdown-no-toc 
#                         don't include table of contents
#     -e, --extend-css PATH
#                         To add some CSS rules with a given file to generate
#                         doc with your own theme. However, your theme might
#                         break if the rustdoc's generated HTML changes, so be
#                         careful!
#     -Z FLAG             internal and debugging options (only on nightly build)
#         --sysroot PATH  Override the system root
#         --playground-url URL
#                         URL to send code snippets to, may be reset by
#                         --markdown-playground-url or
#                         `#![doc(html_playground_url=...)]`
#         --display-warnings 
#                         to print code warnings when testing doc
#         --crate-version VERSION
#                         crate version to print into documentation
#         --sort-modules-by-appearance 
#                         sort modules by where they appear in the program,
#                         rather than alphabetically
#         --default-theme THEME
#                         Set the default theme. THEME should be the theme name,
#                         generally lowercase. If an unknown default theme is
#                         specified, the builtin default is used. The set of
#                         themes, and the rustdoc built-in default, are not
#                         stable.
#         --default-setting SETTING[=VALUE]
#                         Default value for a rustdoc setting (used when
#                         "rustdoc-SETTING" is absent from web browser Local
#                         Storage). If VALUE is not supplied, "true" is used.
#                         Supported SETTINGs and VALUEs are not documented and
#                         not stable.
#         --theme FILES   additional themes which will be added to the generated
#                         docs
#         --check-theme FILES
#                         check if given theme is valid
#         --resource-suffix PATH
#                         suffix to add to CSS and JavaScript files, e.g.,
#                         "light.css" will become "light-suffix.css"
#         --edition EDITION
#                         edition to use when compiling rust code (default:
#                         2015)
#         --color auto|always|never
#                         Configure coloring of output:
#                         auto = colorize, if output goes to a tty (default);
#                         always = always colorize output;
#                         never = never colorize output
#         --error-format human|json|short
#                         How errors and other messages are produced
#         --json CONFIG   Configure the structure of JSON diagnostics
#         --disable-minification 
#                         Disable minification applied on JS files
#     -W, --warn OPT      Set lint warnings
#     -A, --allow OPT     Set lint allowed
#     -D, --deny OPT      Set lint denied
#     -F, --forbid OPT    Set lint forbidden
#         --cap-lints LEVEL
#                         Set the most restrictive lint level. More restrictive
#                         lints are capped at this level. By default, it is at
#                         `forbid` level.
#         --index-page PATH
#                         Markdown file to be used as index page
#         --enable-index-page 
#                         To enable generation of the index page
#         --static-root-path PATH
#                         Path string to force loading static files from in
#                         output pages. If not set, uses combinations of '../'
#                         to reach the documentation root.
#         --disable-per-crate-search 
#                         disables generating the crate selector on the search
#                         box
#         --persist-doctests PATH
#                         Directory to persist doctest executables into
#         --show-coverage 
#                         calculate percentage of public items with
#                         documentation
#         --enable-per-target-ignores 
#                         parse ignore-foo for ignoring doctests on a per-target
#                         basis
#         --runtool The tool to run tests with when building for a different target than host
                        
#         --runtool-arg One (of possibly many) arguments to pass to the runtool
                        
#         --test-builder PATH
#                         The rustc-like binary to use as the test builder
#         --check         Run rustdoc checks
#         --generate-redirect-map 
#                         Generate JSON file at the top level instead of
#                         generating HTML redirection files
#         --print [unversioned-files]
#                         Rustdoc information to print on stdout
#         --emit [unversioned-shared-resources,toolchain-shared-resources,invocation-specific]
#                         Comma separated list of types of output for rustdoc to
#                         emit
#
#     @path               Read newline separated options from `path`
#
# More information available at https://doc.rust-lang.org/rustdoc/what-is-rustdoc.html
