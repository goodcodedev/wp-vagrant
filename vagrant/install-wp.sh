pushd /var/www/html
wp core download
wp core config --dbname=wordpress --dbuser=wordpress --dbpass=wppass --dbhost=localhost --dbprefix=wp_
wp core install --url="http://192.168.33.10" --title="Localhost" --admin_user="admin" --admin_password="pass" --admin_email="gudmund@goodcode.no"
popd