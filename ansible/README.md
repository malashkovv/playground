# Ansible Playgroud #

### What to do ###

To start:
Do `vagrant up` and `vagrant ssh acs`. 

Simple commands:
To provision datacenter do `ansible-playbook site.yml -i prod`. 
You can use `ansible datacenter -i prod -m shell -a "echo hello"` in order to test simple ansible command.
To run playbook against hosts do `ansible-playbook playbooks/ping.yml -i prod`

