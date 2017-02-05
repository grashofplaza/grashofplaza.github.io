#!/bin/sh
SIZE=$1
FROM=$2
TO=$3
convert "$FROM" -resize $SIZE^x$SIZE^ -gravity Center -crop $SIZE!x$SIZE!-0+0 - | \
    jpegtran -copy none -optimize -progressive > $TO
