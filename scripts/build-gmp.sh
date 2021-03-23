set -e

wget https://gmplib.org/download/gmp/gmp-6.1.2.tar.lz
tar xf gmp-6.1.2.tar.lz
cd gmp-6.1.2
emconfigure ./configure --disable-assembly --host none --enable-cxx --prefix=$(pwd)/output-wasm 
make
make install

mkdir -p dependencies/include
mkdir -p dependencies/lib

cp -r gmp-6.1.2/output-wasm/include/gmp.h dependencies/include/gmp.h
cp -r gmp-6.1.2/output-wasm/lib/libgmp.a dependencies/lib/libgmp.a

rm -rf gmp-6.1.2.tar.lz gmp-6.1.2