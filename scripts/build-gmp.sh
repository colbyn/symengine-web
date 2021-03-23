set -e

wget https://gmplib.org/download/gmp/gmp-6.1.2.tar.lz

###############################################################################
# BUILD WASM
###############################################################################

tar xf gmp-6.1.2.tar.lz
mv gmp-6.1.2 gmp-wasm
cd gmp-wasm
mkdir -p target
emconfigure ./configure --disable-assembly --host none --enable-cxx --prefix=$(pwd)/target 
make
make install
cd ..

mkdir -p dependencies/wasm/include
mkdir -p dependencies/wasm/lib
cp -r gmp-wasm/target/include/gmp.h dependencies/wasm/include/gmp.h
cp -r gmp-wasm/target/lib/libgmp.a dependencies/wasm/lib/libgmp.a

###############################################################################
# BUILD X86
###############################################################################

tar xf gmp-6.1.2.tar.lz
mv gmp-6.1.2 gmp-x86
cd gmp-x86
mkdir -p target
./configure --disable-assembly --host none --enable-cxx --prefix=$(pwd)/target 
make
make install
cd ..

mkdir -p dependencies/x86/include
mkdir -p dependencies/x86/lib
cp -r gmp-x86/target/include/gmp.h dependencies/x86/include/gmp.h
cp -r gmp-x86/target/lib/libgmp.a dependencies/x86/lib/libgmp.a

###############################################################################
# CLEANUP
###############################################################################
rm -rf gmp-wasm
rm -rf gmp-x86
rm -rf gmp-6.1.2.tar.lz