#!/usr/bin/env bash


for file in $(find . -name "*.yml" -type f)
do
  
    lxc profile create $(basename $file)
    cat $file | lxc profile edit $(basename $file)

done