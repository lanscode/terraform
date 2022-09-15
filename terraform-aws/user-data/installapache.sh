#!/bin/bash

apt-get update
apt-get install -y apache2
systemctl start apache2
systemctl enable apache2
echo "<h2> Deployed from apache2</h2>"| sudo tee /var/www/html/index.html