#!/system/bin/sh

LD=/data/data/com.droidplot/mylib/ld-linux.so.3
aLIB=/data/data/com.droidplot/mylib
bLIB=/data/data/com.octave.arm/freeRoot/usr/local/lib
BIN=/data/data/com.octave.arm/freeRoot/usr/local/bin/ngsconvert

$LD --library-path ${aLIB}:${bLIB} $BIN $@

exit 0
