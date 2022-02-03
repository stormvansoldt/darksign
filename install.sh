#!/bin/bash

## Update the pi firmware and packages
update_sys() {
	apt update && apt upgrade -y
	rpi-update
	reboot now	
}

## Install dependencies from apt and the image-utils from the git repo
install_deps() {
	apt install vim apache2 php php-curl sqlite3 php7.3-sqlite3 git rsync nfs-common
	mv image-utils/image-* /usr/local/bin/
	chmod a+x /usr/local/bin/image-*
}

## Mount the NFS share from the WFZRS-PISIGNAGE server and make a dir for the current pi
prep_backup_dir() {
	BACKUP_DIR="$(uname -n)"
	if [ grep "/mnt/backup" /etc/fstab ]; then
		echo "[ ] fstab entry already exists for /mnt/backup"
	else
		echo "10.10.103.126:/DarksignBackups /mnt/backup nfs defaults 0 0" >> /etc/fstab
	fi

	[ ! -d "/mnt/backup" ] && mkdir "/mnt/backup" && echo "[ ] /mnt/backup created"
	mount /mnt/backup && echo "[ ] /mnt/backup mounted successfully"

	if [ "$BACKUP_DIR" == "raspberry" ]; then
		echo "[*] Pi has default hostname 'raspberry'"
		read -p "[ ] Please make a new name for the backup directory (ex: Big-Cool-Pi): " BACKUP_DIR
	fi

	mkdir "/mnt/backup/$BACKUP_DIR" && echo "[ ] /mnt/backup/$BACKUP_DIR created successfully" 
}

## CONFIGURATION ##
# Enable sqlite3 extension in PHP
config_apache() {
	PHP_INI="/etc/php/7.3/apache2/php.ini"
	if [ -f "$PHP_INI" ]; then
		sed -i 's/;extension=sqlite3/extension=sqlite3/g' "$PHP_INI"
		sed -i 's/;extension=pdo_sqlite/extension=sqlite/g' "$PHP_INI"
		service apache2 restart
		echo "SQLite3 extension has been enabled in $PHP_INI"
	else
		echo "ERROR: $PHP_INI not found"
	fi

	# Remove Apache's default index.html
	rm /var/www/html/index.html

	## Change some file/folder permissions. Do this after all files have been uploaded and modified
	useradd pi www-data
	chown -R www-data:www-data /var/www
	chmod -R g+rwX /var/www
	chmod 666 /home/pi/media/__mainpl.json
}