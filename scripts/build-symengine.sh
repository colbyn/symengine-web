set -e

rm -rf symengine

# SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
# ROOT_DIR=$SCRIPT_DIR/..
# SYMENGINE_DIR=$ROOT_DIR/symengine
# DEPENDENCIES_DIR=$ROOT_DIR/dependencies

###############################################################################
# DOWNLOAD & INIT
###############################################################################

git clone https://github.com/symengine/symengine.git
cd symengine
mkdir -p target/wasm target/x86

###############################################################################
# BUILD WASM
###############################################################################

rm -rf build-wasm && mkdir -p build-wasm && cd build-wasm
emcmake cmake \
    -DCMAKE_INSTALL_PREFIX=$(pwd)/../target/wasm \
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
    -DBUILD_SHARED_LIBS=ON \
    -DCMAKE_INSTALL_RPATH_USE_LINK_PAT=OFF \
    -DGMP_LIBRARY=../../dependencies/wasm/lib/libgmp.a \
    -DGMP_INCLUDE_DIR=../../dependencies/wasm/include \
    -DDISABLE_EXCEPTION_CATCHING=0 \
    -DERROR_ON_UNDEFINED_SYMBOLS=0 \
    -DBUILD_WEBFRONTEND=OFF \
    ..

emmake make
emmake make install
cd ..

###############################################################################
# BUILD X86
###############################################################################

rm -rf build-x86 && mkdir -p build-x86 && cd build-x86
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
cd ..

mkdir -p dependencies/wasm/include dependencies/wasm/lib
mkdir -p dependencies/x86/include dependencies/x86/lib

rsync -a symengine/target/wasm/include dependencies/wasm
rsync -a symengine/target/x86/include dependencies/x86

cp symengine/target/wasm/lib/libsymengine.a dependencies/wasm/lib
cp symengine/target/x86/lib/libsymengine.a dependencies/x86/lib

rm -rf symengine/
