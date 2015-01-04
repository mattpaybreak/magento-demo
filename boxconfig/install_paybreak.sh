# Install paybreak checkout plugin
# @author MN

echo '======================================'
echo '| Installing PayBreak'
echo '======================================'

cd /vagrant
rm -rf paybreakmagento

git clone https://github.com/PayBreak/magento.git

mv magento paybreakmagento

cd /var/www/html/app/code/
mkdir local && cd local
mkdir PayBreak && cd PayBreak
ln -s /vagrant/paybreakmagento Magento
ln -s /vagrant/paybreakmagento/PayBreak_Magento.xml /var/www/html/app/etc/modules/PayBreak_Magento.xml