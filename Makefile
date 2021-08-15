.DEFAULT_GOAL := help

# CARGO: cargo, cross
# PACKAGE: fip_api
# RELEASE: --release
# STRIP: aarch64-linux-gnu-strip, arm-linux-gnueabihf-strip, strip
# TARGET: aarch64-unknown-linux-musl, armv7-unknown-linux-musleabihf, x86_64-unknown-linux-musl
# VERSION: git describe --tags --abbrev=0

CARGO ?= cargo
PACKAGE ?= fip_api
# RELEASE ?= --release
STRIP ?= strip
TARGET ?= $(shell rustup show | sed -n 's/^Default host: \(.*\)/\1/p')
VERSION ?= v0.1.0

TARGET_DIR = target/$(TARGET)
BIN_DIR = $(TARGET_DIR)/debug
ifdef RELEASE
	BIN_DIR = $(TARGET_DIR)/release
endif

BIN = $(BIN_DIR)/$(PACKAGE)
BIN_NAME = $(PACKAGE)-$(VERSION)-$(TARGET)

COVERAGE_DIR = $(TARGET_DIR)/cov
DOCUMENTATION_DIR = $(TARGET_DIR)/doc

CARGO_BENCH = $(CARGO) bench --all-features --all-targets --frozen --no-default-features --package $(PACKAGE) $(RELEASE) --target $(TARGET)
CARGO_BUILD = $(CARGO) build --all-features --all-targets --frozen --no-default-features --package $(PACKAGE) $(RELEASE) --target $(TARGET)
CARGO_CHECK = $(CARGO) check --all-features --all-targets --frozen --no-default-features --package $(PACKAGE) $(RELEASE) --target $(TARGET)
CARGO_CLEAN = $(CARGO) clean --frozen --package $(PACKAGE) $(RELEASE) --target $(TARGET)
CARGO_DOC = $(CARGO) doc --document-private-items --frozen --no-default-features --package $(PACKAGE) $(RELEASE) --target $(TARGET)
CARGO_FETCH = $(CARGO) fetch --locked --target $(TARGET)
CARGO_FIX = $(CARGO) fix --all-features --frozen --no-default-features --package $(PACKAGE) $(RELEASE) --target $(TARGET)
CARGO_RUN = $(CARGO) run --all-features --frozen --no-default-features --package $(PACKAGE) $(RELEASE) --target $(TARGET)
CARGO_TEST = $(CARGO) test --all-features --all-targets --frozen --no-default-features --package $(PACKAGE) $(RELEASE) --target $(TARGET)

CARGO_AUDIT = $(CARGO) audit
CARGO_CLIPPY = $(CARGO) clippy --all-features --all-targets --frozen --no-default-features --workspace -- -D warnings
# CARGO_CONVENTIONAL_COMMITS_LINTER = conventional_commits_linter --allow-angular-type-only --from-stdin
CARGO_CONVENTIONAL_COMMITS_LINTER = conventional_commits_linter --allow-angular-type-only --from-stdin
CARGO_DENY = $(CARGO) deny --all-features --no-default-features --workspace
CARGO_FMT = $(CARGO) fmt --package $(PACKAGE)
CARGO_SPELLCHECK = $(CARGO) spellcheck --cfg .cargo/spellcheck.toml

$(BIN): add-fmt add-target fetch
	$(CARGO_BUILD)

.PHONY: add-audit
add-audit: ## Add the audit
	$(CARGO) install cargo-audit
	$(CARGO) generate-lockfile

.PHONY: add-clippy
add-clippy: ## Add the clippy
	rustup component add clippy

.PHONY: add-conventional-commits-linter
add-conventional-commits-linter: ## Add the conventional commits linter
	$(CARGO) install --locked conventional_commits_linter

.PHONY: add-deny
add-deny: ## Add the deny
	$(CARGO) install --locked cargo-deny

.PHONY: add-fmt
add-fmt: ## Add the fmt
	rustup component add rustfmt

.PHONY: add-grcov
add-grcov: ## Add the grcov
	$(CARGO) install --locked grcov

.PHONY: add-llvm
add-llvm: ## Add the llvm tools preview
	rustup component add llvm-tools-preview

.PHONY: add-target
add-target: ## Add a target
	rustup target add $(TARGET)

.PHONY: add-spellcheck
add-spellcheck: ## Add a target
	$(CARGO) install --locked cargo-spellcheck

.PHONY: help
help: ## Help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s", $$1, $$2}'

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
clean: clean-build clean-cov clean-doc clean-release ## Clean
	rm -fr target

.PHONY: clean-build
clean-build: add-target ## Clean build
	$(CARGO_CLEAN)
	rm -fr $(BIN_DIR)

.PHONY: clean-cov
clean-cov: add-target ## Clean cov
	find . -name "*.profdata" -exec rm -fr {} +
	find . -name "*.profraw" -exec rm -fr {} +
	rm -fr $(COVERAGE_DIR)
	rm -fr coverage

.PHONY: clean-doc
clean-doc: add-target ## Clean doc
	$(CARGO_CLEAN) --doc
	rm -fr $(DOCUMENTATION_DIR)
	rm -fr documentation

.PHONY: clean-release
clean-release: add-target ## Clean release
	rm -fr release

.PHONY: clippy
clippy: add-clippy add-fmt fetch ## Clippy
	$(CARGO_CLIPPY)

.PHONY: conventional-commits-linter
conventional-commits-linter: add-conventional-commits-linter ## Conventional commits linter
	$(CARGO_CONVENTIONAL_COMMITS_LINTER)

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
	mkdir -p documentation
	cp -R $(DOCUMENTATION_DIR)/* documentation

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
	mkdir -p release
	cp $(BIN) release/$(BIN_NAME)
	$(STRIP) release/$(BIN_NAME)
	shasum -a 256 release/$(BIN_NAME) \
		| cut -d " " -f 1 > release/$(BIN_NAME).sha256

.PHONY: spellcheck
spellcheck: add-spellcheck ## Spellcheck
	$(CARGO_SPELLCHECK)

.PHONY: test
test: add-fmt add-target fetch ## Test
	$(CARGO_TEST)

.PHONY: test-cov
test-cov: add-fmt add-grcov add-llvm add-target clean-cov fetch ## Test cov
	RUSTC_BOOTSTRAP=1 RUSTFLAGS="-Zinstrument-coverage" $(CARGO_BUILD)
	RUSTC_BOOTSTRAP=1 RUSTFLAGS="-Zinstrument-coverage" $(CARGO_TEST)
	grcov . \
		--binary-path $(BIN_DIR) \
		--branch \
		--guess-directory-when-missing \
		--ignore-not-existing \
		--output-path $(COVERAGE_DIR) \
		--output-type html \
		--source-dir .
	mkdir -p coverage
	cp -R $(COVERAGE_DIR)/* coverage

# # # # # # # # #
#               #
#   GIT HOOKS   #
#               #
# # # # # # # # #

define COMMIT_MSG
#!/bin/sh
set -o errexit
set -o pipefail
cat "$${1}" | make conventional-commits-linter
endef
export COMMIT_MSG

GIT_HOOKS_COMMIT_MSG = .git/hooks/commit-msg
$(GIT_HOOKS_COMMIT_MSG):
	@echo "+ add commit-msg"
	@echo "$$COMMIT_MSG" > $@
	@chmod 755 $@

define PRE_COMMIT
#!/bin/sh
set -eu
# make spellcheck -- -m 99 $$(git diff-index --cached --name-only --diff-filter=AM HEAD)
make clippy fmt-check
for LINE in $$(git diff --staged --name-status | grep .rs | grep -v 'D' | grep -v 'R'); do
	FILE=$$(echo $$LINE | awk 'match($$0, /.*/) {print $$2}')
	git add $$FILE
done
endef
export PRE_COMMIT

GIT_HOOKS_PRE_COMMIT = .git/hooks/pre-commit
$(GIT_HOOKS_PRE_COMMIT):
	@echo "+ add pre-commit"
	@echo "$$PRE_COMMIT" > $@
	@chmod 755 $@

define PRE_PUSH
#!/bin/sh
set -e
make audit deny-check check test
endef
export PRE_PUSH

GIT_HOOKS_PRE_PUSH = .git/hooks/pre-push
$(GIT_HOOKS_PRE_PUSH):
	@echo "+ add pre-push"
	@echo "$$PRE_PUSH" > $@
	@chmod 755 $@

GIT_HOOKS = $(GIT_HOOKS_COMMIT_MSG) $(GIT_HOOKS_PRE_COMMIT) $(GIT_HOOKS_PRE_PUSH)

.PHONY: clean-git-hooks
clean-git-hooks:
	@echo "+ clean git-hooks"
	@rm -fr $(GIT_HOOKS)

.PHONY: git-hooks
git-hooks: clean-git-hooks $(GIT_HOOKS)
	@echo "+ installed"



# CARGO_RUSTC = $(CARGO) rustc --all-features --frozen --no-default-features --package $(PACKAGE) $(RELEASE) --target $(TARGET)

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



# CARGO_RUSTDOC = $(CARGO) rustdoc --all-features --frozen --no-default-features --package $(PACKAGE) $(RELEASE) --target $(TARGET)

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
