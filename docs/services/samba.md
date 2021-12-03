# Pihole DNS

Pi-hole is a Linux network-level advertisement and Internet tracker blocking application which acts as a DNS sinkhole and optionally a DHCP server, intended for use on a private network. It is designed for low-power embedded devices with network capability, such as the Raspberry Pi, but supports any Linux machines.

[Wikipedia](https://https://en.wikipedia.org/wiki/Pi-hole)

## Specs


| Service | Pihole                           |
| :-------- | :--------------------------------- |
| TYPE    | Docker Container                 |
| HOST    | captain                          |
| IP      | 192.168.50.4                     |
| OS      | dockerhub pihole/pihole          |
| CPU     | no restrictions                  |
| RAM     | no restrictions                  |
| Disk    | volume: /hdd-pool/appdata/pihole |

## Deploying

Just apply [this Ansinble playbook](https://github.com/gabrielpsilva/HomeLab/blob/main/virtual-servers/pihole.yml) to the host

## LXD Version
```bash
# Provision the LXD container
ansible-playbook services/samba/lxd/1-create-samba-container.yml -i ansible/inventory.yml --extra-vars="target=captain root_folder=${PWD}"
# Install samba server
ansible-playbook services/samba/lxd/2-install-samba-server.yml    -i ansible/inventory.yml --extra-vars="user=${SAMBA_USER} ansible_become_pass=${SAMBA_SUDO_PASS}" 

# configure jenkins master before continuing ...

# Install Jenkins node1 after master is properly configured
ansible-playbook  servers/jenkins/3-install-jenkins-node1.yml    -i ansible/inventory.yml --extra-vars "target=jenkins_node1 master_secret=$AGENT_SECRET user=$JK_NODE1_USER ansible_become_pass=${JK_NODE1_SUDO_PASS}"
ansible-playbook  ansible/general/installDocker.yml              -i ansible/inventory.yml --extra-vars "user=$JK_NODE1_USER target=jenkins_node1 ansible_become_pass=${JK_NODE1_SUDO_PASS}" 
ansible-playbook  ansible/general/reboot.yml                     -i ansible/inventory.yml --extra-vars "target=jenkins_node1 user=$JK_NODE1_USER ansible_become_pass=${JK_NODE1_SUDO_PASS}"

```

After the container creation log into it and change the admin passowrd.

```bash
ssh captain.psilva.org
docker exec -it pihole bash
pihole -a -p
```

## DNS Records


| servername           | host    | type     | IP             |
| :--------------------- | :-------- | ---------- | :--------------- |
| bob.psilva.org       |         | physical | 192.168.50.172 |
| captain.psilva.org   |         | physical | 192.168.50.220 |
| jenkins.psilva.org   | captain | docker   | 192.168.50.9   |
| pihole.psilva.org    | captain | docker   | 192.168.50.4   |
| plex.psilva.org      | captain | docker   | 192.168.50.6   |
| speedtest.psilva.org | captain | docker   | 192.168.50.8   |
| vault1.psilva.org    | captain | docker   | 192.168.50.11  |
| docs.psilva.org      | captain | docker   | 192.168.50.2   |

## Backup Plan

Backup the folder `captain.psilva.org:/hdd-pool/appdata/jenkins`
