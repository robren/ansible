# Ansible playbooks and tools
A repo for usefull Ansible playbooks and roles, 

It covers:
- Installing Ansible
- Creating a default programming environment in an existing  (manually
  created from the Digital Ocean Web UI) droplet
- Programmatically creating  and deleting droplets
- Creating a nice environment within these dynamic droplets

## Installation of Ansible

If ansible is installed from the the repos included in Ubuntu 14.04 (even
after apt-get update) you'll get ansible version 1.5.4, this is from April
2014!! That's ancient.

Ansible has had numerous big fixes and improvements in the last 2 years, in
fact I had lots of issues with ssh permissions in the older versions.

I recommend you install the ansible ppa. This way you can get, as of Feb 2016,
ansible version 2.0.0.2. Much nicer.

    sudo apt-get update
    sudo apt-get install software-properties-common

Then add the ppa

    sudo apt-add-repository ppa:ansible/ansible

Now we can install a recent version of ansible

    sudo apt-get update
    sudo apt-get install ansible

The file new-user.yml maybe used to setup a nice environment with 
zsh vim and a decent set of vim modules.

The Digital Ocean  droplet has to be pre-created and have our local machines
ssh public key added to the Digital Ocean account. (this only has to be done
once, since new machines will can all be preconfigured, via a gui checkbox
during droplet creation, to accept our public key).

The script as it stands could work for any machine we can ssh into.

## Creation of a new user within a preexisting droplet

The initial setup uses a single playbook new-user.yml

- Edit the variables in the new-user.yml e.g 
    - hosts
    - user
    - The password
- Make sure you've got an local ssh public key file
  e.g ~/.ssh/id_rsa.pub

Then run "ansible-playbook new-user.yml" 

# Role Based Droplet Configuration
For the ansible roles based playbook to create a new-user in an existing
droplet run the new-user-roles playbook.
    > ansible-playbook new-user-roles.yml 


# Droplet Programmatic Creation and Destruction
To create a droplet programatically I've created an additional playbook
new-do-droplet.yml

## Droplet Creation
Here we pass in via the CLI, the values of the droplets dictionary. This being a local
variable containing the names of all of the droplets we wish to create. This
overrides any variables we have in the playbook

This uses localhost to communicate with digital-ocean. It does require the use
of a TOKEN, this is passed into playbook via an environment variable

- From the Digital Ocean web interface you can obtain your secret TOKEN. Stick this in a
  shell script and export it. Or given that it needs to be in the dynamic
  inventory script new_do_droplet.in then stick in in there and run 
  > 

  > env | grep TOK
  DO_API_TOKEN=XXXXXYYYYYZZZZZZ6e40e31b39df26a9f4a83e89acb63ea18d54bf94252ce2c6


    > ansible-playbook  new-do-droplet.yml --extra-vars\
    '{"droplets":["dotest12","dotest13"]}'

## Digital Ocean Dynamic inventory script digital_ocean.py

From https://github.com/ansible/ansible/contrib/inventory

This will query digital ocean's API ( v2.0) and obtain information about
droplets we have associated with an account. This account being represented by
a specific TOKEN.
- digital_ocean.py has a companion file digital_ocean.ini where this must be
  added to.

> ./digital_ocean.py
{"distro_Ubuntu": ["10.132.20.97", "198.211.98.32", "198.211.99.38",
"198.211.101.88", "198.211.100.157"], "do-test2": ["10.132.20.97"],
"size_512mb": ["10.132.20.97", "198.211.98.32", "198.211.99.38",
"198.211.101.88", "198.211.100.157"], "11597639": ["198.211.101.88"],
"11581992": ["198.211.98.32"], "11597673": ["198.211.100.157"], "dotest4":
["198.211.99.38"], "status_active": ["10.132.20.97", "198.211.98.32",
"198.211.99.38", "198.211.101.88", "198.211.100.157"], "11583141":
["198.211.99.38"], "dotest3": ["198.211.98.32"], "image_ubuntu-14-04-x64":
["198.211.98.32", "198.211.99.38", "198.211.101.88", "198.211.100.157"],
"region_nyc3": ["10.132.20.97"], "region_nyc1": ["198.211.98.32",
"198.211.99.38", "198.211.101.88", "198.211.100.157"], "image_15943679":
["198.211.98.32", "198.211.99.38", "198.211.101.88", "198.211.100.157"],
"image_14.04.3_x64": ["10.132.20.97"], "dotest13": ["198.211.100.157"],
"dotest12": ["198.211.101.88"], "image_15828882": ["10.132.20.97"],
"11366181": ["10.132.20.97"]}

This script is used as a stand-in for the ansible host or inventory file and
outputs a bunch of JSON which the ansible and ansible-playbook commands
understand.

We'll see the use of this next 

## Droplet Deletion

- Note, the variable I added "desired_state" so that we can use the same
  new-do-droplet playbook for both creation and deletion of droplets
> ansible-playbook -i digital_ocean.py  new-do-droplet.yml --extra-vars \
'{"droplets":["dotest12","dotest13"], "desired_state":"deleted"}'

## Adding a default environment to the new droplets
Using the dynamic inventory script in conjunction witht our existing
new-user-roles playbook 

> ansible-playbook -i digital_ocean.py new-user-roles.yml --extra-vars 'hosts=dotest9'

# Future Tasks

 - Ansible and containers?
   - But we have docker-engine to explore for that!



