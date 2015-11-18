#!/bin/bash

function line() {
	printf '%*s' $2 | tr ' ' "$1"
	printf "\n"
}

function message() {
	size=$((${#1} + 2))
	echo
	line "=" $size
	echo " $1"
	line "=" $size
	echo
}

function error() {
	echo "Aborted. $1"
	exit 1
}

function is_exists() {
	FILE=$(command -v $1)
	[ ! -z "$FILE" ] && [ -e "$FILE" ] && return 0 || return 1
}

function version() {
	VER=$($1 $2)
	[ ! -z "$VER" ] && return 0 || return 1
}

##VER="$($FILE $2)"
#		[ -z "$VER" ] && return 1 ||


message "Neo4j-Browser With Custom UI Prerequisition Script (Ubuntu 14.04 x86_64)"

if [ $(whoami) != "root" ]; then
	error "This script requires root privileges."
fi

ARCH=$(uname -m)

if [ -f /etc/lsb-release ]; then
    OS=$(lsb_release -si)
    VER=$(lsb_release -sr)
elif [ -f /etc/debian_version ]; then
    OS=Debian  # XXX or Ubuntu??
    VER=$(cat /etc/debian_version)
else
    OS=$(uname -s)
    VER=$(uname -r)
fi

if [ $OS != "Ubuntu" ] || [ $ARCH != "x86_64" ] || [ $VER != "14.04" ]; then
	read -p "This script requires Ubuntu 14.04 (x86_64), and your system is $OS $VER ($ARCH). Should we continue? [y/N]?" -r RESP
else
	read -p "This script will install packages, required for Neo4j-Browser compilations. Continue [y/N]?" -r RESP
fi

if ( is_exists "node" ) && ( ! version "node" "--version" ); then 
        read -p "The script has detected incorrect Node version installed on this machine. To continue, this node version have to be purget. Continue? [y/N]?" -r RESP

        if [[ ! $RESP =~ ^[Yy]$ ]]; then
                error
        fi

        apt-get --purge -y remove node nodejs nodejs-legacy
#        apt-get --purge -y remove nodejs
#	apt-get --purge -y remove nodejs-legacy

        if [ -e /usr/bin/node ]; then
                rm /usr/bin/node
        fi

	hash -d node
fi


if [[ ! $RESP =~ ^[Yy]$ ]]; then
	error
fi

if ( ! is_exists "git"); then 
	message "Installing Git"

	apt-get install -y git

	message "Done"
fi

if ( ! version "git" "-version" ); then
	error "Error in Git installation"
else
	message "Git Version: $VER"
fi

if ( ! is_exists "java" ); then #
	message "Installing JDK"

	apt-get install -y openjdk-7-jdk

	message "Done"
fi

if ( ! version "java" "-version" ); then
	error "Error in JDK installation"
else
	message "JDK Version: $VER"
fi


if ( ! is_exists "mvn" ); then #
	message "Installing Maven"

	apt-get install -y maven

	message "Done"
fi

if ( ! version "mvn" "-version" ); then
	error "Error in Maven installation"
else
	message "Maven Version: $VER"
fi


if ( ! is_exists "node" ); then #
	message "Installing Node.JS"

	apt-get install -y nodejs nodejs-legacy

	message "Done"
fi

if ( ! version "node" "--version" ); then
	error "Error in Node installation"
else
	message "Node Version: $VER"
fi


if ( ! is_exists "npm" ); then #
	message "Installing NPM"

	apt-get install -y npm

	message "Done"
fi

if ( ! version "npm" "-version" ); then
	error "Error in NPM installation"
else
	message "NPM Version: $VER"
fi

message "Updating Node.JS modules"

npm install -g npm 
npm install -g grunt-cli
npm install -g bower

message "SUCCESS"
