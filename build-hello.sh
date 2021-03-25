set -e

clang hello.cpp -o hello.wasm --target=wasm32-wasi --sysroot=/Users/colbyn/Developer/wasi-sdk-12.0/share/wasi-sysroot -I./build/dependencies/wasm32-wasi/include -L./build/dependencies/wasm32-wasi/lib -lstdc++ -l symengine -l gmp -O0 -g
