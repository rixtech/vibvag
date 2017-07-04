#!/bin/bash

# Install Apache and PHP on Ubuntu
# Called by vagrant up or vagrant provision

apt-get update
apt-get install -y apache2 php libapache2-mod-php php-mcrypt php-mysql debconf-utils
usermod -a -G www-data ubuntu
echo '<?php phpinfo(); ?>' > /var/www/html/phpinfo.php
chown -R ubuntu:www-data /var/www

echo "==========================================================="
echo -e "\nBrowse to http://`curl http://169.254.169.254/latest/meta-data/public-ipv4 2>/dev/null`\n\n"


