#!/bin/bash

cat roles/config-vm/templates/new-disk-to-vm.json.old > roles/config-vm/templates/new-disk-to-vm.json

UUID=$(cat /root/vmware-novo/clone/result.txt | awk '{print $1}')
sed -i "s/UUID/$UUID/" roles/config-vm/templates/new-disk-to-vm.json

