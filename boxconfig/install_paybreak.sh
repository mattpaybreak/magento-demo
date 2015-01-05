# Install paybreak checkout plugin
# @author MN

echo '======================================'
echo '| Installing PayBreak'
echo '======================================'

apt-get -y install git

cd /vagrant
rm -rf paybreakmagento

git clone https://github.com/PayBreak/magento.git

mv magento paybreakmagento

# Link plugin code to Magento's file structure
cd /var/www/html/app/code/
mkdir local && cd local
mkdir PayBreak && cd PayBreak
ln -s /vagrant/paybreakmagento Magento

# Link config file to magento
ln -s /vagrant/paybreakmagento/PayBreak_Magento.xml /var/www/html/app/etc/modules/PayBreak_Magento.xml

# Set up redirect template (must be copied, ln -s won't work)
mkdir /var/www/html/app/design/frontend/base/default/template/paybreakmagento/
cp /vagrant/paybreakmagento/redirect.phtml /var/www/html/app/design/frontend/base/default/template/paybreakmagento
/redirect.phtml
