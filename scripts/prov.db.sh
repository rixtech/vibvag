#!/bin/bash

# Install MySQL on Ubuntu, set a root password and secure the installation
# Called by vagrant up or vagrant provision

export DEBIAN_FRONTEND="noninteractive"

PW=$(openssl rand -base64 12)

cat<<End_PW>/root/.my.cnf
[client]
user=root
password=$PW
End_PW
chmod 0400 /root/.my.cnf

apt-get install debconf-utils
debconf-set-selections <<< "mysql-server mysql-server/root_password password $PW"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $PW"

apt-get install -y mysql-server 

# I suppose if I'm answering no to everything I needn't bother 
# echo -e "\n\n\n\n\n\n" | /usr/bin/mysql_secure_installation

# Tell MySQL to listen on its private IP (restart needed to enable)
pIP=`curl http://169.254.169.254/latest/meta-data/local-ipv4 2>/dev/null`
sed -i -e 's/^bind-address.*/bind-address = '$pIP'/' /etc/mysql/mysql.conf.d/mysqld.cnf
systemctl restart mysql.service

# Add a webservice user and test database
mysql<<EndSQL
USE mysql;
CREATE DATABASE testdb;
CREATE USER webapp IDENTIFIED BY 'webappPW';
GRANT ALL ON testdb.* TO 'webapp'@'%';
FLUSH PRIVILEGES;
USE testdb;
CREATE table test (c CHAR(255));
INSERT INTO test (c) VALUES ("hello world");
EndSQL





