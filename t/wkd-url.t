#!/usr/bin/env bash

# Copyright © 2020 Jakub Wilk <jwilk@jwilk.net>
# SPDX-License-Identifier: MIT

set -e -u
pdir="${0%/*}/.."
prog="$pdir/wkd-url"
echo 1..2
out=$("$prog" --help)
sed -e 's/^/# /' <<< "$out"
if [[ $out = 'Usage: '*/'wkd-url ADDRESS [ADDRESS...]' ]]
then
    echo 'ok 1'
else
    echo 'not ok 1'
fi
in=(
    Joe.Doe@example.org
    jwilk@jwilk.net
)
xout=(
    https://example.org/.well-known/openpgpkey/hu/iy9q119eutrkn8s1mk4r39qejnbu3n5q
    https://jwilk.net/.well-known/openpgpkey/hu/je6qitbsqifya391hyc65ts9ktd4qisd
)
out=$("$prog" "${in[@]}")
say() { printf "%s\n" "$@"; }
diff=$(diff -u <(say "${xout[@]}") <(say "$out")) || true
if [ -z "$diff" ]
then
    sed -e 's/^/# /' <<< "$out"
    echo 'ok 2'
else
    sed -e 's/^/# /' <<< "$diff"
    echo 'not ok 2'
fi

# vim:ts=4 sts=4 sw=4 et ft=sh
