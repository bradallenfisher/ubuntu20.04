# Vagrant instructions
- Download [Vagrant](https://www.vagrantup.com/) and [Virtualbox](https://www.virtualbox.org/)
- Clone repo to local directory on your computer
```shell
git clone https://github.com/bradallenfisher/ubuntu16.04.git
```
- Cd into directory
```shell
cd ubuntu16.04
```
- add synced folder
```shell
mkdir psufandb
```

- Start vagrant
```shell
vagrant up
```

## Shell into vagrant server
```shell
vagrant ssh
```
## Add frontend stack to VM
```shell
npm install --global gulp-cli
npm install -g bower
cd to theme(s)
npm install
bower install
gulp
```

## For each domain entry you will need to edit your /etc/hosts file to add a line like this
```shell
192.168.16.16       local.psufandb.test
```

# Install Drush
``` shell
composer global require drush/drush:8.*	
echo 'export PATH="$HOME/.config/composer/vendor/bin:$PATH"' >> $HOME/.bashrc
echo 'export PATH="$HOME/.composer/vendor/bin:$PATH"' >> $HOME/.bashrc
source $HOME/.bashrc
```

## Live server instructions

# ubuntu16.04
``` shell
apt-get update && apt-get -y install git && git clone https://github.com/bradallenfisher/ubuntu16.04.git && cd ubuntu16.04 && chmod 700 start.sh && ./start.sh
```
## After Live Install (not vagrant)
- run mysql_secure_installation
- create a non privileged user
- add drush for that user
``` shell

