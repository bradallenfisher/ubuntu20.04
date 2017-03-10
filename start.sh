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

# fix date timezone errors
sed -i 's#;date.timezone =#date.timezone = "America/New_York"#g' /etc/php/7.0/fpm/php.ini

# enable apache headers
a2enmod ssl rewrite headers

# varnish
apt-get install varnish -y
#cp /lib/systemd/system/varnish.service /etc/systemd/system/
cat varnish/default.vcl > /etc/varnish/default.vcl

# Varnish can listen
sed -i 's/Listen 80/Listen 8080/g' /etc/apache2/ports.conf
sed -i 's/80/8080/g' /etc/apache2/sites-available/000-default.conf
#sed -i 's/6081/80/g' /etc/systemd/system/varnish.service

systemctl daemon-reload
systemctl reload varnish.service
service apache2 restart

# Sanity Logs
mkdir /var/log/php-fpm/
echo slowlog = /var/log/php-fpm/www-slow.log >> /etc/php/7.0/fpm/pool.d/www.conf
echo request_slowlog_timeout = 2s >> /etc/php/7.0/fpm/pool.d/www.conf
echo php_admin_value[error_log] = /var/log/php-fpm/www-error.log >> /etc/php/7.0/fpm/pool.d/www.conf

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
sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php/7.0/fpm/php.ini
sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php/7.0/cgi/php.ini
sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php/7.0/cli/php.ini

#opcache settings
cat php/opcache.ini > /etc/php/7.0/mods-available/opcache.ini

service apache2 restart
service mysqld restart
service php7.0-fpm restart
service varnish restart

# Install Drush globally.
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
ln -s /usr/local/bin/composer /usr/bin/composer
