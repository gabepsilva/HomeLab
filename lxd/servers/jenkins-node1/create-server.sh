#/usr/bin/env bash


# Copy server profile to LXC host

scp lxd/servers/jenkins-node1/jenkins-node1-profile.yml bob.psilva.org:/tmp



# Create server profile and the server right after
ssh bob.psilva.org << EOF

    set -x

    lxc profile create jenkins-node1-profile.yml
    cat /tmp/jenkins-node1-profile.yml | lxc profile edit jenkins-node1-profile.yml

    lxc launch \
        -p conf-autostart-on.yml \
        -p disk-std.yml \
        -p network-lvl1.yml \
        -p jenkins-node1-profile.yml \
        images:ubuntu/focal/cloud jenkins-node1

EOF



ssh bob.psilva.org << EOF

    set -x


    #sleep 5
    #lxc list
    #    sleep 5
    #lxc list
    #    sleep 5
    #lxc list

    lxc exec jenkins-node1 -- sh -c "
    hostname
    htop
    date
    cat /tmp/oi
    apt-get update

    "

EOF

ssh bob.psilva.org << EOF


    lxc profile show jenkins-node1-profile.yml
    lxc delete jenkins-node1 --force
    lxc profile delete jenkins-node1-profile.yml

EOF

exit 1



 exec jenkins-node1 << EOF_NODE1
        date



    EOF_NODE1


LAST_OUTPUT=$?

if [ $LAST_OUTPUT -ne 0 ]
then
    exit $LAST_OUTPUT
fi

sleep 20

lxc restart jenkins-node1