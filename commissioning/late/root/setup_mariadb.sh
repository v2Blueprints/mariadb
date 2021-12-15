#!/bin/sh

mkdir -p /var/run/mysqld/
chown mysql /var/run/mysqld/

	if ! test -f /var/lib/mysql/libdata1
	 then
	 	echo installing initial database
		mysql_install_db
		mysql < /root/init.sql
	 elif ! test -f /var/run/created
	 	 then
	 	 echo Performing database upgrade
	 	 mysql_upgrade -u rma

fi

touch ^^service_path^^/startup_complete
