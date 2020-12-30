##globals
site=$1

apt update && apt upgrade -y
export DEBIAN_FRONTEND=noninteractive

#Install Mariadb
apt install mariadb-server -y

# Install apache
apt -y install apache2

# using apt to install the main packages
apt -y install uuid uuid-runtime curl policycoreutils unzip patch git nano gcc make mcrypt

#install php
apt update
apt -y install php-fpm php-mysql php-ldap php-cgi php-xml php-curl php-gd php-cli  php-dev php-mbstring

apt -y install libapache2-mod-fastcgi
a2enmod actions fastcgi alias proxy_fcgi setenvif
a2enconf php7.4-fpm

# PHP 7.3 FPM with apache settings
cat /vagrant/php/apache_domain_php-fpm.conf > /etc/apache2/sites-available/000-default.conf
# fix date timezone errors
sed -i 's#;date.timezone =#date.timezone = "America/New_York"#g' /etc/php/7.3/fpm/php.ini

# enable apache headers
a2enmod ssl rewrite headers

# Sanity Logs
mkdir /var/log/php-fpm/
echo slowlog = /var/log/php-fpm/www-slow.log >> /etc/php/7.4/fpm/pool.d/www.conf
echo request_slowlog_timeout = 2s >> /etc/php/7.4/fpm/pool.d/www.conf
echo php_admin_value[error_log] = /var/log/php-fpm/www-error.log >> /etc/php/7.4/fpm/pool.d/www.conf

# Security Basics
cat /vagrant/security/security.conf > /etc/apache2/conf-available/security.conf
sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php/7.4/fpm/php.ini
sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php/7.4/cgi/php.ini
sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php/7.4/cli/php.ini

#opcache settings
cat /vagrant/php/opcache.ini > /etc/php/7.4/mods-available/opcache.ini

#Modules
a2enmod expires

service apache2 restart
service mysql restart
service php7.3-fpm restart

apt update -y
apt -y install imagemagick
apt -y install php-imagick
apt -y install php-zip

## server setup
echo "##### Add server config /etc/hosts on term and enable the conf."
cat /vagrant/vhost.txt > /etc/apache2/sites-available/000-default.conf
sed -i "s/website/$site/g" /etc/apache2/sites-available/000-default.conf
