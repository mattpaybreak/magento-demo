#!/bin/sh
# Sets up Magento
# @author MN

echo '======================================'
echo '| Installing Magento'
echo '======================================'

# clean up any previous runs
cd /var/www/html && rm * -rf
echo "drop database if exists magento" | mysql -u root

# Don't DL magento files if they're already there.
if [ ! -d /vagrant/ignore ]; then
  	mkdir /vagrant/ignore && cd /vagrant/ignore
  	wget http://mirror.gunah.eu/magento/magento-1.9.1.0.tar.gz -o /dev/null
	wget http://mirror.gunah.eu/magento/sample-data/magento-sample-data-1.9.0.0.tar.gz -o /dev/null
fi

cd /var/www/html

tar -zxvf /vagrant/ignore/magento-sample-data-1.9.0.0.tar.gz 
tar -zxvf /vagrant/ignore/magento-1.9.1.0.tar.gz

# note - throws error - maybs some assets weren't copied across?
mv magento-sample-data-1.9.0.0/media/* magento/media/
mv magento-sample-data-1.9.0.0/magento_sample_data_for_1.9.0.0.sql magento/data.sql
mv magento/* magento/.htaccess* .
chmod -R o+w media var

# Set up magento database
echo "create database magento" | mysql -u root
mysql -h localhost -u root magento < data.sql
chmod o+w var var/.htaccess app/etc
rm -rf magento/ magento-sample-data-1.9.0.0/

# this enables showing errors in browser - easier debugging innit
mv /var/www/html/errors/local.xml.sample /var/www/html/errors/local.xml
echo "Magento installed!"

# allow symlinks for templates
echo "USE magento; UPDATE core_config_data SET value = '1' WHERE path = 'dev/template/allow_symlink';" | mysql -u root

