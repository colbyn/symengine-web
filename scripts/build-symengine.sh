set -e

# rm -rf symengine
# git clone https://github.com/symengine/symengine.git
# cd symengine && mkdir -p build

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
ROOT_DIR=$SCRIPT_DIR/..
SYMENGINE_DIR=$ROOT_DIR/symengine
GMP_OUTPUT_DIR=$ROOT_DIR/gmp-6.1.2/output-wasm
GMP_INCLUDE_DIR=$GMP_OUTPUT_DIR/include
GMP_LIB_FILE=$GMP_OUTPUT_DIR/lib/libgmp.a

###############################################################################
# INIT
###############################################################################

cd $SYMENGINE_DIR
mkdir -p build output-dir
OUTPUT_DIR=$(pwd)/output-dir


###############################################################################
# BUILD
###############################################################################


cd build
emcmake cmake \
    -DCMAKE_INSTALL_PREFIX=$OUTPUT_DIR \
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
    -DGMP_LIBRARY=$GMP_LIB_FILE \
    -DGMP_INCLUDE_DIR=$GMP_INCLUDE_DIR \
    -DDISABLE_EXCEPTION_CATCHING=0 \
    -DERROR_ON_UNDEFINED_SYMBOLS=0 \
    -DBUILD_WEBFRONTEND=OFF \
    ..

emmake make
emmake make install

mkdir -p dependencies/include
mkdir -p dependencies/lib

cp -r symengine/output-dir/include/symengine dependencies/include
cp -r symengine/output-dir/lib/libsymengine.a dependencies/lib/libsymengine.a

rm -rf symengine/