#!/bin/bash
START=$(ls *0.svg *5.svg | sort | head -n1 | sed -e's/.*\(....\).svg/\1/')
LETTER=$(ls *2010.svg | sed -e's/2010.svg//')
for i in $(seq $START 5 2020); do git mv $LETTER${i}.svg $i.svg; mv $LETTER${i}.png ${i}.png; done
