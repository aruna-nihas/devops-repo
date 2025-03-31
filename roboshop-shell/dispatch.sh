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

dnf install golang -y &>> $LOGFILE

VALIDATE $? "Installed golang"

id roboshop
if [ $? -ne 0 ]
then
    useradd roboshop

    VALIDATE $? "roboshop id added"

    else
        echo -e "$Y roboshop user already exist $N"
fi
mkdir /app

VALIDATE $? "app dir created"

curl -L -o /tmp/dispatch.zip https://roboshop-builds.s3.amazonaws.com/dispatch.zip &>> $LOGFILE

VALIDATE $? "downloaded dispatch app"

cd /app

unzip -o /tmp/dispatch.zip &>> $LOGFILE

VALIDATE $? "unzipped dispatch application"

go mod init dispatch
go get 
go build

cp /home/ec2-user/devops-repo/roboshop-shell/dispatch.service /etc/systemd/system/dispatch.service &>> $LOGFILE

VALIDATE $? "copied dispatch servie into systemd"

systemctl daemon-reload &>> $LOGFILE

VALIDATE $? "reloaded dispatch service"

systemctl enable dispatch &>> $LOGFILE 

VALIDATE $? "enabled dispatch service"

systemctl start dispatch &>> $LOGFILE

VALIDATE $? "started dispatch service"

