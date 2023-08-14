#!/usr/bin/env bash

echo "Enter your hostname."

read host_name

sudo hostnamectl set-hostname $host_name

# Update system
sudo apt-get update \
    # && sudo apt-get -y dist-upgrade \
    && sudo apt-get autoclean \
    && sudo apt-get autoremove \
    && sudo apt-get clean

# Utilities
sudo apt-get install -y git tree htop curl vim run-one zip unzip software-properties-common snapd

# Install Node V16
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash - &&\
sudo apt-get install -y nodejs
sudo apt install -y npm

# Install Redis
sudo apt install -y redis-server

# Install Nginx
sudo apt install -y nginx

# Install Mysql
sudo apt install -y mysql-server

sudo mysql_secure_installation

# Install Certbot
sudo snap install core
sudo snap refresh core
sudo snap install --classic certbot
sudo certbot renew --dry-run

# Let www-data uses terminal
sed -i "s/var\/www:\/usr\/sbin\/nologin/var\/www:\/bin\/bash/gi" /etc/passwd

# Allow ssh to root and www-data
sudo chmod 700 ~/.ssh
echo 'AllowUsers root www-data' >> /etc/ssh/sshd_config

# Create folder and set permission to www-data
sudo mkdir -p /var/www/.ssh
cp ~/.ssh/authorized_keys /var/www/.ssh/
chmod 700 /var/www/.ssh
chmod 600 /var/www/.ssh/authorized_keys
sudo chown -R www-data:www-data /var/www

# Let www-data use nginx and certbot
echo "www-data ALL=(ALL) NOPASSWD: /usr/sbin/nginx
www-data ALL=(ALL) NOPASSWD: /usr/bin/certbot
www-data ALL=(ALL) NOPASSWD: /bin/systemctl restart amplify-agent" >> /etc/sudoers

# Restart ssh
sudo systemctl restart sshd

# PHP Repository
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update

# Install PHP V8.1
sudo apt install -y php8.1-common php8.1-cli
sudo apt install -y php8.1-fpm php8.1-mysql php8.1-mbstring php8.1-xml php8.1-zip php8.1-curl php8.1-gd

# Install Composer
curl -sS https://getcomposer.org/installer -o composer-setup.php

HASH=`curl -sS https://composer.github.io/installer.sig`

php -r "if (hash_file('SHA384', 'composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"

sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer

# If has any error from repository run sudo add-apt-repository --remove NAME_REPO_INSTALLED_FROM_THIS_SH
