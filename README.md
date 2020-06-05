# Install Drush
``` shell
composer global require drush/drush:8.*	
echo 'export PATH="$HOME/.config/composer/vendor/bin:$PATH"' >> $HOME/.bashrc
echo 'export PATH="$HOME/.composer/vendor/bin:$PATH"' >> $HOME/.bashrc
source $HOME/.bashrc
```

## Secure server
``` shell
- run mysql_secure_installation
- create a non privileged user
- add drush for that user
``` shell

