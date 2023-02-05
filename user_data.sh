#!/bin/bash
sudo apt update
sudo apt install nginx -y
echo "Hello From Private EC2 $HOSTNAME" > /var/www/html/index.html