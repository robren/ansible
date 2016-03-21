#! /bin/bash -x
DROPNAME=$1
TOKEN_FILE=~/bin/digital-ocean-env.sh
source $TOKEN_FILE
echo $0 $1 $2
#ansible-playbook  new-do-droplet.yml --extra-vars '"droplets":["$DROPNAME"]'
#echo "droplets":["${DROPNAME}"]
ansible-playbook -i digital_ocean.py  new-do-droplet.yml --extra-vars '{"droplets":['"${DROPNAME}"'], "desired_state":"deleted"}'
