#!/bin/bash
# Update the system
sudo apt-get update -y
sudo apt-get upgrade -y

# Install required packages
sudo apt-get install -y apache2 mysql-client php libapache2-mod-php php-mysql php-cli php-curl php-gd php-intl php-mbstring php-soap php-xml php-xmlrpc php-zip unzip

# Get the database endpoint from Terraform Output
DB_HOST=$(terraform output -json | jq -r '.rds_db_endpoint.value') # Ensure this matches your Terraform output

# Download and extract WordPress
WP_VERSION="latest"
WP_TAR="wordpress-${WP_VERSION}-fr_FR.tar.gz"

wget "https://fr.wordpress.org/${WP_TAR}"
tar xzf "${WP_TAR}"

# Configure WordPress
cd wordpress
sudo cp wp-config-sample.php wp-config.php

# Database settings (Ensure these outputs match your Terraform variables)
DB_NAME=$(terraform output -json | jq -r '.wordpress_db_name.value') # Update according to your RDS definition
DB_USER=$(terraform output -json | jq -r '.wordpress_db_user.value') # Update according to your RDS definition
DB_PASS=$(terraform output -json | jq -r '.wordpress_db_password.value') # Update according to your RDS definition

# Update wp-config.php with database settings
sudo sed -i "s/database_name_here/$DB_NAME/" wp-config.php
sudo sed -i "s/username_here/$DB_USER/" wp-config.php
sudo sed -i "s/password_here/$DB_PASS/" wp-config.php
sudo sed -i "s/localhost/$DB_HOST/" wp-config.php

# Move WordPress files to web server directory
sudo rm -rf /var/www/html
sudo mv * /var/www/html/

# Set proper permissions
sudo chown -R www-data:www-data /var/www/html
sudo chmod -R 755 /var/www/html

# Enable mod_rewrite
sudo a2enmod rewrite

# Apache configuration
cat <<EOF | sudo tee /etc/apache2/sites-available/wordpress.conf
<VirtualHost *:80>
    ServerName $(terraform output -json | jq -r '.domain_name.value') # Ensure this matches your domain output
    DocumentRoot /var/www/html

    <Directory /var/www/html>
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF

sudo a2ensite wordpress.conf
sudo a2dissite 000-default.conf

# Install certbot
sudo apt install -y certbot python3-certbot-apache

# Setup Let's Encrypt
sudo certbot --apache -d $(terraform output -json | jq -r '.domain_name.value') -m $(terraform output -json | jq -r '.email.value') --non-interactive --agree-tos

# Restart Apache
sudo systemctl restart apache2
