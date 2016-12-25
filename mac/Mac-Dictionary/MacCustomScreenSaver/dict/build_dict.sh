#!/bin/sh

echo "##Clean System Dictonary Caches"
./clean.sh
echo "##Clean last builds"
make clean
echo "##make"
make 
echo "##make install"
make install

