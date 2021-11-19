#/usr/bin/env bash


 lxc profile create jenkins-node1.yml
 cat /tmp/jenkins-node1-profile.yml | lxc profile edit jenkins-node1.yml

lxc launch \
    -p conf-autostart-on.yml \
    -p disk-std.yml \
    -p network-lvl1.yml \
    -p jenkins-node1.yml \
    images:ubuntu/focal/cloud jenkins-node1
