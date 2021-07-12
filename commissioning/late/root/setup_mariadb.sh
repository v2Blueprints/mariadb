#!/bin/sh

if ! test -f /var/lib/mysql/libdata1
	 then
	 	echo installing initial database
		mysql_install_db 
		mysql < /root/init.sql
	 elif ! test -f /var/run/created
	 	 echo Performing database upgrade
	 	 mysql_upgrade -u rma	
	 	  	 
fi

touch /var/run/created
