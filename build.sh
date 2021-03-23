set -e
rm -f main.wasm

mkdir -p release/desktop
mkdir -p release/browser

FLAGS="-I./dependencies/include -l symengine -l gmp -L./dependencies/lib -Wl,--stack-first"
DESKTOP_FLAGS="-s WASM=1 -s EXPORTED_FUNCTIONS=['_run']"
BROWSER_FLAGS="--shell-file ./assets/index.html"

if [[ -n "$1" ]] && [[ "${1#*.}" == "desktop" ]]; then
    emcc main.c -o ./release/desktop/main.wasm $FLAGS $DESKTOP_FLAGS
elif [[ -n "$1" ]] && [[ "${1#*.}" == "browser" ]]; then
    emcc main.c -o ./release/browser/main.html $FLAGS $BROWSER_FLAGS
else
    emcc main.c -o ./release/desktop/main.wasm $FLAGS $DESKTOP_FLAGS
    emcc main.c -o ./release/browser/main.html $FLAGS $BROWSER_FLAGS
fi
