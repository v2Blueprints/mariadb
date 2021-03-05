#!/bin/sh
#I have avoided bash as it harder to sanitize params because there are more ways to break out
#modified version of v1 update service script

#FIX ME note all parameters passed in the environment to this Script must be sanitised (no ; no & etc
 

MYSQL=`which mysql`

Q1="set password for '"$username"'@'%' = PASSWORD('"$password"');"	

   if test $super_user = true
 	then
 	  Q5="UPDATE mysql.user SET Super_Priv='Y' WHERE user='$username' AND host='%';"
 	else
 		Q5="UPDATE mysql.user SET Super_Priv='y' WHERE user='$dbusername' AND host='%';"
 	  fi
 	 
   if test $full_access = true 
     then
  		Q5=$Q5 "GRANT ALL PRIVILEGES ON $database_name.* TO '$db_username'@'%' WITH GRANT OPTION;"
    else	     
 	   Q5=$Q5 "REVOKE GRANT ON $database_name.* TO '$username'@'%'  ;"
    fi


SQL="${Q1}${Q2}${Q3}${Q4}${Q5}"

echo "$SQL" > /tmp/$database_name.sql

$MYSQL   -urma  -e "$SQL" 2>&1 > /tmp/res
res=`cat /tmp/res`

echo $res | grep -v ERROR
 
if test $? -eq 0
 then 
	echo "Success"
	rm /tmp/$database_name.sql
	exit 0
fi
	
echo "Error:$res"
echo  With $SQL
exit 127

