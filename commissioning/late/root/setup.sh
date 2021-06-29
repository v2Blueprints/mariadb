#!/bin/sh

if ! test -f /var/lib/mysql/libdata1
	 then
	 	echo installing initial database
		mysql_install_db 
		mysql < /tmp/packing/late/init.sql
	 else
	 	 echo Performing database upgrade
	 	 mysql_upgrade -u rma
fi
