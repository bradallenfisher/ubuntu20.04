``` shell
apt install git && git clone https://github.com/bradallenfisher/ubuntu20.04.git && cd ubuntu20.04 && chmod 700 start.sh && ./start.sh
```

## Secure server
``` shell
mysql_secure_installation
```

## create a non privileged user and add them to the sudo group
``` shell
useradd -m -s /bin/bash username
usermod -aG sudo username
```
## Create mysql user

``` shell
select host, user, password from mysql.user;
##change to meet IP needs...
CREATE USER 'newuser'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON * . * TO 'newuser'@'localhost';
```
## Certbot setup
```shell
apt -y install certbot python3-certbot-apache
nano /etc/default/ufw == check for IpV6
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw allow 'Apache Full'
ufw status
ufw enable
ufw status
```

## run certbot
```shell
certbot -d domains.com -d moredomains.com
``` 


## email outgoing 
https://wpforms.com/how-to-set-up-wordpress-smtp-using-amazon-ses/
