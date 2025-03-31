#!/bin/bash
ID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
TIMESTAMP=$(date +%F-%H-%M-%S)
LOGFILE="/tmp/$0-$TIMESTAMP.log"
echo -e "$G The script started at $TIMESTAMP $N"

VALIDATE(){
    if [ $1 -ne 0 ]
    then 
        echo -e "$2....$R Failed $N"
        else
            echo -e "$2....$G successful $N"
    fi
}
if [ $ID -ne 0 ]
then
    echo -e "$R ERROR....Plz use root user $N"
    exit 1
    else
        echo -e "$Y u r a root user $N"
fi

dnf install mysql-server -y &>> $LOGFILE

VALIDATE $? "Installed mysql server"

systemctl enable mysqld &>> $LOGFILE


VALIDATE $? "Enabled mysql server"

systemctl start mysqld &>> $LOGFILE


VALIDATE $? "Started mysql server"

mysql_secure_installation --set-root-pass RoboShop@1 &>> $LOGFILE

VALIDATE $? "Set password"

mysql -uroot -pRoboShop@1 &>> $LOGFILE

VALIDATE $? "Set user"