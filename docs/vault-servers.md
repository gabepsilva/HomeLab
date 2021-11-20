# Vault Server1

## Specs

| hostname   | bob                  |
| :--------- | :------------------- |
| TYPE       | LXD Container        |
| HOST       | bob.psilva.org       |
| IP         | 192.168.50.11        |
| OS         | Ubuntu 20.04.3 LTS   |
| CPU        | no restrictions      |
| RAM        | no restrictions      |
| Disk       | volume mapped to host|

# Deploying Service

```bash
# Provision the LXC Vault container
ansible-playbook  lxd/servers/vault1/ansible-create-vault-server.yml -i ansible/inventory.yml --extra-vars "target=bob root_folder=${PWD}"
# Install and configure vault
ansible-playbook  ansible/servers/vault1.yml -i ansible/inventory.yml --extra-vars "user=$VAULT1_USER target=vault_server1 ansible_become_pass=${VAULT1_SUDO_PASS}" 
```

Since Ansible LXC module is not mature enouth we are using a bash script to create the server profile and start the container 


## Data to be backed up regularly

Vault folder


## Reference
https://devopscube.com/setup-hashicorp-vault-beginners-guide/







