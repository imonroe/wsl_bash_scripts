#!/usr/bin/env bash

# bash script to help set up a Drupal-friendly LAMP stack local development environment
# comments and questions to ian [at] ianmonroe.com

# this sets up a directory called `apache_sites` in your local home directory.
# that's where the apache 2 site.conf files live, and they're simlinked into the /etc/apache2/sites-enabled dir
# this script works well with the `create_database.sh` and `make_new_site.sh` scripts in the apache directory
# in this repo.

# Three-fingered Claw Technique
yell() { echo "$0: $*" >&2; }
die() { yell "$*"; exit 111; }
try() { "$@" || die "cannot $*"; }

echo 'Setting up a LAMP stack in WSL.'
echo '*** THIS SCRIPT WORKS IN UBUNTU 18.04. DIFFERENT PLATFORMS MAY NOT FUNCTION PROPERLY ***'
echo 'Moving to home directory.'
cd ~

echo 'Adding PHP repos.'
try sudo add-apt-repository ppa:ondrej/php
try sudo add-apt-repository ppa:ondrej/apache2

echo 'Apt update.'
try sudo apt-get update

echo 'Installing Apache2'
try sudo apt-get install apache2
try sudo service apache2 start
try sudo service apache2 status

echo 'Installing CURL'
try sudo apt-get install curl

echo 'Installing PHP7.3 and deps.'
try sudo apt-get install php7.3
try sudo apt-get install php7.3-cli php7.3-fpm php7.3-json php7.3-pdo php7.3-mysql php7.3-zip php7.3-gd php7.3-bz2 php7.3-mbstring php7.3-curl php7.3-xml php7.3-bcmath php7.3-json
try sudo apt-get install php7.3-intl php-xml php-imagick php-bz2 php-pcov imagemagick php7.3-imagick

echo 'Enabling PHP 7.3 support in Apache2'
try sudo a2enmod proxy_fcgi setenvif
try sudo a2enconf php7.3-fpm
try sudo a2enmod rewrite
try sudo service apache2 restart

echo 'Setting up SSL certificates for lvh.me'
try sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/apache-selfsigned.key -out /etc/ssl/certs/apache-selfsigned.crt
echo "Your certificates are in:"
echo "SSLCertificateFile      /etc/ssl/certs/apache-selfsigned.crt"
echo "SSLCertificateKeyFile /etc/ssl/private/apache-selfsigned.key"

echo "enabling SSL in Apache."
try sudo a2enmod ssl
try sudo a2enmod headers
try sudo service apache2 restart

echo 'Setting up SQL'
try sudo apt-get install software-properties-common
try sudo apt-get install mysql-server mysql-client
try sudo service mysql start
try sudo mysql_secure_installation


# If mysql doesn't let you log in locally:
# sudo mysql -u root -p
# mysql> use mysql
# mysql> update user set authentication_string=PASSWORD("mypass") where user='root';
# mysql> flush privileges;
# mysql> quit;


echo 'Setting up Composer'
try sudo php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
try sudo php composer-setup.php -r "unlink('composer-setup.php');"
try sudo mv composer.phar /usr/local/bin/composer
try sudo chmod +x /usr/local/bin/composer

echo 'Setting up Drush'
try sudo composer global require drush/drush && composer global update && ln -s ~/.composer/vendor/drush/drush/drush /usr/bin/drush

echo 'Setting up NodeJS'
try sudo curl sL https://deb.nodesource.com/setup_10.x | bash
try sudo apt-get install --yes nodejs 
try sudo apt-get install --yes npm
try sudo node -v && npm -v

echo 'Setting up Web Sites'
try sudo mkdir ~/apache_sites
try sudo cp /etc/apache2/sites-available/*.conf ~/apache_sites
try sudo rm /etc/apache2/sites-enabled/*.conf
try sudo ln -s ~/apache_sites/000-default.conf /etc/apache2/sites-enabled/000-default.conf

try sudo cp /etc/apache2/apache2.conf /var/tmp/apache2.conf
try sudo chmod 777 /var/tmp/apache2.conf
try sudo printf "AcceptFilter https none\n" >> /var/tmp/apache2.conf
try sudo printf "AcceptFilter http none\n" >> /var/tmp/apache2.conf
try sudo cp /var/tmp/apache2.conf /etc/apache2/apache2.conf
try sudo chmod 640 /etc/apache2/apache2.conf
try sudo rm /var/tmp/apache2.conf
try sudo service apache2 restart

echo 'Setting up CircleCI'
try cd ~
try curl -fLSs http://circle.ci/cli > circleci_setup.sh
try sudo chmod +x circleci_setup.sh
try sudo ./circleci_setup.sh
try circleci setup
try sudo rm ~/circleci_setup.sh
echo 'CircleCI setup complete'

## echo 'Setting up Docker'
## try sudo apt install docker.io
## try sudo systemctl start docker
## try sudo systemctl enable docker
## try sudo groupadd docker
## try sudo usermod -aG docker $USER
## echo 'Docker setup complete'


echo 'Cleaning up.'
try sudo  apt autoremove

echo 'Stack setup script complete.'
