#!/bin/sh
# Useful for testing - reinstalls magento/PayBreak without having to rebuild the whole box

rm -rf /vagrant/paybreakmagento
rm -rf /var/www/html/*

bash /vagrant/boxconfig/install_magento.sh
bash /vagrant/boxconfig/install_paybreak.sh
