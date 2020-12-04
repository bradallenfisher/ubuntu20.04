#!/bin/bash

##globals
site=$1
## server setup
echo "##### Add server config /etc/hosts on term and enable the conf."
cat scripts/vhost.txt > /etc/apache2/sites-available/000-default.conf
sed -i "s/website/$site/g" /etc/apache2/sites-available/000-default.conf

cd /var/www/html

find . -type f -exec chmod 0644 {} \;
find . -type d -exec chmod 0755 {} \;

#create datbase
mysql -e "create database if not exists fws_$site;"
mysqldump fws_lgwp > /var/www/$site.sql
mysql fws_$site < /var/www/$site.sql
