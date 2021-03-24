#!/bin/zsh
set -e

cd build || {mkdir build && cd build}

###############################################################################
# DOWNLOAD & INIT
###############################################################################

cd symengine || {git clone https://github.com/symengine/symengine.git && cd symengine}

mkdir -p target/emscripten-wasm
mkdir -p target/wasm32-wasi
mkdir -p target/x86-legacy

###############################################################################
# BUILD ENSCRIPTEN-WASM
###############################################################################

mkdir -p build-emscripten-wasm && cd build-emscripten-wasm
emcmake cmake \
    -DCMAKE_INSTALL_PREFIX=$(pwd)/../target/emscripten-wasm \
    -DWITH_BF=OFF \
    -DWITH_SYMENGINE_ASSER=OFF \
    -DWITH_SYMENGINE_RC=OFF \
    -DWITH_SYMENGINE_THREAD_SAFE=OFF \
    -DWITH_EC=OFF \
    -DWITH_PRIMESIEV=OFF \
    -DWITH_FLIN=OFF \
    -DWITH_AR=OFF \
    -DWITH_TCMALLO=OFF \
    -DWITH_OPENM=OFF \
    -DWITH_PIRANH=OFF \
    -DWITH_MPF=OFF \
    -DWITH_MP=OFF \
    -DWITH_LLV=OFF \
    -DBUILD_TESTS=OFF \
    -DBUILD_BENCHMARK=OFF \
    -DBUILD_BENCHMARKS=OFF \
    -DBUILD_BENCHMARKS_NONIU=OFF \
    -DBUILD_BENCHMARKS_GOOGL=OFF \
    -DINTEGER_CLASS=gmp \
    -DBUILD_SHARED_LIBS=ON \
    -DCMAKE_INSTALL_RPATH_USE_LINK_PAT=OFF \
    -DGMP_LIBRARY=../../dependencies/emscripten-wasm/lib/libgmp.a \
    -DGMP_INCLUDE_DIR=../../dependencies/emscripten-wasm/include \
    -DDISABLE_EXCEPTION_CATCHING=0 \
    -DERROR_ON_UNDEFINED_SYMBOLS=0 \
    -DBUILD_WEBFRONTEND=OFF \
    -DCMAKE_CXX_FLAGS="-O0 -g" \
    ..

emmake make
emmake make install
cd ../..

mkdir -p dependencies/emscripten-wasm
rsync -av  symengine/target/emscripten-wasm/* dependencies/emscripten-wasm

# ###############################################################################
# BUILD WASM32-WASI - VIA NATIVE CLANG
# ###############################################################################

mkdir -p build-wasm32-wasi && cd build-wasm32-wasi
cmake -DCMAKE_INSTALL_PREFIX=$(pwd)/../target/wasm32-wasi \
      -DWITH_BF=OFF \
      -DWITH_SYMENGINE_ASSER=OFF \
      -DWITH_SYMENGINE_RC=OFF \
      -DWITH_SYMENGINE_THREAD_SAF=OFF \
      -DWITH_EC=OFF \
      -DWITH_PRIMESIEV=OFF \
      -DWITH_FLIN=OFF \
      -DWITH_AR=OFF \
      -DWITH_TCMALLO=OFF \
      -DWITH_OPENM=OFF \
      -DWITH_PIRANH=OFF \
      -DWITH_MPF=OFF \
      -DWITH_MP=OFF \
      -DWITH_LLV=OFF \
      -DBUILD_TESTS=OFF \
      -DBUILD_BENCHMARK=OFF \
      -DBUILD_BENCHMARKS=OFF \
      -DBUILD_BENCHMARKS_NONIU=OFF \
      -DBUILD_BENCHMARKS_GOOGL=OFF \
      -DINTEGER_CLASS=gmp \
      -DBUILD_SHARED_LIBS=OFF \
      -DCMAKE_INSTALL_RPATH_USE_LINK_PAT=OFF \
      -DGMP_LIBRARY=../../dependencies/wasm32-wasi/lib/libgmp.a \
      -DGMP_INCLUDE_DIR=../../dependencies/wasm32-wasi/include \
      -DDISABLE_EXCEPTION_CATCHING=0 \
      -DERROR_ON_UNDEFINED_SYMBOLS=0 \
      -DBUILD_WEBFRONTEND=OFF \
      -DCMAKE_CXX_FLAGS="--target=wasm32-wasi --sysroot=/Users/colbyn/Developer/wasi-sdk-12.0/share/wasi-sysroot" \
      -DCMAKE_C_COMPILER=/Users/colbyn/Developer/wasi-sdk-12.0/bin/clang \
      -DCMAKE_CXX_COMPILER=/Users/colbyn/Developer/wasi-sdk-12.0/bin/clang \
      -DCMAKE_AR="/Users/colbyn/Developer/wasi-sdk-12.0/bin/llvm-ar" \
      -DCMAKE_TRY_COMPILE_TARGET_TYPE=STATIC_LIBRARY \
      ..

make
make install
cd ../..

mkdir -p dependencies/wasm32-wasi
rsync -av  symengine/target/x86/* dependencies/wasm32-wasi


###############################################################################
# BUILD LEGACY X86 (NON-WASM)
###############################################################################

mkdir -p build-x86 && cd build-x86
cmake -DCMAKE_INSTALL_PREFIX=$(pwd)/../target/x86 \
      -DWITH_BF=OFF \
      -DWITH_SYMENGINE_ASSER=OFF \
      -DWITH_SYMENGINE_RC=OFF \
      -DWITH_SYMENGINE_THREAD_SAF=OFF \
      -DWITH_EC=OFF \
      -DWITH_PRIMESIEV=OFF \
      -DWITH_FLIN=OFF \
      -DWITH_AR=OFF \
      -DWITH_TCMALLO=OFF \
      -DWITH_OPENM=OFF \
      -DWITH_PIRANH=OFF \
      -DWITH_MPF=OFF \
      -DWITH_MP=OFF \
      -DWITH_LLV=OFF \
      -DBUILD_TESTS=OFF \
      -DBUILD_BENCHMARK=OFF \
      -DBUILD_BENCHMARKS=OFF \
      -DBUILD_BENCHMARKS_NONIU=OFF \
      -DBUILD_BENCHMARKS_GOOGL=OFF \
      -DINTEGER_CLASS=gmp \
      -DBUILD_SHARED_LIBS=OFF \
      -DCMAKE_INSTALL_RPATH_USE_LINK_PAT=OFF \
      -DGMP_LIBRARY=../../dependencies/x86/lib/libgmp.a \
      -DGMP_INCLUDE_DIR=../../dependencies/x86/include \
      -DDISABLE_EXCEPTION_CATCHING=0 \
      -DERROR_ON_UNDEFINED_SYMBOLS=0 \
      -DBUILD_WEBFRONTEND=OFF \
      ..

make
make install
cd ../..

mkdir -p dependencies/x86-legacy
rsync -av  symengine/target/x86/* dependencies/x86-legacy

