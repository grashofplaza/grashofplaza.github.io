#!/bin/sh
SIZE=$1
FROM=$2
TO=$3
convert $FROM \( -clone 0 -resize $SIZEx$SIZE -strip \) -delete 0 - | jpegtran -copy none -optimize -progressive > $TO
# convert $FROM \( -clone 0 -resize $SIZEx$SIZE -strip \) -delete 0 $TO
