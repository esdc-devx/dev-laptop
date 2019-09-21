#!  /bin/bash

#Setup a dev laptop for Docker and Terraform development

apt-get update && 
apt-get install software-properties-common -y &&
apt-add-repository ppa:ansible/ansible -y &&
apt-get update && 
apt-get install ansible -y &&
ansible-playbook test.yml --connection=local
