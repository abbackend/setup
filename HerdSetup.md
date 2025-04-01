<img src="https://github.com/abbackend/portfolio/blob/master/channels4_banner.jpg" width="100%"/>

# Setting Up Wildcard Subdomains with Nginx and Automating Projects
In this guide, we'll configure Nginx to handle wildcard subdomains (e.g., `*.test`), install the Laravel CLI for project creation, and create a Bash script to automate setting up new projects with custom subdomains. By the end, you'll have a local development environment where you can access sites like `project1.test`, `project2.test`, etc., with ease. Let’s get started!

## Prerequisites

- A Linux system (e.g., Ubuntu)
- Basic command-line knowledge
- Root or sudo privileges
- Composer installed (`sudo apt install composer` if not already present)

---

## Step 1: Create a Directory for Your Projects

First, create a directory to store all your projects. We’ll call it `Herd` and place it in your home directory.

```bash
mkdir /home/$USER/Herd
```

This folder will hold each project’s files, organized by subdomain.

---

## Step 2: Install Nginx

Next, install Nginx to manage your web server and wildcard subdomains.

```bash
sudo apt install nginx
```

This installs Nginx and its dependencies. It will start automatically after installation.

---

## Step 3: Configure Nginx for Wildcard Subdomains

Let’s set up Nginx to handle wildcard subdomains by creating a configuration file.

1. Create a new file called `wildcard.conf` in the `/etc/nginx/sites-available/` directory:
   ```bash
   sudo nano /etc/nginx/sites-available/wildcard.conf
   ```

2. Paste the following configuration:

   ```nginx
   server {
       listen 80;

       # Extract the subdomain from the host
       set $subdomain $host;
       if ($subdomain ~* ^([^.]+)\.test$) {
           set $subdomain $1;
       }

       # Set the root directory based on the subdomain
       root /home/$USER/Herd/$subdomain/public;

       # Define default index files (add index.php for PHP support)
       index index.php index.html index.htm index.nginx-debian.html;

       # Match all subdomains of .test
       server_name *.test;

       # Serve files or fall back to index.php
       location / {
           try_files $uri $uri/ /index.php?$query_string;
       }

       # Handle PHP files
       location ~ \.php$ {
           include snippets/fastcgi-php.conf;
           fastcgi_pass unix:/run/php/php8.3-fpm.sock;
           fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
           include fastcgi_params;
       }

       # Deny access to .ht files (e.g., .htaccess)
       location ~ /\.ht {
           deny all;
       }

       # Optional: Custom logging per subdomain
       access_log "/var/log/nginx/${subdomain}_access.log";
       error_log "/var/log/nginx/${subdomain}_error.log";
   }
   ```

3. Save and exit.

### What’s Happening Here?
- `server_name *.test`: Matches any subdomain of `.test` (e.g., `project1.test`).
- `$subdomain`: Extracts the subdomain (e.g., `project1`) from the request.
- `root`: Points to the project’s `public` folder in `~/Herd/<subdomain>/public`.
- PHP support is included via FastCGI, assuming PHP 8.3 is installed (adjust the socket path if your version differs).

---

## Step 4: Enable and Test the Configuration

1. Link the config to `sites-enabled`:
   ```bash
   sudo ln -s /etc/nginx/sites-available/wildcard.conf /etc/nginx/sites-enabled/
   ```

2. Test the Nginx configuration for errors:
   ```bash
   sudo nginx -t
   ```
   If you see "syntax is ok" and "test is successful," you’re ready to proceed.

3. Reload Nginx to apply the changes:
   ```bash
   sudo systemctl reload nginx
   ```

---

## Step 5: Install the Laravel CLI

To create Laravel projects easily, install the Laravel CLI globally using Composer. This tool simplifies project setup and is used in our automation script.

1. Run the following command:
   ```bash
   composer global require laravel/installer
   ```

2. Ensure Composer’s global bin directory is in your PATH. Add this line to your `~/.bashrc` or `~/.zshrc` (depending on your shell):
   ```bash
   export PATH="$HOME/.composer/vendor/bin:$PATH"
   ```

3. Apply the PATH update:
   ```bash
   source ~/.bashrc
   ```

4. Verify the installation:
   ```bash
   laravel --version
   ```
   You should see the Laravel installer version (e.g., `Laravel Installer 4.x.x`).

---

## Step 6: Automate Project Creation with a Bash Script

Now, let’s create a script to automate project setup and subdomain configuration.

1. Create a file called `herd.sh`:
   ```bash
   nano herd.sh
   ```

2. Paste this script:

   ```bash
   #!/bin/bash

   # Check if a project name is provided
   if [ -z "$1" ]; then
       echo "Error: Project name is required!"
       echo "Usage: $0 <project-name>"
       exit 1
   fi

   # Create a new Laravel project in ~/Herd
   cd ~/Herd && laravel new "$1"

   # Add subdomain to /etc/hosts
   line_to_append="127.0.0.1       $1.test"
   echo "$line_to_append" | sudo tee -a /etc/hosts > /dev/null

   # Update the APP_URL in the project’s .env file
   cd ~/Herd/"$1" && sed -i "s|^APP_URL=.*|APP_URL=http://${1}.test|" .env

   # Notify the user
   echo "You can access it using: http://$1.test"
   ```

3. Save and exit.

4. Make the script executable:
   ```bash
   chmod +x herd.sh
   ```

---

## Step 7: Use the Script

To create a new project, run:

```bash
./herd.sh myproject
```

### What Does This Do?
- Creates a new Laravel project in `~/Herd/myproject` using the Laravel CLI.
- Adds `127.0.0.1 myproject.test` to `/etc/hosts` for local DNS.
- Updates the `.env` file with `APP_URL=http://myproject.test`.
- Outputs the URL you can use to access it.

Now, open your browser and visit `http://myproject.test`—it should work seamlessly!

---

## Notes
- **PHP Dependency**: The Nginx config assumes PHP 8.3 FPM is installed. Install it with `sudo apt install php8.3-fpm` if needed (adjust version as necessary).
- **Composer**: Ensure Composer is installed (`sudo apt install composer`) before installing the Laravel CLI.
- **DNS**: This setup uses `/etc/hosts` for local testing. For production, configure a wildcard DNS record (e.g., `*.test`) with your DNS provider.

---

## Conclusion

With Nginx handling wildcard subdomains, the Laravel CLI installed, and an automation script in place, you can create new projects in seconds. This setup is perfect for local development, testing multiple apps, or even prototyping multi-tenant systems. Happy coding!
