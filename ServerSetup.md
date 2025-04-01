<img src="https://github.com/abbackend/portfolio/blob/master/channels4_banner.jpg" width="100%"/>

# Setting Up a Web Server on Ubuntu 20.x: A Step-by-Step Guide

Welcome to this guide on setting up a web development environment on Ubuntu 20.x! Whether you're building a website, a web app, or just experimenting, you'll need a solid server setup. We'll install and configure the following tools: Apache Server, MySQL Server, PHP, phpMyAdmin, Composer, and Git. Let’s make it simple and fun—here we go!

## What We’ll Install
Here’s a quick overview of the tools we’ll set up:

| # | Tool           | Purpose                              |
|---|----------------|--------------------------------------|
| 1 | Apache Server  | Serves your web pages                |
| 2 | MySQL Server   | Manages your databases               |
| 3 | PHP            | Powers dynamic web content           |
| 4 | phpMyAdmin     | A web interface for MySQL            |
| 5 | Composer       | Manages PHP dependencies             |
| 6 | Git            | Tracks your code changes             |

---

## Step 1: Install Apache Server

Apache is a popular web server that delivers your website to visitors. Let’s get it running.

1. **Install Apache**:
   ```bash
   sudo apt-get install apache2
   ```

2. **Test the Configuration**:
   Check for syntax errors:
   ```bash
   sudo apache2ctl configtest
   ```
   Look for "Syntax OK" in the output.

3. **Check the Config File** (optional):
   Open the main configuration file to tweak settings if needed:
   ```bash
   sudo nano /etc/apache2/apache2.conf
   ```

4. **Restart Apache**:
   Apply any changes:
   ```bash
   sudo systemctl restart apache2
   ```

5. **Set Permissions**:
   Make the web directory writable:
   ```bash
   sudo chmod 777 -R /var/www/html
   ```
   > **Note**: `777` gives full permissions—use cautiously in production!

6. **Uninstall** (if needed):
   ```bash
   sudo apt-get remove --purge apache2
   ```

Test it by visiting `http://localhost` in your browser—you should see Apache’s default page!

---

## Step 2: Install MySQL Server

MySQL is a database system for storing your app’s data. Let’s set it up.

1. **Install MySQL**:
   ```bash
   sudo apt-get install mysql-server
   ```

2. **Access MySQL**:
   Log in as root:
   ```bash
   sudo mysql
   ```

3. **Set Root Password**:
   Secure the root user with a password (e.g., `root`):
   ```sql
   ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root';
   ```
   Exit with `exit;`.

4. **Restart MySQL**:
   ```bash
   sudo systemctl restart mysql
   ```

5. **Uninstall** (if needed):
   ```bash
   sudo apt-get remove --purge mysql-server
   ```

Now MySQL is ready to store your data!

---

## Step 3: Install PHP

PHP lets you create dynamic web pages. We’ll integrate it with Apache and MySQL.

1. **Install PHP**:
   ```bash
   sudo apt-get install php libapache2-mod-php php-mysql
   ```

2. **Configure Apache for PHP**:
   Edit the directory index to prioritize `index.php`:
   ```bash
   sudo nano /etc/apache2/mods-enabled/dir.conf
   ```
   Change the line to:
   ```
   DirectoryIndex index.php index.html index.cgi index.pl index.xhtml index.htm
   ```
   Save and exit.

3. **Switch PHP Version** (e.g., 5.4 to 7.4):
   - Disable old version, enable new one:
     ```bash
     sudo a2dismod php5.4 && sudo a2enmod php7.4
     ```
   - Update CLI version:
     ```bash
     sudo update-alternatives --set php /usr/bin/php7.4
     sudo update-alternatives --set phar /usr/bin/phar7.4
     sudo update-alternatives --set phar.phar /usr/bin/phar.phar7.4
     ```

4. **Uninstall** (if needed):
   ```bash
   sudo apt-get remove --purge php
   ```

Restart Apache (`sudo systemctl restart apache2`) and test PHP by creating `/var/www/html/info.php` with `<?php phpinfo(); ?>`—visit `http://localhost/info.php`.

---

## Step 4: Install phpMyAdmin

phpMyAdmin provides a web interface to manage MySQL databases.

1. **Install phpMyAdmin**:
   ```bash
   sudo apt-get install phpmyadmin
   ```
   Follow the prompts—select Apache when asked.

2. **Link to Apache**:
   Add phpMyAdmin to Apache’s config:
   ```bash
   sudo nano /etc/apache2/apache2.conf
   ```
   Add this line at the bottom:
   ```
   Include /etc/phpmyadmin/apache.conf
   ```
   Save and exit.

3. **Restart Apache**:
   ```bash
   sudo systemctl restart apache2
   ```

4. **Uninstall** (if needed):
   ```bash
   sudo apt-get remove --purge phpmyadmin
   ```

Visit `http://localhost/phpmyadmin` and log in with your MySQL root credentials.

---

## Step 5: Install Composer

Composer is a dependency manager for PHP projects.

1. **Install Composer**:
   ```bash
   sudo apt-get install composer
   ```

2. **Verify Installation**:
   ```bash
   composer --version
   ```

3. **Uninstall** (if needed):
   ```bash
   sudo apt-get remove --purge composer
   ```

Now you can manage PHP packages easily!

---

## Step 6: Install Git

Git helps you version-control your code.

1. **Install Git**:
   ```bash
   sudo apt-get install git
   ```

2. **Verify Installation**:
   ```bash
   git --version
   ```

3. **Uninstall** (if needed):
   ```bash
   sudo apt-get remove --purge git
   ```

Set up your Git identity with:
```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```

---

## Final Touches

- **Update Packages**: Always start with `sudo apt-get update && sudo apt-get upgrade` to ensure you’re installing the latest versions.
- **Security**: In production, tighten permissions (e.g., `chmod 755`) and use strong passwords.
- **Testing**: Create a simple PHP file or clone a project into `/var/www/html` to confirm everything works.

---

## Conclusion

You’ve just set up a fully functional web server on Ubuntu 20.x! With Apache serving pages, MySQL storing data, PHP powering your apps, phpMyAdmin managing databases, Composer handling dependencies, and Git tracking changes, you’re ready to build amazing projects. Have fun coding!
