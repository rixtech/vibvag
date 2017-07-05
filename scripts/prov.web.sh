#!/bin/bash

# Install Apache and PHP on Ubuntu
# Drop in PHP testing index page
# Called by vagrant up or vagrant provision

apt-get update
apt-get install -y apache2 php libapache2-mod-php php-mcrypt php-mysql
usermod -a -G www-data ubuntu
echo '<?php phpinfo(); ?>' > /var/www/html/phpinfo.php

cat << 'EndPHP' > /var/www/html/index.php
<?php
$db_username="webapp";
$db_password="webappPW";
/* set db_host to an elastic IP */
$db_host="52.14.7.204";
$db_name="testdb";

$con = new \mysqli($db_host, $db_username, $db_password, $db_name) or die(mysqli_error()); 

if ($con->connect_errno) {
    printf("Connect failed: %s\n", $con->connect_error);
    exit();
}

printf("<br>\nSHOW DATABASES<br>\n");
$result = $con->query("SHOW DATABASES");
while($row = mysqli_fetch_array($result))
{
  echo $row[0];
  echo "<br>\n";
}
printf("Select returned %d rows.<br>\n", $result->num_rows);

printf("<br>\nSELECT * FROM test<br>\n");
$result = $con->query("SELECT * FROM test");
while($row = mysqli_fetch_array($result))
{
  echo $row['c'];
  echo "<br>\n";
}
printf("Select returned %d rows.<br>\n", $result->num_rows);

mysqli_close($con);                                    
?>

EndPHP

mv /var/www/html/index.html /var/www/html/_index.html

chown -R ubuntu:www-data /var/www

echo Restarting Apache
systemctl restart apache2.service
echo ""
echo "======================================================================"
echo ""
echo "   Browse to:  http://13.59.134.70"
echo "          or:  http://ec2-13-59-134-70.us-east-2.compute.amazonaws.com"
echo "======================================================================"
