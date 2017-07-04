#!/bin/bash

# Install MySQL on Ubuntu
# Called by vagrant up or vagrant provision

export DEBIAN_FRONTEND="noninteractive"

debconf-set-selections <<< "mysql-server-5.6 mysql-server/root_password password mytemppw"
debconf-set-selections <<< "mysql-server-5.6 mysql-server/root_password_again password mytemppw"

apt-get install -y mysql-server


