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


