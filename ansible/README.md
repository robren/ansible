A repo for usefull Ansible plays, playlist, playbooks

The file new-douser.yml maybe used to setup a nice environment with 
zsh vim and a decent set of vim modules.

douser standing for Digital Ocean User.

As the script stands ( Feb 22 2016 ) the DO droplet has to be pre-created and
have our local machines ssh public key added to the DO account. ( this only
has to be done once, since new machines will all be preconfigured to accept
our public key).

In later releases I'll investigate the ability to spin-up a droplet
rprogramatically ( If I deem it worthy).

The script as it stands could work for any machine we can ssh into.
