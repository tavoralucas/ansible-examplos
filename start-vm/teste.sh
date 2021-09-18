#!/bin/bash

cat roles/start-vm/templates/start-vm.json.old > roles/start-vm/templates/start-vm.json

UUID=$(cat results/result.txt | awk '{print $1}')
sed -i "s/UUID/$UUID/" roles/start-vm/templates/start-vm.json
