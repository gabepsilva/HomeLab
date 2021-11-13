#!/usr/bin/env bash

RUN_PATH="`dirname \"$0\"`"

for file in $(find $RUN_PATH -name "*.yml" -type f)
do
  
    lxc profile create $(basename $file)
    cat $file | lxc profile edit $(basename $file)

done