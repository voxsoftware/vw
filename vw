#!/bin/bash
path="`dirname \"$0\"`"
"$path/vwdata/jx" --expose-gc "$path/vwdata/node_modules/vw" "$@"
