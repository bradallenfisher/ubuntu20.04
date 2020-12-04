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
apt -y install software-properties-common
add-apt-repository -y ppa:ondrej/php
apt update
apt -y install php7.3 php7.3-common php7.3-mysql php7.3-ldap php7.3-cgi php7.3-xml php7.3-curl php7.3-gd php7.3-cli php7.3-fpm php7.3-dev php7.3-mbstring

apt -y install libapache2-mod-fastcgi
a2enmod actions fastcgi alias proxy_fcgi setenvif
a2dismod php7.3
a2enconf php7.3-fpm

# PHP 7.3 FPM with apache settings
cat php/apache_domain_php-fpm.conf > /etc/apache2/sites-available/000-default.conf
# fix date timezone errors
sed -i 's#;date.timezone =#date.timezone = "America/New_York"#g' /etc/php/7.3/fpm/php.ini

# enable apache headers
a2enmod ssl rewrite headers

# Sanity Logs
mkdir /var/log/php-fpm/
echo slowlog = /var/log/php-fpm/www-slow.log >> /etc/php/7.3/fpm/pool.d/www.conf
echo request_slowlog_timeout = 2s >> /etc/php/7.3/fpm/pool.d/www.conf
echo php_admin_value[error_log] = /var/log/php-fpm/www-error.log >> /etc/php/7.3/fpm/pool.d/www.conf

# BASIC PERFORMANCE SETTINGS
#cat performance/compression.conf > /etc/apache2/conf-available/compression.conf
#a2enconf compression
#cat performance/content_transformation.conf > /etc/apache2/conf-available/content_transformation.conf
#a2enconf content_transformation
#cat performance/etags.conf > /etc/apache2/conf-available/etags.conf
#a2enconf etags
#cat performance/expires_headers.conf > /etc/apache2/conf-available/expires_headers.conf
#a2enconf expires_headers
#cat performance/file_concatenation.conf > /etc/apache2/conf-available/file_concatenation.conf
#a2enconf file_concatenation
#cat performance/filename-based_cache_busting.conf > /etc/apache2/conf-available/filename-based_cache_busting.conf
#a2enconf filename-based_cache_busting

# Security Basics
cat security/security.conf > /etc/apache2/conf-available/security.conf
sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php/7.3/fpm/php.ini
sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php/7.3/cgi/php.ini
sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php/7.3/cli/php.ini

#opcache settings
cat php/opcache.ini > /etc/php/7.3/mods-available/opcache.ini

#Modules
a2enmod expires

service apache2 restart
service mysql restart
service php7.3-fpm restart

# Install Drush globally.
#curl -sS https://getcomposer.org/installer | php
#sudo mv composer.phar /usr/local/bin/composer
#ln -s /usr/local/bin/composer /usr/bin/composer

apt update -y
apt install imagemagick
apt install php7.3-imagick
apt install php7.3-zip


## server setup
echo "##### Add server config /etc/hosts on term and enable the conf."
cat vhost.txt > /etc/apache2/sites-available/000-default.conf
sed -i "s/website/$site/g" /etc/apache2/sites-available/000-default.conf

cd /var/www/html

find . -type f -exec chmod 0644 {} \;
find . -type d -exec chmod 0755 {} \;

#create datbase
mysql -e "create database if not exists fws_$site;"
