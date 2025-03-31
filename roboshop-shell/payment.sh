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

dnf install python3.11 gcc python3-devel -y &>> $LOGFILE

VALIDATE $? "installed python"

id roboshop 
if [ $? -ne 0 ]
then
    useradd roboshop

    VALIDATE $? "roboshop user added"
    else
        echo -e "$Y roboshop user already exist $N"
fi

mkdir /app 

VALIDATE $? "app dir created"

curl -L -o /tmp/payment.zip https://roboshop-builds.s3.amazonaws.com/payment.zip &>> $LOGFILE

VALIDATE $? "payment app downloaded"

cd /app 

unzip -o /tmp/payment.zip &>> $LOGFILE

VALIDATE $? "unzipped payment app"

pip3.11 install -r requirements.txt &>> $LOGFILE

cp /home/ec2-user/devops-repo/roboshop-shell/payment.service /etc/systemd/system/payment.service &>> $LOGFILE

VALIDATE $? "copied payment service"

systemctl daemon-reload &>> $LOGFILE

VALIDATE $? "reloaded payment service"

systemctl enable payment &>> $LOGFILE

VALIDATE $? "enabled payment service"

systemctl start payment &>> $LOGFILE

VALIDATE $? "started payment service"



