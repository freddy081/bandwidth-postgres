#!/bin/bash
ansible-playbook -i /home/test/fortigate/inventory.ini /home/test/fortigate/bandwidth.yml --vault-password-file /home/test/.vault_pass.txt
