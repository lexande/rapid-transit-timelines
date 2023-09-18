#!/bin/bash

wdiff -n -w $'\033[30;41m' -x $'\033[0m' -y $'\033[30;42m' -z $'\033[0m' \
  <(perl -wpe's/\n/ /; s/> />\n/g; s/></>\n</g;' $2 | grep $1 \
    | perl -wpe's/(\s[a-z]+=)/\n$1/g; s! />!!;' | sort | grep 'd=' )\
  <(perl -wpe's/\n/ /; s/> />\n/g; s/></>\n</g;' $3 | grep $1 \
    | perl -wpe's/(\s[a-z]+=)/\n$1/g; s! />!!;' | sort | grep 'd=' )
wdiff -n -w $'\n'"sed -e's/" -x "" -y "/" -z "/'"$'\n' \
  <(perl -wpe's/\n/ /; s/> />\n/g; s/></>\n</g;' $2 | grep $1 \
    | perl -wpe's/(\s[a-z]+=)/\n$1/g; s! />!!;' | sort | grep 'd=' )\
  <(perl -wpe's/\n/ /; s/> />\n/g; s/></>\n</g;' $3 | grep $1 \
    | perl -wpe's/(\s[a-z]+=)/\n$1/g; s! />!!;' | sort | grep 'd=' )\
  | sed -e's! /!/!;' | grep sed
