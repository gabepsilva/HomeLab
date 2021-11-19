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
ansible-playbook  ansible/general/installLxdProfiles.yml    -i ansible/inventory.yml --extra-vars "target=bob root_folder=${PWD} ansible_become_pass=${BECOME_PWD}"
ansible-playbook  ansible/general/reboot.yml                -i ansible/inventory.yml --extra-vars "user=$SERVER_USER target=bob ansible_become_pass=${BECOME_PWD}"
```

