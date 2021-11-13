#!/bin/bash

#work with argumets later
INSTALL_NAME=vault-server1
INSTALL_NAME=$([ -z $1 ] && echo "test" || echo "$1")

SERVER_ROOT=${HOME}/domains/${INSTALL_NAME}
mkdir -p ${SERVER_ROOT}

qemu-img create -b ${HOME}/shares/isos/focal-server-cloudimg-amd64.img -f qcow2 -F qcow2 ${SERVER_ROOT}/${INSTALL_NAME}.qcow2 10G
cloud-localds -v ${SERVER_ROOT}/seed.img cloud_init.cfg


virt-install --name ${INSTALL_NAME} \
  --virt-type kvm --memory 2014 --vcpus 1 \
  --boot hd,menu=on \
  --disk path=${SERVER_ROOT}/seed.img,device=cdrom \
  --disk path=${SERVER_ROOT}/${INSTALL_NAME}.qcow2,device=disk \
  --graphics vnc \
  --os-type Linux --os-variant ubuntu20.04 \
  --network bridge:br0,mac="52:54:00:ad:69:45" \
  --memballoon model=virtio \
  --wait 0 \
  --console pty,target_type=serial

