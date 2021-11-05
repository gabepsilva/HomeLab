


    virt-install \ 
  --name guest1-rhel7 \ 
  --memory 2048 \ 
  --vcpus 1 \ 
  --disk size=8 \ 
  --cdrom /path/to/rhel7.iso \ 
  --os-variant rhel7 





cd ${HOME}/domains/jenkins-node1
qemu-img create -b ${HOME}/shares/isos/focal-server-cloudimg-amd64.img -f qcow2 -F qcow2 jenkins-node1.qcow2 10G

qemu-img info snapshot-ubuntu-20.04.3-live-server-amd64.qcow2

cloud-localds -v seed.img cloud_init.cfg
qemu-img info seed.img



virt-install --name test1 \
  --virt-type kvm --memory 2048 --vcpus 2 \
  --boot hd,menu=on \
  --disk path=${HOME}/domains/jenkins-node1/seed.img,device=cdrom \
  --disk path=${HOME}/domains/jenkins-node1/jenkins-node1.qcow2,device=disk \
  --location='http://archive.ubuntu.com/ubuntu/dists/focal/main/installer-amd64/' \
  --graphics vnc \
  --os-type Linux --os-variant ubuntu20.04 \
  --network=bridge:br0 \
  --console pty,target_type=serial