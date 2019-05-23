# make sure we're up to date with 5.6 repos
apt-get update -y

# Needed to make sure that we have mcrypt which apparently is ok again. 
apt-get upgrade -y
export DEBIAN_FRONTEND=noninteractive

# MySql
apt-get -y install mysql-server

# Install apache
apt-get -y install apache2

# using apt-get to install the main packages
apt-get -y install uuid uuid-runtime curl policycoreutils unzip patch git nano gcc make mcrypt

#install php
apt-get -y install software-properties-common python-software-properties
add-apt-repository -y ppa:ondrej/php
apt-get update
apt-get -y install php7.2 php7.2-common php7.2-mysql php7.2-ldap php7.2-cgi php7.2-xml php7.2-curl php7.2-gd php7.2-cli php7.2-fpm php7.2-dev php7.2-mbstring

apt-get -y install libapache2-mod-fastcgi
a2enmod actions fastcgi alias proxy_fcgi setenvif
a2enconf php7.2-fpm

# PHP 7.2 FPM with apache settings
cat php/apache_domain_php-fpm.conf > /etc/apache2/sites-available/000-default.conf
# fix date timezone errors
sed -i 's#;date.timezone =#date.timezone = "America/New_York"#g' /etc/php/7.2/fpm/php.ini

# enable apache headers
a2enmod ssl rewrite headers

# Sanity Logs
mkdir /var/log/php-fpm/
echo slowlog = /var/log/php-fpm/www-slow.log >> /etc/php/7.2/fpm/pool.d/www.conf
echo request_slowlog_timeout = 2s >> /etc/php/7.2/fpm/pool.d/www.conf
echo php_admin_value[error_log] = /var/log/php-fpm/www-error.log >> /etc/php/7.2/fpm/pool.d/www.conf

# BASIC PERFORMANCE SETTINGS
cat performance/compression.conf > /etc/apache2/conf-available/compression.conf
a2enconf compression
cat performance/content_transformation.conf > /etc/apache2/conf-available/content_transformation.conf
a2enconf content_transformation
cat performance/etags.conf > /etc/apache2/conf-available/etags.conf
a2enconf etags
cat performance/expires_headers.conf > /etc/apache2/conf-available/expires_headers.conf
a2enconf expires_headers
cat performance/file_concatenation.conf > /etc/apache2/conf-available/file_concatenation.conf
a2enconf file_concatenation
cat performance/filename-based_cache_busting.conf > /etc/apache2/conf-available/filename-based_cache_busting.conf
a2enconf filename-based_cache_busting

# Security Basics
cat security/security.conf > /etc/apache2/conf-available/security.conf
sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php/7.2/fpm/php.ini
sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php/7.2/cgi/php.ini
sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php/7.2/cli/php.ini

#opcache settings
cat php/opcache.ini > /etc/php/7.2/mods-available/opcache.ini

#Modules
a2enmod expires

service apache2 restart
service mysql restart
service php7.2-fpm restart

# Install Drush globally.
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
ln -s /usr/local/bin/composer /usr/bin/composer
