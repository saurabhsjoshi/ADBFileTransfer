#!/bin/sh
# Python starter

for i in $*; do 
    a+=$i
 done

python my_adb.pyw "$@"