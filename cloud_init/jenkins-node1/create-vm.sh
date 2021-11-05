#!/bin/bash

#work with argumets later
INSTALL_NAME=jenkins_node1
INSTALL_NAME=$([ -z $1 ] && echo "test" || echo "$1")

qemu-img create -b ${HOME}/shares/isos/focal-server-cloudimg-amd64.img -f qcow2 -F qcow2 ./${INSTALL_NAME}.qcow2 10G

cloud-localds -v ./seed.img cloud_init.cfg


virt-install --name ${INSTALL_NAME} \
  --virt-type kvm --memory 2048 --vcpus 2 \
  --boot hd,menu=on \
  --disk path=./seed.img,device=cdrom \
  --disk path=./${INSTALL_NAME}.qcow2,device=disk \
  --graphics vnc \
  --os-type Linux --os-variant ubuntu20.04 \
  --network bridge:br0,mac="52:54:00:ad:69:44" \
  --memballoon model=virtio \
  --wait 0 \
  --console pty,target_type=serial

