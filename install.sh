#!/bin/bash

## UPDATE ##
apt update && apt upgrade -y
rpi-update
reboot now

## INSTALL ##
# Apt packages
apt install vim apache2 php php-curl sqlite3 php7.3-sqlite3 git rsync nfs-common
# image-utils (used for backups)
mv image-utils/image-* /usr/local/bin/
chmod a+x /usr/local/bin/image-*

## CONFIGURATION ##
# Enable sqlite3 extension in PHP
PHP_INI=/etc/php/7.3/apache2/php.ini
if [ -f "$FILE" ]; then
	sed -i 's/;extension=sqlite3/extension=sqlite3/g' /etc/php/7.3/apache2/php.ini
	sed -i 's/;extension=pdo_sqlite/extension=sqlite/g' /etc/php/7.3/apache2/php.ini
	service apache2 restart
	echo "SQLite3 extension has been enabled in $FILE"
else
	echo "ERROR: $FILE not found"
fi

# Remove Apache's default index.html
rm /var/www/html/index.html

# Create and mount remote backup folder
mkdir /mnt/backup
mount -t nfs 10.10.103.126:/DarksignBackups /mnt/backup

## Copy premade PiSignage files to /home/pi/media
# custom_layout-file.html
# background_image.png
# __mainpl.json

## Copy premade Apache files to /var/www/html
# index.html/index.php
# upload.php

## Change some file/folder permissions. Do this after all files have been uploaded and modified
useradd pi www-data
chown -R www-data:www-data /var/www
chmod -R g+rwX /var/www
chmod 666 /home/pi/media/__mainpl.json

## Create darkuser
#adduser --gecos "" --disabled-password darkuser
#adduser -aG sudo darkuser
#chpasswd <<< "darkuser:stormisprettycool"