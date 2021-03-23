set -e
rm -f main.wasm

mkdir -p release/desktop
mkdir -p release/browser

FLAGS="-I./dependencies/wasm/include -l symengine -l gmp -L./dependencies/wasm/lib -Wl,--stack-first"
DESKTOP_FLAGS=""
BROWSER_FLAGS="--shell-file ./assets/index.html"
DEBUG_FLAGS="-s ASSERTIONS=1 -s SAFE_HEAP=1 -s SAFE_HEAP_LOG=1 -s DEMANGLE_SUPPORT=1"

if [[ -n "$1" ]] && [[ "${1#*.}" == "desktop" ]]; then
    emcc main.c -o ./release/desktop/main.wasm $FLAGS $DESKTOP_FLAGS
elif [[ -n "$1" ]] && [[ "${1#*.}" == "browser" ]]; then
    emcc main.c -o ./release/browser/main.html $FLAGS $BROWSER_FLAGS
else
    emcc main.c -o ./release/desktop/main.wasm $FLAGS $DESKTOP_FLAGS
    emcc main.c -o ./release/browser/main.html $FLAGS $BROWSER_FLAGS
fi
