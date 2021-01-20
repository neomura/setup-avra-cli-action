set -e

rm -f ./test/example.eep.hex ./test/example.hex ./test/example.obj

avra ./test/example.asm

cmp ./test/expected.eep.hex ./test/example.eep.hex
cmp ./test/expected.hex ./test/example.hex
cmp ./test/expected.obj ./test/example.obj
