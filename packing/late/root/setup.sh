#!/bin/sh

service mysql status |grep stopped >/dev/null

if test $? -eq 0
 then
   mysql_install_db 
   
   service mysql start 
   sleep 5
   
   mysql -h 127.0.0.1 < /root/init.sql
   rm /root/init.sql
 else
   	mysql_upgrade
 fi    

