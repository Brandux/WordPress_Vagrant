#!/bin/bash
# Update server
apt-get update
apt-get upgrade -y
# Install essentials
apt-get -y install build-essential binutils-doc git -y
sudo apt-get install unzip 
# Install Apache
apt-get install apache2 -y
#Install PHP
apt-get install php5 libapache2-mod-php5 php5-cli php5-mysql -y
# Install MySQL
echo "mysql-server mysql-server/root_password password root" | sudo debconf-set-selections
echo "mysql-server mysql-server/root_password_again password root" | sudo debconf-set-selections
apt-get install mysql-client mysql-server -y
# Install PhpMyAdmin
echo 'phpmyadmin phpmyadmin/dbconfig-install boolean true' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/app-password-confirm password root' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/mysql/admin-pass password root' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/mysql/app-pass password root' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2' | debconf-set-selections
apt-get install phpmyadmin -y
# Restart Apache service
service apache2 restart

#Install wordPress
mysql -u root -proot

#configuraciones dentro del mysql
#Commands
echo "CREATE DATABASE wordpressdb" | mysql -u root --password=root
echo "CREATE USER wordpressuser@localhost IDENTIFIED BY 'wordpresspassword'" | mysql -u root --password=root
echo "GRANT ALL PRIVILEGES ON wordpressdb.* TO wordpressuser@localhost" | mysql -u root --password=root
echo "FLUSH PRIVILEGES" | mysql -u root --password=root
echo "exit" | mysql -u root --password=root


cd /tmp
sudo wget http://wordpress.org/latest.zip
sudo unzip -q latest.zip -d /var/www/html/
sudo chown -R www-data:www-data /var/www/html/wordpress
sudo chmod -R 755 /var/www/html/wordpress
sudo mkdir -p /var/www/html/wordpress/wp-content/uploads
sudo chown -R www-data:www-data /var/www/html/wordpress/wp-content/uploads

#Entra a tu fanpage ip/wordpress