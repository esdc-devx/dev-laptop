#!  /bin/bash

#Setup a laptop for Ionic Development

apt-get update && 
apt-get install software-properties-common -y &&
apt-add-repository ppa:ansible/ansible -y &&
apt-get update && 
apt-get install ansible -y &&
ansible-playbook test.yml --connection=local
