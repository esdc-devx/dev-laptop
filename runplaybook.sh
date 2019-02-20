#! /bin/sh
sudo ansible-galaxy install -r ./requirements.yml --force
sudo ansible-playbook playbook.yml --connection=local
