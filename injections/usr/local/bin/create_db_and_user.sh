#!/bin/sh
#I have avoided bash as it harder to sanitize params because there are more ways to break out
#modified version of v1 add service script

#needs to run as root
#this could be changed bu setting up a user with mysql rights
#v1 created a mysql user rma which had super user access to mysqld from localhost

#FIX ME note all parameters passed in the environment to this Script must be sanitised (no ; no & etc
 


MYSQL=`which mysql`

char_set=`echo $collation | cut -f1 -d_`

if test -z "$charset"
 then
 	charset=utf8
fi

Q1="CREATE DATABASE IF NOT EXISTS $databasename  DEFAULT CHARACTER SET $charset
  DEFAULT COLLATE $collation ; Create User '$username'@'%' IDENTIFIED BY '$password';"


	if test "$super_user" = true
  	 then
 	   Q2="UPDATE mysql.user SET Super_Priv='Y' WHERE user='$username'@'%'; \
 	    GRANT ALL PRIVILEGES ON *.* TO  '$username'@'%'; 
 	    FLUSH PRIVILEGES;"
    fi
	    

 if test "$full_access" = true 
 	 then
 	   Q2="GRANT ALL  PRIVILEGES ON *.* TO '$username'@'%' WITH GRANT OPTION;"	   
       Q3="Grant Create User on $databasename.*  to '$username'@'%';"
 	fi
 
 if test -z $full_access
 then
   Q2="GRANT ALL PRIVILEGES ON $databasename.* TO '$username'@'%';"
 fi

Q4="FLUSH PRIVILEGES;"
SQL="${Q1}${Q2}${Q3}${Q4}"

echo "$SQL" >/tmp/$databasename.sql

$MYSQL -u rma </tmp/$databasename.sql 2>&1 > /tmp/res
err_num=$?
res=`cat /tmp/res`

echo $res | grep -v ERROR

#dont pass on warnings (v1 headspace)
if test $? -ne 0
 then 
	echo "Success"
   rm /tmp/$databasename.sql
	exit 0
fi
	
echo "Error:$res"
echo with $SQL
exit $err_num

