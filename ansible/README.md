A repo for usefull Ansible playbooks and roles, 

If ansible is installed from the the repos included in Ubuntu 14.04 ( even
after apt-get update) you'll get ansible of version  1.5.4, this is  from April 2014 !! 

Ansible has had numerous big fixes and improvements in the last 2 years, in
face I had lots of issues with ssh permissions in the older versions.

I recommend you install the ansible ppa. This way you can get, as of Feb 2016
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

douser standing for Digital Ocean User.

As the script stands (Feb 22 2016) the Digital Ocean  droplet has to be
pre-created and has our local machines ssh public key added to the Digital
Ocean account. (this only has to be done once, since new machines will all be
preconfigured to accept our public key).

The script as it stands could work for any machine we can ssh into.

## Configuration

The initial setup uses a single playbook new-user.yml

Edit the variables in the new-user.yml e.g 
- hosts
- user
- The password


# Future Tasks

In later submissions, I'll convert this playbook into using roles. The use of
roles will facilitate additional playbooks reusing aspects of this common
playbook without the need of cut 'n paste.

Potentially I'll investigate the ability to spin-up a droplet
programatically,although spinnig 'em up is relatively painless. 


