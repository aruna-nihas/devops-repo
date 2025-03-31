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

dnf install maven -y &>> $LOGFILE

VALIDATE $? "Installed maven"

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

curl -L -o /tmp/shipping.zip https://roboshop-builds.s3.amazonaws.com/shipping.zip &>> $LOGFILE

VALIDATE $? "downloaded shipping application"

cd /app

mvn clean package &>> $LOGFILE

mv target/shipping-1.0.jar shipping.jar &>> $LOGFILE

cp /home/ec2-user/devops-repo/roboshop-shell/shipping.service /etc/systemd/system/shipping.service &>> $LOGFILE

VALIDATE $? "copied shipping service"

systemctl daemon-reload &>> $LOGFILE

VALIDATE $? "reloaded shipping service"

systemctl enable shipping &>> $LOGFILE

VALIDATE $? "enabled shipping service"

systemctl start shipping &>> $LOGFILE

VALIDATE $? "started shipping service"

dnf install mysql -y &>> $LOGFILE

VALIDATE $? "installed mysql"

mysql -h <MYSQL-SERVER-IPADDRESS> -uroot -pRoboShop@1 < /app/db/schema.sql &>> $LOGFILE

mysql -h <MYSQL-SERVER-IPADDRESS> -uroot -pRoboShop@1 < /app/db/app-user.sql &>> $LOGFILE

mysql -h <MYSQL-SERVER-IPADDRESS> -uroot -pRoboShop@1 < /app/db/master-data.sql &>> $LOGFILE

systemctl restart shipping &>> $LOGFILE

VALIDATE $? "restarted shipping"