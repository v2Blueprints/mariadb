#!/bin/sh
#I have avoided bash as it harder to sanitize params because there are more ways to break out
#modified version of v1 add service script

#needs to run as root
#this could be changed bu setting up a user with mysql rights
#v1 created a mysql user rma which had super user access to mysqld from localhost

#FIX ME note all parameters passed in the environment to this Script must be sanitised (no ; no & etc
 
BTICK='`'

MYSQL=`which mysql`

char_set=`echo $collation | cut -f1 -d_`

if test -z "$charset"
 then
 	charset=utf8
fi

Q1="CREATE DATABASE IF NOT EXISTS ${BTICK}$username${BTICK}   DEFAULT CHARACTER SET $charset
  DEFAULT COLLATE $collation ; Create User '$password'@'%' IDENTIFIED BY '$password';"


	if test "$super_user" = true
  	 then
 	   Q2="UPDATE mysql.user SET Super_Priv='Y' WHERE user='$username'; \
 	    GRANT ALL PRIVILEGES ON *.* TO  ${BTICK}$password${BTICK}@${BTICK}%${BTICK}; 
 	    FLUSH PRIVILEGES;"
    fi
	    

 if test "$full_access" = true 
 	 then
 	   Q2="GRANT ALL  PRIVILEGES ON *.* TO ${BTICK}$username@%${BTICK} WITH GRANT OPTION;"	   
       Q3="Grant Create User on ${BTICK}$databasename${BTICK}.*  to '$username'@'%';"
 	fi
 
 if test -z $full_access
 then
   Q2="GRANT ALL PRIVILEGES ON ${BTICK}$databasename${BTICK}.* TO '$username'@'%';"
 fi

Q4="FLUSH PRIVILEGES;"
SQL="${Q1}${Q2}${Q3}${Q4}"

echo "$SQL" >/tmp/$databasename.sql

$MYSQL -u rma -e "$SQL" 2>&1 > /tmp/res
err_num=$?
res=`cat /tmp/res`

echo $res | grep -v ERROR

#dont pass on warnings (v1 headspace)
if test $? -ne 0
 then 
	echo "Success"
	exit 0
fi
	
echo "Error:$res"
echo with $SQL
exit $err_num

