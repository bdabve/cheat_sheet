## Step 1 — Installing Apache

- Apache is available within Ubuntu’s default software repositories, making it possible to install it using conventional package management tools.

```bash
> sudo apt update && sudo apt install apache2
```

## Step 2 — Adjusting the Firewall

- Before testing Apache, it’s necessary to modify the firewall settings to allow outside access to the default web ports. 

- During installation, Apache registers itself with UFW to provide a few application profiles that can be used to enable or disable access to Apache through the firewall.

```bash
> sudo ufw app list     # list of application profiles
 
Output
Available applications:
  Apache
  Apache Full
  Apache Secure
  OpenSSH
```

As indicated by the output, there are three profiles available for Apache:

- Apache        : This profile opens only port 80 (normal, unencrypted web traffic)
- Apache Full   : This profile opens both port 80 (normal, unencrypted web traffic) and port 443 (TLS/SSL encrypted traffic)
- Apache Secure : This profile opens only port 443 (TLS/SSL encrypted traffic)

- It is recommended that you enable the most restrictive profile that will still allow the traffic you’ve configured. Since we haven’t configured SSL for our server yet in this guide, we will only need to allow traffic on port 80:
```bash
> sudo ufw allow 'Apache'   # allow apache
> sudo ufw status           # verify the change by typing:
```

## Step 3 — Checking your Web Server

```bash
> sudo systemctl status apache2
> hostname -I                   # get ip address
```

- When you have your server’s IP address, enter it into your browser’s address bar:
`http://your_server_ip`

## Step 4 — Managing the Apache Process

```bash
> sudo systemctl stop apache2           # stop apache
> sudo systemctl start apache2          # start the web server when it is stopped, type:
> sudo systemctl restart apache2        # stop and then start the service again, type:
> sudo systemctl reload apache2         # reload without dropping connections

> sudo systemctl disable apache2        # By default, Apache is configured to start automatically when the server boots. 
                                        # If this is not what you want, disable this behavior.
> sudo systemctl enable apache2         #To re-enable the service to start up at boot, type:
```

## Step 5 — Setting Up Virtual Hosts (Recommended)

- When using the Apache web server, you can use virtual hosts (similar to server blocks in Nginx) to encapsulate configuration details and host more than one domain from a single server. 

```bash
> sudo mkdir /var/www/your_domain       # Create the directory for your_domain as follows:
> sudo chown -R $USER:$USER /var/www/your_domain
> sudo chmod -R 755 /var/www/your_domain

> vim /var/www/your_domain/index.html
# inside, add the following sample
    <html>
    <head>
        <title>Welcome to Your_domain!</title>
    </head>
    <body>
        <h1>Success!  The your_domain virtual host is working!</h1>
    </body>
    </html>
```
- it's necessary to create a virtual host file with the correct directive.
- instead of modifying the default config file located at `/etc/apache2/sites-available/000-default.conf`
- make a new one at `/etc/apache2/sites-available/your_domain.conf`

```bash
> sudo nano /etc/apache2/sites-available/your_domain.conf
```
- Content

```
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    ServerName your_domain
    ServerAlias www.your_domain
    DocumentRoot /var/www/your_domain
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
```

```bash
> sudo a2ensite your_domain.conf    # enable the file.
> sudo a2dissite 000-default.conf   # disable the default site defined in 000-default.conf
> sudo apache2ctl configtest        # test for configuration errors
> sudo systemctl restart apache2    # restart Apache
```

## Step 6 – Getting Familiar with Important Apache Files and Directories

- Now that you know how to manage the Apache service itself, you should take a few minutes to familiarize yourself with a few important directories and files.

### Content

- `/var/www/html`: The actual web content, which by default only consists of the default Apache page you saw earlier, is served out of the /var/www/html directory. This can be changed by altering Apache configuration files.

- Server Configuration

`/etc/apache2`: The Apache configuration directory. All of the Apache configuration files reside here.
`/etc/apache2/apache2.conf`: The main Apache configuration file. 
                             This can be modified to make changes to the Apache global configuration. 
                             This file is responsible for loading many of the other files in the configuration directory.
`/etc/apache2/ports.conf`: This file specifies the ports that Apache will listen on. 
                           By default, Apache listens on port 80 and additionally listens on port 443 when a module 
                           providing SSL capabilities is enabled.
`/etc/apache2/sites-available/`: The directory where per-site virtual hosts can be stored. 
                                 Apache will not use the configuration files found in this directory unless they are 
                                 linked to the sites-enabled directory. 
                                 Typically, all server block configuration is done in this directory, 
                                 and then enabled by linking to the other directory with the a2ensite command.
`/etc/apache2/sites-enabled/`: The directory where enabled per-site virtual hosts are stored. 
                               Typically, these are created by linking to configuration files found in the 
                               sites-available directory with the a2ensite. 
                               Apache reads the configuration files and links found in this directory when 
                               it starts or reloads to compile a complete configuration.
`/etc/apache2/conf-available/, /etc/apache2/conf-enabled/`: These directories have the same relationship as the sites-available 
and sites-enabled directories, but are used to store configuration fragments that do not belong in a virtual host. 
Files in the conf-available directory can be enabled with the a2enconf command and disabled with the a2disconf command.
`/etc/apache2/mods-available/, /etc/apache2/mods-enabled/`: These directories contain the available and enabled modules, 
respectively. 
Files ending in `.load` contain fragments to load specific modules, 
while files ending in `.conf` contain the configuration for those modules. 
Modules can be enabled and disabled using the a2enmod and a2dismod command.

- Server Logs

`/var/log/apache2/access.log`: By default, every request to your web server is recorded in this log file 
                               unless Apache is configured to do otherwise.
`/var/log/apache2/error.log`: By default, all errors are recorded in this file. 
                          The LogLevel directive in the Apache configuration specifies how much detail the error logs will contain.
