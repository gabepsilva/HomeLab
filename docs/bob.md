# bob

## Specs


| hostname | bob                |
| :--------- | :------------------- |
| IP       | 192.168.50.172     |
| OS       | Ubuntu 20.04.3 LTS |
| CPU      | Intel Core I5 3470 |
| RAM      | 8G DDR3            |
| Disk     | 1 SSD 240G - ext4  |
| Ethernet | 1Gb/s              |
| PCI      | none               |
| USB      | none               |

## OS Installation

In case I need to recreate the server due to some disaster follow the steps bellow:

* Insert the **bob server flash drive** and let it install
  bob flash drive will install Ubuntu 20.04.3 LTS in unattended mode using the configs listed here
  https://github.com/gabrielpsilva/HomeLab...unattended-user-data.yml

  the documentation to create this unattended installation flash drive:
  [https://gist.github.com/hmenke/5b7519aa7eea1d1d231ef6df65bfeb79step-by-step]

  The default user password should be well stored im my password manager and the installation also adds my public into **~/.ssh/authorized-keys**
* After the installation run the following playbooks:

```bash
export SERVER_USER=<bob user>
export BECOME_PWD=<password>
ansible-playbook  ansible/general/installUtils.yml          -i ansible/inventory.yml --extra-vars "user=$SERVER_USER target=bob ansible_become_pass=${BECOME_PWD}"
ansible-playbook  ansible/general/installDocker.yml         -i ansible/inventory.yml --extra-vars "user=$SERVER_USER target=bob ansible_become_pass=${BECOME_PWD}" 
ansible-playbook  ansible/general/installVirtualization.yml -i ansible/inventory.yml --extra-vars "user=$SERVER_USER target=bob ansible_become_pass=${BECOME_PWD}"

```

* ssh into the server and execute 

```bash
lxd init

Would you like to use LXD clustering? (yes/no) [default=no]: 
Do you want to configure a new storage pool? (yes/no) [default=yes]: 
Name of the new storage pool [default=default]: 
Name of the storage backend to use (dir, lvm, zfs, ceph, btrfs) [default=zfs]: zfs
Create a new ZFS pool? (yes/no) [default=yes]: 
Would you like to use an existing empty block device (e.g. a disk or partition)? (yes/no) [default=no]: 
Size in GB of the new loop device (1GB minimum) [default=30GB]: 200GB
Would you like to connect to a MAAS server? (yes/no) [default=no]: 
Would you like to create a new local network bridge? (yes/no) [default=yes]: no
Would you like to configure LXD to use an existing bridge or host interface? (yes/no) [default=no]: yes
Name of the existing bridge or host interface: br0
Would you like the LXD server to be available over the network? (yes/no) [default=no]: yes
Address to bind LXD to (not including port) [default=all]: 
Port to bind LXD to [default=8443]: 
Trust password for new clients: 
Again: 
Would you like stale cached images to be updated automatically? (yes/no) [default=yes] 
Would you like a YAML "lxd init" preseed to be printed? (yes/no) [default=no]: 
```
then come and execute the last Ansible playbook
```bash
ansible-playbook  ansible/general/installLxdProfiles.yml -i ansible/inventory.yml --extra-vars "target=bob root_folder=${PWD} ansible_become_pass=${BECOME_PWD}"
```

Password is stored in my password manager as **lxd-trust-pwd**

Done!

We now we are ready to start qemu vms, LXD and Docker containers
