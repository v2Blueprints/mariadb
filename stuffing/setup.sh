#!/bin/sh
mysql_install_db --skip-auth-anonymous-user  --auth-root-authentication-method=normal
mysql < /tmp/packing/early/init.sql

