#! /bin/bash -x
DROPNAME=$1
TOKEN_FILE=~/bin/digital-ocean-env.sh
source $TOKEN_FILE
ansible-playbook -i digital_ocean.py new-user-roles.yml --extra-vars="hosts=${DROPNAME}" -vv

