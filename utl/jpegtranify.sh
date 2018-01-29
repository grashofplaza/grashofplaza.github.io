#!/bin/sh
FROM=$1
TMP=$$
cat "$FROM" | jpegtran -copy none -optimize -progressive > $TMP
mv $TMP "$FROM"
