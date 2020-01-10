#!/usr/bin/env bash

# Copyright © 2020 Jakub Wilk <jwilk@jwilk.net>
# SPDX-License-Identifier: MIT

set -e -u
pdir="${0%/*}/.."
prog="$pdir/gpg-pretty-expire"
echo 1..1
out=$("$prog" --help)
sed -e 's/^/# /' <<< "$out"
if [[ $out = 'Usage: '*/'gpg-pretty-expire KEYID [YEAR]' ]]
then
    echo 'ok 1'
else
    echo 'not ok 1'
fi

# vim:ts=4 sts=4 sw=4 et ft=sh
