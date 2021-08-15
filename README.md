**SERVER SETUP (Ubuntu 20.04)**
===============================
# We Need to install :
	- Apache Server
	- MySQL Server
	- PHP
	- PHP MyAdmin
	- Composer
	- Git

# Apache Server
	# Install
		- sudo apt-get install apache2
	# Config Test
		- sudo apache2ctl configtest
	# Check Config
		- sudo nano /etc/apache2/apache2.conf
	# Restart
		- sudo systemctl restart apache2
	# Set Permission
		- sudo chmod 777 -R /var/www/html
	# Unistall
		- sudo apt-get purge apache2

# MySQL Server
	# Install
		- sudo apt-get install mysql-server
	# Open Mysql
		- sudo mysql
	# Set Root Password
		- ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root';
	# Restart
		- sudo systemctl restart mysql
	# Unistall
		- sudo apt-get purge mysql-server

# PHP
	# Install
		- sudo apt-get install php libapache2-mod-php php-mysql
	# Config
		- sudo nano /etc/apache2/mods-enabled/dir.conf (Add index.php in first end remove other index.php)
	# Unistall
		- sudo apt-get purge php
	# Change PHP Version
		- sudo a2dismod php7.2 && sudo a2enmod php7.3 (Change php 7.2 - 7.3)
	# Change CLI Version
		- sudo update-alternatives --set php /usr/bin/php7.3
		- sudo update-alternatives --set phar /usr/bin/phar7.3
		- sudo update-alternatives --set phar.phar /usr/bin/phar.phar7.3

# PHP MyAdmin
	# Install
		- sudo apt-get install phpmyadmin
	# Config
		- sudo nano /etc/apache2/apache2.conf (Add line to bottom 'Include /etc/phpmyadmin/apache.conf')
	# Unistall
		- sudo apt-get purge phpmyadmin

# Composer
	# Install
		- sudo apt-get install composer
	# Unistall
		- sudo apt-get purge composer

# GIT
	# Install
		- sudo apt-get install git
	# Unistall
		- sudo apt-get purge git
