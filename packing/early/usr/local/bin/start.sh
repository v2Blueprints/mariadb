#!/bin/sh
ls -lRa /var/run
ls -lRa /var/run/
rm /var/run/mysqld/mysqld.sock
/root/setup_mariadb.sh
touch ^^service_path^^/startup
exec mysqld
sleep 120
