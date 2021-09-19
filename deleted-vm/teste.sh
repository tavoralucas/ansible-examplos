#!/bin/bash

cat roles/deleted-vm/templates/deleted-vm.json.old > roles/deleted-vm/templates/deleted-vm.json

UUID=$(cat results/result.txt | awk '{print $1}')
sed -i "s/UUID/$UUID/" roles/deleted-vm/templates/deleted-vm.json
