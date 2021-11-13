#/usr/bin/env bash


 lxc profile create vault-server1.yml
 cat /tmp/vault-server1-profile.yml | lxc profile edit vault-server1.yml

lxc launch \
    -p conf-autostart-on.yml \
    -p disk-std.yml \
    -p network-lvl1.yml \
    -p vault-server1.yml \
    images:ubuntu/focal/cloud vault-server1


LAST_OUTPUT=$?

if [ $LAST_OUTPUT -ne 0 ]
then
    exit $LAST_OUTPUT
fi

sleep 20

lxc restart vault-server1