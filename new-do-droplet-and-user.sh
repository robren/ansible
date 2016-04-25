#! /bin/bash -x

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 desired-host-name" >&2
    exit 1
fi
DROPNAME=$1
TOKEN_FILE=~/bin/digital-ocean-env.sh
source $TOKEN_FILE
ansible-playbook  new-do-droplet.yml --extra-vars="droplets=${DROPNAME}" -vv

# Hack to avoid occasional failure of the new-user-script. Creation returns
# success but ssh problems when immediately sshing in.  Could presumably
# fix by making one integrated playbook. For the moment ignore since soo much
# time is spent 'mucking' about with ansible foibles. 
echo "Sleeping for 10s"
sleep 10

ansible-playbook -i digital_ocean.py new-user-roles.yml --extra-vars="hosts=${DROPNAME}" -vvv

# Prints out the inventory of machines we have on Digital Ocean
./digital_ocean.py
