# ISSUE NAMING

| issue title example | issue label | issue number<br>(generated) | branchname<br>#number-label-title | commit scope<br>app or module_name | commit subject<br><type = label>(<scope>): <subject = title> |
| - | - | - | - | - | - |
| Build application | build | 1 | 1-build-build-application | app | build(app): Build application |
| Update package | ci | 2 | 2-ci-update-packages | app | ci(app): Update packages |
| Update readme | docs | 3 | 3-docs-update-readme | app | docs(app): Update readme |
| Add data module | feat | 4 | 4-feat-add-data-module | data | feat(data): Add data module |
| Improve relation service | fix | 5 | 5-fix-improve-relatoin-service | app | fix(app): Fix relation service |
| Improve upload image | perf | 6 | 6-perf-improve-upload-image | app | perf(app): Improve upload image |
| Refactor data service | refactor | 7 | 7-refactor-refactor-data-service | data | refactor(data): Refactor data service |
| Test data module | test | 8 | 8-test-test-data-module | data | test(data): Test data module |

# VERSIONING
product-vYYYY.MM.DD-target
product-vYYYY.MM.DD-target-rc.#

---

## TARGET ANDROID

- aarch64-linux-android, aarch64-android, aarch64
- arm-linux-androideabi, arm-androideabi, arm-eabi
- armv7-linux-androideabi, armv7-androideabi, armv7-eabi
- i686-linux-android, i686-android, i686
- thumbv7neon-linux-androideabi, thumbv7neon-androideabi, thumbv7neon-eabi
- x86_64-linux-android, x86_64-android, x86_64

---

## TARGET LINUX (BACKEND & WEB)

- aarch64-unknown-linux-gnu, aarch64-linux-gnu, aarch64-gnu, aarch64
- aarch64-unknown-linux-gnu_ilp32, aarch64-linux-gnu_ilp32, aarch64-gnu_ilp32, aarch64-ilp32
- aarch64-unknown-linux-musl, aarch64-linux-musl, aarch64-musl, aarch64
- aarch64_be-unknown-linux-gnu, aarch64_be-linux-gnu, aarch64_be-gnu, aarch64_be
- aarch64_be-unknown-linux-gnu_ilp32, aarch64_be-linux-gnu_ilp32, aarch64_be-gnu_ilp32, aarch64_be-ilp32
- arm-unknown-linux-gnueabi, arm-linux-gnueabi, arm-gnueabi, arm-eabi
- arm-unknown-linux-gnueabihf, arm-linux-gnueabihf, arm-gnueabihf, arm-eabihf
- arm-unknown-linux-musleabi, arm-linux-musleabi, arm-musleabi, arm-eabi
- arm-unknown-linux-musleabihf, arm-linux-musleabihf, arm-musleabihf, arm-eabihf
- armv4t-unknown-linux-gnueabi, armv4t-linux-gnueabi, armv4t-gnueabi, armv4t-eabi
- armv5te-unknown-linux-gnueabi, armv5te-linux-gnueabi, armv5te-gnueabi, armv5te-eabi
- armv5te-unknown-linux-musleabi, armv5te-linux-musleabi, armv5te-musleabi, armv5te-eabi
- armv5te-unknown-linux-uclibceabi, armv5te-linux-uclibceabi, armv5te-uclibceabi, armv5te-eabi
- armv7-unknown-linux-gnueabi, armv7-linux-gnueabi, armv7-gnueabi, armv7-eabi
- armv7-unknown-linux-gnueabihf, armv7-linux-gnueabihf, armv7-gnueabihf, armv7-eabihf
- armv7-unknown-linux-musleabi, armv7-linux-musleabi, armv7-musleabi, armv7-eabi
- armv7-unknown-linux-musleabihf, armv7-linux-musleabihf, armv7-musleabihf, armv7-eabihf
- hexagon-unknown-linux-musl, hexagon-linux-musl, hexagon-musl, hexagon
- i586-unknown-linux-gnu, i586-linux-gnu, i586-gnu, i586
- i586-unknown-linux-musl, i586-linux-musl, i586-musl, i586
- i686-unknown-linux-gnu, i686-linux-gnu, i686-gnu, i686
- i686-unknown-linux-musl, i686-linux-musl, i686-musl, i686
- mips-unknown-linux-gnu, mips-linux-gnu, mips-gnu, mips
- mips-unknown-linux-musl, mips-linux-musl, mips-musl, mips
- mips-unknown-linux-uclibc, mips-linux-uclibc, mips-uclibc, mips
- mips64-unknown-linux-gnuabi64, mips64-linux-gnuabi64, mips64-gnuabi64, mips64-abi64
- mips64-unknown-linux-muslabi64, mips64-linux-muslabi64, mips64-muslabi64, mips64-abi64
- mips64el-unknown-linux-gnuabi64, mips64el-linux-gnuabi64, mips64el-gnuabi64, mips64el-abi64
- mips64el-unknown-linux-muslabi64, mips64el-linux-muslabi64, mips64el-muslabi64, mips64el-abi64
- mipsel-unknown-linux-gnu, mipsel-linux-gnu, mipsel-gnu, mipsel
- mipsel-unknown-linux-musl, mipsel-linux-musl, mipsel-musl, mipsel
- mipsel-unknown-linux-uclibc, mipsel-linux-uclibc, mipsel-uclibc, mipsel
- mipsisa32r6-unknown-linux-gnu, mipsisa32r6-linux-gnu, mipsisa32r6-gnu, mipsisa32r6
- mipsisa32r6el-unknown-linux-gnu, mipsisa32r6el-linux-gnu, mipsisa32r6el-gnu, mipsisa32r6el
- mipsisa64r6-unknown-linux-gnuabi64, mipsisa64r6-linux-gnuabi64, mipsisa64r6-gnuabi64, mipsisa64r6-abi64
- mipsisa64r6el-unknown-linux-gnuabi64, mipsisa64r6el-linux-gnuabi64, mipsisa64r6el-gnuabi64, mipsisa64r6el-abi64
- powerpc-unknown-linux-gnu, powerpc-linux-gnu, powerpc-gnu, powerpc
- powerpc-unknown-linux-gnuspe, powerpc-linux-gnuspe, powerpc-gnuspe, powerpc-spe
- powerpc-unknown-linux-musl, powerpc-linux-musl, powerpc-musl, powerpc
- powerpc64-unknown-linux-gnu, powerpc64-linux-gnu, powerpc64-gnu, powerpc64
- powerpc64-unknown-linux-musl, powerpc64-linux-musl, powerpc64-musl, powerpc64
- powerpc64le-unknown-linux-gnu, powerpc64le-linux-gnu, powerpc64le-gnu, powerpc64le
- powerpc64le-unknown-linux-musl, powerpc64le-linux-musl, powerpc64le-musl, powerpc64le
- riscv32gc-unknown-linux-gnu, riscv32gc-linux-gnu, riscv32gc-gnu, riscv32gc
- riscv32gc-unknown-linux-musl, riscv32gc-linux-musl, riscv32gc-musl, riscv32gc
- riscv64gc-unknown-linux-gnu, riscv64gc-linux-gnu, riscv64gc-gnu, riscv64gc
- riscv64gc-unknown-linux-musl, riscv64gc-linux-musl, riscv64gc-musl, riscv64gc
- s390x-unknown-linux-gnu, s390x-linux-gnu, s390x-gnu, s390x
- s390x-unknown-linux-musl, s390x-linux-musl, s390x-musl, s390x
- sparc-unknown-linux-gnu, sparc-linux-gnu, sparc-gnu, sparc
- sparc64-unknown-linux-gnu, sparc64-linux-gnu, sparc64-gnu, sparc64
- thumbv7neon-unknown-linux-gnueabihf, thumbv7neon-linux-gnueabihf, thumbv7neon-gnueabihf, thumbv7neon-eabihf
- thumbv7neon-unknown-linux-musleabihf, thumbv7neon-linux-musleabihf, thumbv7neon-musleabihf, thumbv7neon-eabihf
- x86_64-unknown-linux-gnu, x86_64-linux-gnu, x86_64-gnu, x86_64
- x86_64-unknown-linux-gnux32, x86_64-linux-gnux32, x86_64-gnux32, x86_64-x32
- x86_64-unknown-linux-musl, x86_64-linux-musl, x86_64-musl, x86_64
- x86_64-unknown-none-linuxkernel, x86_64-none-linuxkernel, x86_64-none-linuxkernel, x86_64-none-linuxkernel

---

## TARGET WIINDOWS

- aarch64-pc-windows-msvc, aarch64-windows-msvc, aarch64-msvc, aarch64
- aarch64-uwp-windows-msvc, aarch64-windows-msvc, aarch64-msvc, aarch64
- i586-pc-windows-msvc, i586-windows-msvc, i586-msvc, i586
- i686-pc-windows-gnu, i686-windows-gnu, i686-gnu, i686
- i686-pc-windows-msvc, i686-windows-msvc, i686-msvc, i686
- i686-uwp-windows-gnu, i686-windows-gnu, i686-gnu, i686
- i686-uwp-windows-msvc, i686-windows-msvc, i686-msvc, i686
- thumbv7a-pc-windows-msvc, thumbv7a-windows-msvc, thumbv7a-msvc, thumbv7a
- thumbv7a-uwp-windows-msvc, thumbv7a-windows-msvc, thumbv7a-msvc, thumbv7a
- x86_64-pc-windows-gnu, x86_64-windows-gnu, x86_64-gnu, x86_64
- x86_64-pc-windows-msvc, x86_64-windows-msvc, x86_64-msvc, x86_64
- x86_64-uwp-windows-gnu, x86_64-windows-gnu, x86_64-gnu, x86_64
- x86_64-uwp-windows-msvc, x86_64-windows-msvc, x86_64-msvc, x86_64

---

## TARGET iOS

- aarch64-apple-ios, aarch64-ios, aarch64, aarch64
- aarch64-apple-ios-macabi, aarch64-ios-macabi, aarch64-macabi, aarch64
- aarch64-apple-ios-sim, aarch64-ios-sim, aarch64-sim, aarch64
- armv7-apple-ios, armv7-ios, armv7, armv7
- armv7s-apple-ios, armv7s-ios, armv7s, armv7s
- i386-apple-ios, i386-ios, i386, i386
- x86_64-apple-ios, x86_64-ios, x86_64, x86_64
- x86_64-apple-ios-macabi, x86_64-ios-macabi, x86_64-macabi, x86_64

---

## TARGET macOS

- aarch64-apple-darwin, aarch64-darwin, aarch64
- i686-apple-darwin, i686-darwin, i686
- x86_64-apple-darwin, x86_64-darwin, x86_64