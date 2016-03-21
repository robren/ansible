#! /bin/bash -x
DROPNAME=$1
TOKEN_FILE=~/bin/digital-ocean-env.sh
source $TOKEN_FILE
ansible-playbook  new-do-droplet.yml --extra-vars="droplets=${DROPNAME}"
