#!/bin/sh

echo '======================================'
echo '|'
echo '| Setting up telegramm box'
echo '|'
echo '| ©wonowicki 2014'
echo '| Edited by matthew.norris@paybreak.com'
echo '======================================'
echo ''

echo '======================================'
echo '| Pre Configuration'
echo '======================================'

# Get rid of stdin not tty errors etc - see https://github.com/mitchellh/vagrant/issues/1673
sed -i 's/^mesg n$/tty -s \&\& mesg n/g' /root/.profile

# Set locale
locale-gen en_GB
locale-gen en_GB.utf8

# update apt-get
apt-get update

echo '======================================'
echo '| Installing Apache & PHP'
echo '======================================'

#install apache2, PHP and then MySQL
apt-get -y install apache2
apt-get -y install php5 # php5-mcrypt php5-xdebug

# echo '======================================'
# echo '| Configuring Apache'
# echo '======================================'

# XDebug
# cat /vagrant/boxconfig/xdebug >> /etc/php5/apache2/conf.d/xdebug.ini

# Enable: ModRewrite, mcrypt
a2enmod rewrite
# php5enmod mcrypt

# Make session directory writable
chmod -R 777 /var/lib/php5

# Configure default vhost
cat /vagrant/boxconfig/vhost > /etc/apache2/sites-available/000-default.conf

# echo '======================================'
# echo '| Installing PHPUnit'
# echo '======================================'

# Install PHPUnit
# wget https://phar.phpunit.de/phpunit.phar
# chmod +x phpunit.phar
# mv phpunit.phar /usr/local/bin/phpunit

# Restart apache
service apache2 restart

echo '======================================'
echo '| Installing PHP-CS-Fixer'
echo '======================================'

curl http://cs.sensiolabs.org/get/php-cs-fixer.phar -o /usr/local/bin/php-cs-fixer
chmod a+x /usr/local/bin/php-cs-fixer

echo '======================================'
echo '| Installing Composer'
echo '======================================'

curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/bin/composer

echo '======================================'
echo '| Installing PHP extras'
echo '======================================'

export DEBIAN_FRONTEND=noninteractive
apt-get -q -y install mysql-server

apt-get -y install php5-curl
apt-get -y install php5-mcrypt
apt-get -y install php5-gd
apt-get -y install php5-mysql

apt-get install git

php5enmod mcrypt

service apache2 restart

bash /vagrant/boxconfig/install_magento.sh
bash /vagrant/boxconfig/install_paybreak.sh


# Must now set up using the Magento install tool
# http://localhost:8001/
# admin password is: password123
# encryption key is: a575a38603bacf47025d552158f84ca0

