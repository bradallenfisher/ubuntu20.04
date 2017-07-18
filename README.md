# ubuntu16.04
``` shell
apt-get update && apt-get -y install git && git clone https://github.com/bradallenfisher/ubuntu16.04.git && cd ubuntu16.04 && chmod 700 start.sh && ./start.sh
```
## After Install
- run mysql_secure_installation
- create a non privileged user
- add drush for that user
``` shell
# Install Drush
composer global require drush/drush:8.*	
echo 'export PATH="$HOME/.config/composer/vendor/bin:$PATH"' >> $HOME/.bashrc
echo 'export PATH="$HOME/.composer/vendor/bin:$PATH"' >> $HOME/.bashrc
source $HOME/.bashrc
```
