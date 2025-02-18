#!/bin/bash
ID=$(id -u)
if [ $ID -ne 0 ]
then 
   echo "ERROR:: Plz use root user"
   exit 1
   else
       echo "u r a root user"
       fi
VALIDATE(){
if [ $1 -ne 0 ]
then 
    echo "installing $2 is failed"
    else
       echo "$2 is installed successfully"
fi
}
 yum install mysql -y
 VALIDATE $? "MYSQL is installing...."
 yum install nginx -y
 VALIDATE $? "nginx is installing..."