#!/bin/bash
ID=$(id -u)
if [ $ID -ne 0 ]
then 
   echo "ERROR:: Plz use root user"
   exit 1
   else
       echo "u r a root user"
       fi
 yum install mysql -y
 if [ $? -ne 0 ]
 then 
     echo "installing mysql is failed"
     else
        echo "mysql is installed successfully"
        fi
 yum install nginx -y
 if [ $? -ne 0 ]
 then
     echo "installing nginx is failed"
     else
         echo "nginx is installed successfully"