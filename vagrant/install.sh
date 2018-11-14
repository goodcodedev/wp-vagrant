sudo upt-get update
sudo apt-get install -y apache2 apache2-utils
sudo a2enmod rewrite

# Allow .htaccess
sudo sh -c 'echo "
<Directory /var/www/html/>
    AllowOverride All
</Directory>
" >> /etc/apache2/apache2.conf'

sudo systemctl enable apache2
# Mysql will ask for root password in an interactive manner.
# This blocks running this script through vagrant file.
sudo apt-get install -y mysql-client mysql-server
sudo apt-get install -y php7.0 php7.0-mysql libapache2-mod-php7.0 php7.0-cli php7.0-cgi php-imagick php7.0-gd

sudo apt-get install -y php7.0-dev
curl -O -L http://xdebug.org/files/xdebug-2.6.1.tgz
tar -xvzf xdebug-2.6.1.tgz
pushd xdebug-2.6.1
phpize
./configure
make
sudo cp modules/xdebug.so /usr/lib/php/20151012
sudo sh -c 'echo "
zend_extension = /usr/lib/php/20151012/xdebug.so
[XDebug]
xdebug.remote_enable = 1
xdebug.remote_autostart = 1
xdebug.remote_connect_back = 1
" >> /etc/php/7.0/apache2/php.ini'
popd
rm xdebug-2.6.1.tgz
rm -rf xdebug-2.6.1
# Not sure what this file is (it's info about xdebug)
rm package.xml

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp

sudo mysql -u root -e "\
    create database wordpress;\
    ALTER DATABASE wordpress CHARACTER SET utf8 COLLATE utf8_general_ci;\
    create user wordpress@'%' identified by 'wppass';\
    grant all privileges on wordpress.* to wordpress@'%';\
    flush privileges;"

# allow external connections
# ZERO_DATEs are required by wordpress, these are stripped from default modes
sudo sh -c 'echo "
[mysqld]
bind-address = 0.0.0.0
sql-mode="ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION"
" >> /etc/mysql/my.cnf'

sudo chown -R www-data:www-data /var/www
sudo usermod -a -G www-data vagrant
sudo chmod -R g+w /var/www

# Start apache
sudo systemctl start apache2

# login again for group to take effect
echo "== Login again for group to take effect =="