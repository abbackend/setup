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
## Install
	- sudo apt-get install apache2
## Config Test
	- sudo apache2ctl configtest
## Check Config
	- sudo nano /etc/apache2/apache2.conf
## Restart
	- sudo systemctl restart apache2
Set Permission
	- sudo chmod 777 -R /var/www/html
