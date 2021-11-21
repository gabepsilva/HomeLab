SHELL=/usr/bin/env bash


help:	## Show this help
		@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

source-secrets: ## Load my secrets as env variables
	source ~/secrets/*

hash-linux-pass: ## Hashes the value in the parameter 'pass' ie. make hash-linux-pass pass=strongpass
	@echo ${pass} | mkpasswd -m sha-512 -s        


clean-known-hosts: ## Clear some host´s keys
	@ssh-keygen -R bob.psilva.org
	@ssh-keygen -R vault.psilva.org
	@ssh-keygen -R jenkins.psilva.org
	@ssh-keygen -R jenkins-node1.psilva.org
