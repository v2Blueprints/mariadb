#!/bin/sh

service mysql status |grep stopped >/dev/null

if test $? -eq 0
 then
   mysql_install_db 
   mysql < /root/init.sql
   rm /root/init.sql
   service mysql start
 else
   	mysql_upgrade
 fi    

