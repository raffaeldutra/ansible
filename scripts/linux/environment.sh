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

linuxDistribution="$(lsb_release -i | sed 's/\t//g' | cut -d ":" -f2 | tr [A-Z] [a-z])"
linuxCodename="$(lsb_release -c | sed 's/\t//g' | cut -d ":" -f2)"

function checkRequiredPackages()
{
    sudo dpkg -s openssh-server >/dev/null 2>/dev/null

    if [ $? -ne 0 ]; then
        echo "Installing openssh-server"

        sudo apt-get update
	      sudo apt-get install openssh-server --yes
    fi
}

function ansibleInstalled()
{
    $(which ansible 2>&1 > /dev/null) && ansibleInstalled=1 || ansibleInstalled=0

    if [ ${ansibleInstalled} -eq 1 ]; then
        echo "Ansible is already installed"
        exit 1
    fi
}

# Ubuntu flavors
function ubuntu()
{
    if [ ${linuxCodename} = "bionic" ]; then
        sudo apt-get update
        sudo apt-get install software-properties-common --yes

	if [ ! -f "/etc/apt/sources.list.d/ansible-ubuntu-ansible-bionic.list" ]; then
        sudo apt-add-repository ppa:ansible/ansible --yes
	fi

        sudo apt-get update
        sudo apt-get install ansible --yes
    elif [ ${linuxCodename} = "trusty" ]; then
        sudo apt-get update
        sudo apt-get install python-software-properties --yes
        sudo apt-add-repository ppa:ansible/ansible --yes
        sudo apt-get update
        sudo apt-get install ansible --yes
    else
        echo "Codename for this distribution not found"
        exit 1
    fi
}

# Debian flavors
function debian()
{
    if [ ${linuxCodename} = "squeeze" ]; then
        #deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main

        sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
        sudo apt-get update
        sudo apt-get install ansible --yes
    else
        echo "Codename for this distribution not found"
        exit 1
    fi
}

function installManPage()
{
    manName=homelab-ansible

    sudo install -g 0 -o 0 -m 0644 "man/${manName}" "${manPath}/${manName}.8"
    sudo gzip --force "${manPath}/${manName}.8"
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
    -i | --install ) ansibleInstalled
                     checkRequiredPackages
                     install
                     installManPage ;;
    -f | --force )   checkRequiredPackages
                     install
                     installManPage ;;
    -v | --version ) echo "Distribution: ${linuxDistribution} - ${linuxCodename}" ;;
*)
    help
esac
