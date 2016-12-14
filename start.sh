# make sure we're up to date with 5.6 repos
apt-get update -y

# Needed to make sure that we have mcrypt which apparently is ok again. 
apt-get upgrade -y
export DEBIAN_FRONTEND=noninteractive

#Install Mariadb
apt-get install software-properties-common -y
apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
add-apt-repository 'deb [arch=amd64,i386,ppc64el] http://ftp.utexas.edu/mariadb/repo/10.1/ubuntu xenial main'

#update again after new repo and install the db server.
apt-get update -y
apt-get install mariadb-server -y

# Install apache
apt-get -y install apache2

# using apt-get to install the main packages
apt-get -y install sendmail uuid uuid-runtime curl policycoreutils unzip patch git nano gcc make mcrypt

#install php
apt-get -y install php php-fpm php-common php-mysql php-ldap php-cgi php-pear php-xml-parser php-curl php-gd php-cli php-fpm php-apcu php-dev php-mcrypt mcrypt
a2enmod proxy_fcgi setenvif
a2enconf php7.0-fpm

# enable apache headers
a2enmod ssl rewrite headers

# Sanity Logs
mkdir /var/log/php-fpm/
echo slowlog = /var/log/php-fpm/www-slow.log >> /etc/php/7.0/fpm/pool.d/www.conf
echo request_slowlog_timeout = 2s >> /etc/php/7.0/fpm/pool.d/www.conf
echo php_admin_value[error_log] = /var/log/php-fpm/www-error.log >> /etc/php/7.0/fpm/pool.d/www.conf

service apache2 restart
service mysqld restart
service php7.0-fpm restart
