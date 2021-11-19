#!/usr/bin/env bash

set -x

cd /tmp

lxc delete a --force
lxc profile delete clconfig

lxc profile create clconfig
cat clconfig.yml | lxc profile edit  clconfig



lxc profile list
lxc profile show clconfig


exit 0

lxc launch -p clconfig images:ubuntu/focal/cloud a


while true
do

lxc exec a -- "cloud-init status"
sleep 1
done