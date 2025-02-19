#!/bin/bash
ID=$(id -u)
TIMESTAMP=$(date +%F-%H:%M:%S)
LOGFILE="/tmp/$0-$TIMESTAMP.log"
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
    echo " $2 installing is failed...."
    else
       echo "$2 installed successfully...."
fi
}
 yum install mysql -y &>> $LOGFILE
 VALIDATE $? "MYSQL"
 yum install nginx -y &>> $LOGFILE
 VALIDATE $? "nginx "