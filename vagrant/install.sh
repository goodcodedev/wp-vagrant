sudo upt-get update
sudo apt-get install -y apache2 apache2-utils
sudo systemctl enable apache2
sudo systemctl start apache2
sudo apt-get install -y mysql-client mysql-server
sudo apt-get install -y php7.0 php7.0-mysql libapache2-mod-php7.0 php7.0-cli php7.0-cgi php7.0-gd

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

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp

sudo mysql -u root -e "\
    create database wordpress;\
    create user wordpress@'localhost' identified by 'wppass';\
    grant all privileges on wordpress.* to wordpress@'localhost';\
    flush privileges;"

sudo chown -R www-data:www-data /var/www
sudo usermod -a -G www-data vagrant
sudo chmod -R g+w /var/www

# login again for group to take effect
sudo su - vagrant

pushd /var/www/html
wp core download
wp core config --dbname=wordpress --dbuser=wordpress --dbpass=wppass --dbhost=localhost --dbprefix=wp_
wp core install --url="http://192.168.33.10" --title="Localhost" --admin_user="admin" --admin_password="pass" --admin_email="gudmund@goodcode.no"
popd