# SAMBA Shares

Since 1992, Samba has provided secure, stable and fast file and print services for all clients using the SMB/CIFS protocol, such as all versions of DOS and Windows, OS/2, Linux and many others.
Samba is an important component to seamlessly integrate Linux/Unix Servers and Desktops into Active Directory environments. It can function both as a domain controller or as a regular domain member. 

[samba.org](https://www.samba.org/)

## Specs


| Service | Pihole                           |
| :-------- | :--------------------------------- |
| TYPE    | LXC Container                    |
| HOST    | captain                          |
| IP      | 192.168.50.8                     |
| OS      | Ubuntu Focal                     |
| CPU     | no restrictions                  |
| RAM     | no restrictions                  |
| Disk    | volume: /hdd-pool/               |



## Deploying

Just apply [this Ansinble playbook](https://github.com/gabrielpsilva/HomeLab/blob/main/virtual-servers/pihole.yml) to the host

## LXD Version
```bash
# 1 - Provision the LXD container
# 2 - Install samba server
ansible-playbook services/samba/lxd/1-create-samba-container.yml -i ansible/inventory.yml --extra-vars="target=captain root_folder=${PWD}" 
sleep 15 
ansible-playbook services/samba/lxd/2-install-samba-server.yml    -i ansible/inventory.yml --extra-vars="user=${SAMBA_USER} ansible_become_pass=${SAMBA_SUDO_PASS} root_folder=${PWD}" 
ansible-playbook services/samba/lxd/3-setup-users.yml             -i ansible/inventory.yml --extra-vars="ansible_become_pass=${SAMBA_SUDO_PASS}" 
```

 **You might need to set permissions on the shares**