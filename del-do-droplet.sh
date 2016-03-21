#! /bin/bash -x
DROPNAME=$1
TOKEN_FILE=~/bin/digital-ocean-env.sh
source $TOKEN_FILE
echo $0 $1 $2
# Note the tricky use of terminating the single quote so that the S{DROPNAME}
# can be expanded. The quotes are then restarted
ansible-playbook -i digital_ocean.py  new-do-droplet.yml --extra-vars '{"droplets":['"${DROPNAME}"'], "desired_state":"deleted"}'
