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

dnf install redis -y &>> $LOGFILE

VALIDATE $? "Installed redis"

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/redis/redis.conf &>> $LOGFILE

VALIDATE $? "Added remote"

systemctl enable redis &>> $LOGFILE

VALIDATE $? "Enabled redis"

systemctl start redis &>> $LOGFILE

VALIDATE $? "started redis"