#!/bin/sh
ls -lRa /var/run
rm /var/run/mysqld/mysqld.sock
/root/setup_mariadb.sh
exec mysqld
