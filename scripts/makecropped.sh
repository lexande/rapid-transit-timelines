#!/bin/bash

if [ -e cropscript.pl ]; then
    cd uncropped
    for i in ????.svg; do
        if [ $i -nt ../$i ]; then
            ../cropscript.pl $i > ../$i
        fi
    done
    cd ..
    ~/timelines/scripts/autopng.sh *.svg
    ~/timelines/scripts/makesmall.sh *.svg
fi
