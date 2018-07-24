#!/usr/bin/env bash
#
# Purpose: Install Ansible for different Linux versions
#
# Rafael Dutra <raffaeldutra@gmail.com>
# https://rafaeldutra.me

if [ $(whoami) = "root" ]; then
    echo "Hey $(whoami) my friend, please be root"
fi

linuxDistribution="$(lsb_release -i | sed 's/\t//g' | cut -d ":" -f2 | tr [A-Z] [a-z])"
linuxCodename="$(lsb_release -c | sed 's/\t//g' | cut -d ":" -f2)"

# Ubuntu flavors
function ubuntu()
{
    if [ ${linuxCodename} = "bionic" ]; then
        sudo apt-get update
        sudo apt-get install software-properties-common
        sudo apt-add-repository ppa:ansible/ansible
        sudo apt-get update
        sudo apt-get install ansible
    elif [ ${linuxCodename} = "trusty" ]; then
        sudo apt-get update
        sudo apt-get install python-software-properties
        sudo apt-add-repository ppa:ansible/ansible
        sudo apt-get update
        sudo apt-get install ansible
    else
        echo "Codename for this distribution not found"
        exit 1
    fi
}
    

# Debian flavors
function debian()
{
    if [ ${linuxCodename} = "squeeze" ]; then
        deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main
        
        sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
        sudo apt-get update
        sudo apt-get install ansible
    else
        echo "Codename for this distribution not found"
        exit 1
    fi
}

function installManPage()
{
    manName=homelab-ansible

    install -g 0 -o 0 -m 0644 ${manName} "${manPath}/${manName}.8"
    gzip --force "${manPath}/${manName}.8"
}

function install()
{
    case "${linuxDistribution}" in
        ubuntu ) ubuntu
		 manPath="/usr/share/man/man8" ;;
        debian ) debian
                 manPath="/usr/local/man/man8" ;;
    *)
        echo "Distribution ${linuxDistribution} is not listed"
    esac
}

function help()
{
    echo "For the entire documentation, access: man homelab-ansible"
}

case "$1" in
    -i | --install ) install
                     installManPage ;;
    -v | --version ) echo "Distribution: ${linuxDistribution} - ${linuxCodename}" ;;
*)
    help
esac
