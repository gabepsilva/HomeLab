# bob

## Specs


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






