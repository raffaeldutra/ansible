#!/usr/bin/env bash
#
# Purpose: Install Ansible for different Linux versions
#
# Rafael Dutra <raffaeldutra@gmail.com>
# https://rafaeldutra.me

# Include all files needed
if [[ "$OSTYPE" == "linux-gnu" ]] || [[ "$OSTYPE" == "darwin"* ]] || [[ "$OSTYPE" == "cygwin" ]]; then
    if [ $(whoami) != "root" ]; then
        echo "Hey $(whoami) my friend, please be root or run me using sudo"
        exit 1
    fi

    source $(pwd)/scripts/linux/environment.sh
elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
    if [ "x$(env | grep SESSIONNAME)" != "x" ]; then
        echo "Hey $(whoami) my friend, please run me as administrator"
	exit 1
    fi

    source $(pwd)/scripts/windows/environment.sh
else
    echo "Your Operational System is not supported for this script, leaving now..."
    exit 1
fi
