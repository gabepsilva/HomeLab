# Jenkins Master

## Specs

| hostname   | bob                  |
| :--------- | :------------------- |
| TYPE       | Docker Container        |
| HOST       | jenkins.psilva.org       |
| IP         | 192.168.50.10        |
| OS         | -   |
| CPU        | no restrictions      |
| RAM        | no restrictions      |
| Disk       | volume mapped to host|

## LXD Version
```bash
# Provision the LXD containers for Jenkins Master and Node1
ansible-playbook servers/jenkins/1-create-jenkins-containers.yml -i ansible/inventory.yml --extra-vars="target=bob root_folder=${PWD}"
# Install Jenkins on the master
ansible-playbook servers/jenkins/2-install-jenkins-master.yml    -i ansible/inventory.yml --extra-vars="user=${JK_MASTER_USER} ansible_become_pass=${JK_MASTER_SUDO_PASS}" 

# configure jenkins master before continuing ...

# Install Jenkins node1 after master is properly configured
ansible-playbook  servers/jenkins/3-install-jenkins-node1.yml    -i ansible/inventory.yml --extra-vars "target=jenkins_node1 master_secret=$AGENT_SECRET user=$JK_NODE1_USER ansible_become_pass=${JK_NODE1_SUDO_PASS}"
ansible-playbook  ansible/general/installDocker.yml              -i ansible/inventory.yml --extra-vars "user=$JK_NODE1_USER target=jenkins_node1 ansible_become_pass=${JK_NODE1_SUDO_PASS}" 
ansible-playbook  ansible/general/reboot.yml                     -i ansible/inventory.yml --extra-vars "target=jenkins_node1 user=$JK_NODE1_USER ansible_become_pass=${JK_NODE1_SUDO_PASS}"

```

```bash
### Node2
ansible-playbook  services/jenkins/lxd/node2/1-create-node2-vm.yml -i ansible/inventory.yml --extra-vars="target=captain root_folder=${PWD}"
ansible-playbook  ansible/general/installUtils.yml                 -i ansible/inventory.yml --extra-vars "user=$JK_NODE1_USER target=jenkins_node2 ansible_become_pass=${JK_NODE1_SUDO_PASS}"
ansible-playbook  ansible/general/installDocker.yml                -i ansible/inventory.yml --extra-vars "user=$JK_NODE1_USER target=jenkins_node2 ansible_become_pass=${JK_NODE1_SUDO_PASS}" 
ansible-playbook  services/jenkins/setup-jenkins-node.yml          -i ansible/inventory.yml --extra-vars "target=jenkins_node2 node_name=node2 master_secret=$AGENT_SECRET_NODE2 user=$JK_NODE1_USER ansible_become_pass=${JK_NODE1_SUDO_PASS}"
ansible-playbook  ansible/general/reboot.yml                     -i ansible/inventory.yml --extra-vars "target=jenkins_node2 user=$JK_NODE1_USER ansible_become_pass=${JK_NODE1_SUDO_PASS}"
```

# Docker Version
```bash
# Provision the LXC Jenkins Master Docker container 
ansible-playbook  services/jenkins/docker/jenkins_master.yml -i ansible/inventory.yml --extra-vars "target=captain"

# intsall default-jre in the remote node
wget http://jenkins.psilva.org:8080/jnlpJars/agent.jar
java -jar agent.jar -jnlpUrl http://jenkins.psilva.org:8080/computer/node1/jenkins-agent.jnlp -secret @jenkins_remote_secret -workDir "/tmp/jenkins_remote_root"

```

Now you can login into your new server at 
http://jenkins.psilva.org:8080



# Jenkins Node1

## Specs

| hostname   | bob                  |
| :--------- | :------------------- |
| TYPE       | LXD Container        |
| HOST       | jenkins-node1.psilva.org       |
| IP         | 192.168.50.12        |
| OS         | Ubuntu 20.04.3 LTS   |
| CPU        | no restrictions      |
| RAM        | no restrictions      |
| Disk       | volume mapped to host|

# Deploying Service

```bash
# Provision Jenkins node1 LXC container
ansible-playbook  lxd/servers/jenkins-node1/ansible-create-node1.yml -i ansible/inventory.yml --extra-vars "target=bob root_folder=${PWD}"
# Install agent.jar and configure it
ansible-playbook  ansible/servers/jenkins_master_setup.yml -i ansible/inventory.yml --extra-vars "master_secret=$AGENT_SECRET user=$JK_NODE1_USER" 
ansible-playbook  ansible/general/reboot.yml               -i ansible/inventory.yml --extra-vars "target=jenkins_node1 user=$JK_NODE1_USER ansible_become_pass=${JK_NODE1_SUDO_PASS}"
```

Since Ansible LXC module is not mature enouth we are using a bash script to create the server profile and start the container 


no password for sudo ?

## Data to be backed up regularly

Vault folder


## Reference
https://devopscube.com/setup-hashicorp-vault-beginners-guide/







jenkins_node1 is an LXD container running on bob server with no memory or cpu restriction

## Data to backup regularly

None all data in this server is disposable

## Manual Installation Checklist


*  Copy server owner public ssh key to known_hosts

```bash
export SERVER_USER=<user name>
ssh-copy-id $SERVER_USER@bob.psilva.org
```

* Run Ansible Playbooks:

```bash
export SERVER_USER=<user name>
ansible-playbook  installUtils.yml -i inventory.yml -K --extra-vars "user=$SERVER_USER target=bob"
ansible-playbook  installDocker.yml -i inventory.yml -K --extra-vars "user=$SERVER_USER target=jenkins_node1" 
```


#@reboot java -jar agent.jar -jnlpUrl 'http://192.168.50.10:8080/computer/node1/jenkins-agent.jnlp' -secret @/home/jenkins/jk-secret-file -workDir /home/jenkins/jenkins-workspaces


set node server to auto start agent server (agent server has a secret given on agent setup in master)
```
@reboot java -jar agent.jar -jnlpUrl 'http://192.168.50.10:8080/computer/node1/jenkins-agent.jnlp' -secret @/home/jenkins/jk-secret-file -workDir /home/jenkins/jenkins-workspaces
```

* no need to  -- copy github ssh key from vault to jenkins-node under jenkins user: just add token as user and password
* 0 buiilds on master

* creage gh token and add to to jenkins as user pass
* configure public webhook.
* put firewall in place to drop all connections

except
webhook from gh
jk master no nodes
http to master
ssh from internal to master and slave

configure jenkins to build using containers


*jenkins build in docker containers






