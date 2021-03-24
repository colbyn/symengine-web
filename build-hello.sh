set -e

clang hello.c -o hello.wasm --target=wasm32-wasi --sysroot=/Users/colbyn/Developer/wasi-sdk-12.0/share/wasi-sysroot
