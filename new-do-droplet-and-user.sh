#! /bin/bash -x
DROPNAME=$1
TOKEN_FILE=~/bin/digital-ocean-env.sh
source $TOKEN_FILE
ansible-playbook  new-do-droplet.yml --extra-vars="droplets=${DROPNAME}"

# Hack but otherwise I'm down for combininig the playbooks
#echo "Sleeping for 10s"
#sleep 10

ansible-playbook -i digital_ocean.py new-user-roles.yml --extra-vars="hosts=${DROPNAME}" -vv

./digital_ocean.py
