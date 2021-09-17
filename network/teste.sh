#!/bin/bash

cat roles/network/templates/net-teste.json.old > roles/network/templates/net-teste.json

UUID=$(cat /root/vmware-novo/clone/result.txt | awk '{print $1}')
sed -i "s/UUID/$UUID/" roles/network/templates/net-teste.json
