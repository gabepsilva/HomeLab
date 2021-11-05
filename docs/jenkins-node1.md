# bob

## Specs


| hostname      | bob     |
| :--------- | :------------------- |
| IP       | 192.168.50.172     |
| OS       | Ubuntu 20.04 LTS   |
| CPU      | Intel Core I5 3470 |
| RAM      | 8G DDR3            |
| Disk     | TDB (1 SSD 240G)   |
| Ethernet | 1Gb/s              |
| PCI      | none               |
| USB      | none               |

## Manual Installation Checklist

In case I need to recreate the server due to some disaster (or for fun).

*  Copy server owner public ssh key to known_hosts

```bash
export SERVER_USER=<user name>
ssh-copy-id $SERVER_USER@bob.psilva.org
```

* Run Ansible Playbooks:

```bash
export SERVER_USER=<user name>
ansible-playbook  installDocker.yml -i inventory.yml -K --extra-vars "user=$SERVER_USER target=bob"
ansible-playbook  installUtils.yml -i inventory.yml -K --extra-vars "user=$SERVER_USER target=bob"
ansible-playbook  installVirtualization.yml -i inventory.yml -K --extra-vars "user=$SERVER_USER target=bob"
```
