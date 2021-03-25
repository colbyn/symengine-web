#!/bin/zsh
set -e

cd build || {mkdir build && cd build}

into_source_dir() {
    cd $1 || {git clone https://github.com/torquem-ch/gmp-wasm.git $1 && cd $1}
}

###############################################################################
# BUILD WASM (EMSCRIPTEN)
###############################################################################

into_source_dir gmp-emscripten-wasm
mkdir -p target
CFLAGS="-O0 -g" emconfigure ./configure --disable-assembly --host none --disable-cxx --enable-shared --prefix=$(pwd)/target CFLAGS="-O0 -g" 
make
make install
cd ..

mkdir -p dependencies/emscripten-wasm
rsync -av gmp-emscripten-wasm/target/* dependencies/emscripten-wasm

###############################################################################
# BUILD WASM32-WASI - VIA NATIVE CLANG
###############################################################################

into_source_dir gmp-wasm32-wasi
mkdir -p target

CFLAGS="--target=wasm32-wasi --sysroot=/Users/colbyn/Developer/wasi-sdk-12.0/share/wasi-sysroot -Wl,--no-entry -Wl,--export-all" ./configure --prefix=$(pwd)/target CC=/Users/colbyn/Developer/wasi-sdk-12.0/bin/clang --host=none --disable-assembly --disable-cxx
make
make install
cd ..

mkdir -p dependencies/wasm32-wasi
rsync -av gmp-wasm32-wasi/target/* dependencies/wasm32-wasi


###############################################################################
# BUILD LEGACY X86
###############################################################################

into_source_dir gmp-x86-legacy
mkdir -p target
CC=/usr/local/opt/llvm/bin/clang CFLAGS="--target x86_64-apple-darwin20.3.0" ./configure --disable-assembly --host none --disable-cxx --prefix=$(pwd)/target 
make
make install
cd ..

mkdir -p dependencies/x86-legacy
rsync -av gmp-x86-legacy/target/* dependencies/x86-legacy

###############################################################################
# CLEANUP
###############################################################################
# rm -rf gmp-wasm
# rm -rf gmp-x86
# rm -rf gmp-6.1.2.tar.lz