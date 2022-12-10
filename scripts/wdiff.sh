#!/bin/bash
wdiff -n -w $'\033[30;41m' -x $'\033[0m' -y $'\033[30;42m' -z $'\033[0m' <(grep -A1 -B1 "$1" $2 | grep -i '"m' | sort) <(grep -A1 -B1 "$1" $3 | grep -i '"m' | sort)
wdiff -n -w $'\n'"sed -e's/" -x "" -y "/" -z "/'"$'\n' <(grep -A1 -B1 "$1" $2 | grep -i '"m' | sed -e's! />!!;' | sort) <(grep -A1 -B1 "$1" $3 | grep -i '"m' | sed -e's! />!!;' | sort) | sed -e's! /!/!;' | grep sed
