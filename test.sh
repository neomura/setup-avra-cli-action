set -e

rm -f ./test/example.eep.hex ./test/example.hex ./test/example.obj

avra ./test/example.asm

cmp ./test/expected.eep.hex ./test/example.eep.hex
cmp ./test/expected.hex ./test/example.hex

if [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
  cmp ./test/expected-mingw32.obj ./test/example.obj
else
  cmp ./test/expected.obj ./test/example.obj
fi
