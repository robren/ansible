#! /bin/bash -x
DROPNAME=$1
TOKEN_FILE=~/bin/digital-ocean-env.sh
source $TOKEN_FILE
ansible-playbook  new-do-droplet.yml --extra-vars="droplets=${DROPNAME}" -vv

# Hack to avoid occasional failure of the new-user-script. Could presumably
# fix by making one integrated playbook. For the moment ignore since soo much
# time is spent mucking about with ansible foibles. 
#echo "Sleeping for 10s"
#sleep 10

ansible-playbook -i digital_ocean.py new-user-roles.yml --extra-vars="hosts=${DROPNAME}" -vvv

./digital_ocean.py
