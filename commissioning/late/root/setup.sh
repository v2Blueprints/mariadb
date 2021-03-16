#!/bin/sh

if ! test -f /var/lib/mysql/libdata
	 then
		mysql_install_db 
		mysql < /tmp/packing/early/init.sql
	 else
	 	 mysql_upgrade -u rma
fi
