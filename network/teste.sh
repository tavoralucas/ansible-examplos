#!/bin/bash

cat roles/network/templates/net-teste.json.old > roles/network/templates/net-teste.json

UUID=$(cat results/result.txt | awk '{print $1}')
sed -i "s/UUID/$UUID/" roles/network/templates/net-teste.json
