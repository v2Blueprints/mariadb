#!/bin/sh
#I have avoided bash as it harder to sanitize params because there are more ways to break out
#modified version of v1 del service script

#FIX ME note all parameters passed in the environment to this Script must be sanitised (no ; no & etc

Q1="DELETE FROM mysql.user where user=$username;"
Q2="FLUSH PRIVILEGES;"
Q3="Drop DATABASE $database_name;"
SQL="${Q1}${Q2}${Q3}" >/tmp/$database_name.sql

#echo "$SQL"

$MYSQL   -u rma  < /tmp/$database_name.sql $database_name 2>&1 > /tmp/res
res=`cat /tmp/res`

echo $res | grep -v ERROR
 
if test $? -eq 0
 then 
 	echo "Success"
 	 rm /tmp/$database_name.sql
	exit 0
fi
	# dont return error but include note
	echo $res | grep  "Unknown database"
if test $? -eq 0
 then 
	echo "Database $database_name Not Found"
	exit 0
fi
	
echo "Error:$res\n$SQL"
exit -1
