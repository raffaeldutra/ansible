#!/usr/bin/env bash
#
# Purpose: Install Ansible for different Linux versions
#
# Rafael Dutra <raffaeldutra@gmail.com>
# https://rafaeldutra.me

if [ "${0}" != "configure.sh" ]; then
    echo "You need to call me directly from configure.sh script"
    exit 1
fi

sudo apt-get update
sudo apt-get --yes install python-pip python-dev libffi-dev libssl-dev

# --user installs packages local to the user account instead of globally to avoid
# permissions issues with Pip and the Linux Subsystem
pip install ansible --user

# add that to the $PATH
echo 'PATH=$HOME/.local/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
